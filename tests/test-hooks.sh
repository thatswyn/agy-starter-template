#!/usr/bin/env bash
# Suite de pruebas automatizadas para los hooks de Antigravity
# Ejecuta validaciones deterministas de protect-branch.sh, auto-format.sh, lib/json.sh y skill-eval.

set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOOKS_DIR="$REPO_ROOT/.agents/hooks"
PASSED=0
FAILED=0

pass() {
  echo "  ✅ $1"
  PASSED=$((PASSED + 1))
}

fail() {
  echo "  ❌ $1" >&2
  FAILED=$((FAILED + 1))
}

assert_contains() {
  local output="$1"
  local expected="$2"
  local msg="$3"
  if echo "$output" | grep -q "$expected"; then
    pass "$msg"
  else
    fail "$msg (Esperaba '$expected' en: '$output')"
  fi
}

echo "=== 1. Validando lib/json.sh ==="
(
  # shellcheck source=../.agents/hooks/lib/json.sh
  . "$HOOKS_DIR/lib/json.sh"
  export HOOK_INPUT='{"toolCall":{"name":"write_to_file","args":{"TargetFile":"src/main.ts"}},"number":42}'
  
  target="$(json_get toolCall.args.TargetFile)"
  if [ "$target" = "src/main.ts" ]; then
    pass "json_get extrae rutas anidadas correctamente"
  else
    fail "json_get falló extrayendo rutas anidadas (obtenido: '$target')"
  fi

  missing="$(json_get toolCall.args.NonExistent)"
  if [ -z "$missing" ]; then
    pass "json_get devuelve cadena vacía para claves inexistentes"
  else
    fail "json_get devolvió valor para clave inexistente"
  fi
)

echo "=== 2. Validando protect-branch.sh ==="
# Test 2.1: En directorio no-git
(
  tmp_nogit="$(mktemp -d)"
  trap 'rm -rf "$tmp_nogit"' EXIT
  cd "$tmp_nogit"
  out="$(echo '{}' | bash "$HOOKS_DIR/protect-branch.sh")"
  assert_contains "$out" '"decision":"allow"' "protect-branch permite escritura fuera de un repositorio git"
)

# Test 2.2: En repositorio git sobre rama protegida
(
  tmp_git="$(mktemp -d)"
  trap 'rm -rf "$tmp_git"' EXIT
  cd "$tmp_git"
  git init -q -b main
  git config user.email "test@example.com"
  git config user.name "Test"
  git commit -q --allow-empty -m "init"
  
  out="$(echo '{}' | bash "$HOOKS_DIR/protect-branch.sh")"
  assert_contains "$out" '"decision":"deny"' "protect-branch deniega escritura en rama main"
  assert_contains "$out" "Estás en la rama protegida" "protect-branch incluye razón explicativa"
)

# Test 2.3: En repositorio git sobre rama de trabajo
(
  tmp_git="$(mktemp -d)"
  trap 'rm -rf "$tmp_git"' EXIT
  cd "$tmp_git"
  git init -q -b main
  git config user.email "test@example.com"
  git config user.name "Test"
  git commit -q --allow-empty -m "init"
  git checkout -q -b feat/mi-funcionalidad

  out="$(echo '{}' | bash "$HOOKS_DIR/protect-branch.sh")"
  assert_contains "$out" '"decision":"allow"' "protect-branch permite escritura en rama de trabajo"
)

# Test 2.4: Variables AGY_PROTECTED_BRANCHES personalizadas
(
  tmp_git="$(mktemp -d)"
  trap 'rm -rf "$tmp_git"' EXIT
  cd "$tmp_git"
  git init -q -b develop
  git config user.email "test@example.com"
  git config user.name "Test"
  git commit -q --allow-empty -m "init"

  export AGY_PROTECTED_BRANCHES="develop staging"
  out="$(echo '{}' | bash "$HOOKS_DIR/protect-branch.sh")"
  assert_contains "$out" '"decision":"deny"' "protect-branch respeta AGY_PROTECTED_BRANCHES personalizado"
)

echo "=== 3. Validando auto-format.sh ==="
# Test 3.1: Sin payload
(
  out="$(echo '' | bash "$HOOKS_DIR/auto-format.sh")"
  assert_contains "$out" "{}" "auto-format devuelve {} ante entrada vacía"
)

# Test 3.2: Archivo inexistente o extensión no soportada
(
  payload='{"toolCall":{"args":{"TargetFile":"no_existe.xyz"}}}'
  out="$(echo "$payload" | bash "$HOOKS_DIR/auto-format.sh")"
  assert_contains "$out" "{}" "auto-format no rompe ante archivo inexistente o desconocido"
)

# Test 3.3: Archivo real sin formateador instalado
(
  tmp_file="$(mktemp /tmp/test_file.XXXXXX.ts)"
  trap 'rm -f "$tmp_file"' EXIT
  echo "const x = 1;" > "$tmp_file"
  payload="{\"toolCall\":{\"args\":{\"TargetFile\":\"$tmp_file\"}}}"
  out="$(echo "$payload" | bash "$HOOKS_DIR/auto-format.sh")"
  assert_contains "$out" "{}" "auto-format devuelve {} y nunca bloquea si no hay formateador"
)

echo "=== 4. Validando skill-eval.sh y skill-eval.cjs ==="
if command -v node >/dev/null 2>&1; then
  # Test 4.1: Detección de skill lean-validation
  payload_idea='{"prompt":"Quiero validar una idea de negocio y estimar el mercado con hipótesis"}'
  out_idea="$(echo "$payload_idea" | bash "$HOOKS_DIR/skill-eval.sh")"
  assert_contains "$out_idea" "lean-validation" "skill-eval detecta la skill lean-validation ante vocabulario de negocio"

  # Test 4.2: Detección de testing-patterns
  payload_test='{"prompt":"Escribe pruebas unitarias con mocks y tests para el servicio"}'
  out_test="$(echo "$payload_test" | bash "$HOOKS_DIR/skill-eval.sh")"
  assert_contains "$out_test" "testing-patterns" "skill-eval detecta testing-patterns ante vocabulario de tests"

  # Test 4.3: Entrada vacía
  out_empty="$(echo '{}' | bash "$HOOKS_DIR/skill-eval.sh")"
  assert_contains "$out_empty" "{}" "skill-eval devuelve {} cuando no hay skills sugeridas"
else
  echo "  ⚠️ Node no disponible, saltando pruebas de skill-eval"
fi

echo "=== 5. Integridad sintáctica de configuraciones JSON ==="
if command -v node >/dev/null 2>&1; then
  for j in "$REPO_ROOT/.agents/settings.json" "$REPO_ROOT/.agents/hooks.json" "$REPO_ROOT/.agents/hooks/skill-rules.json"; do
    if node -e "JSON.parse(require('fs').readFileSync('$j','utf8'))" 2>/dev/null; then
      pass "JSON válido: $(basename "$j")"
    else
      fail "JSON corrupto o inválido: $(basename "$j")"
    fi
  done
fi

echo "----------------------------------------"
echo "Resultados: $PASSED superadas, $FAILED fallidas"
if [ "$FAILED" -gt 0 ]; then
  exit 1
fi
echo "✅ Todas las pruebas de hooks y configuración superadas con éxito."
exit 0
