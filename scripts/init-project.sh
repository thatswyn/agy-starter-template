#!/usr/bin/env bash
# scripts/init-project.sh
# Inicializador rápido de proyectos para Antigravity Starter Template (v2)
# Configura AGENTS.md, poda roles innecesarios y aplica presets por stack sin fricción.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AGENTS_MD="$REPO_ROOT/AGENTS.md"
SETTINGS_JSON="$REPO_ROOT/.agents/settings.json"

NAME=""
DESC=""
TYPE="both"
PRESET="custom"
OWNER="$(git config user.name 2>/dev/null || echo "Desarrollador")"
INTERACTIVE=true

usage() {
  cat <<EOF
Uso: $0 [opciones]

Opciones:
  -n, --name <nombre>       Nombre del proyecto
  -d, --desc <descripcion>  Descripción breve (qué problema resuelve)
  -t, --type <tipo>         Tipo: 'software', 'business' o 'both' (defecto: both)
  -p, --preset <preset>     Stack: 'nextjs', 'fastapi', 'go', 'rust', 'business', 'custom'
  -o, --owner <nombre>      Nombre del responsable
      --non-interactive     Modo desatendido (no solicita confirmación)
  -h, --help                Muestra esta ayuda

Presets disponibles:
  nextjs   - TypeScript, Next.js, Tailwind, Biome, Vitest (pnpm)
  fastapi  - Python, FastAPI, Pydantic, Ruff, Pytest (uv)
  go       - Go, Gin, SQLX, Golangci-lint (go)
  rust     - Rust, Axum, SQLx, Clippy (cargo)
  business - Solo validación lean de negocio (sin código inicial)
  custom   - Configuración manual
EOF
  exit 0
}

while [ $# -gt 0 ]; do
  case "$1" in
    -n|--name) NAME="$2"; shift 2 ;;
    -d|--desc) DESC="$2"; shift 2 ;;
    -t|--type) TYPE="$2"; shift 2 ;;
    -p|--preset) PRESET="$2"; shift 2 ;;
    -o|--owner) OWNER="$2"; shift 2 ;;
    --non-interactive) INTERACTIVE=false; shift ;;
    -h|--help) usage ;;
    *) echo "Opción desconocida: $1" >&2; usage ;;
  esac
done

echo "🚀 Inicializador de Antigravity Starter Template (v2)"
echo "----------------------------------------------------"

if [ "$INTERACTIVE" = true ]; then
  if [ -z "$NAME" ]; then
    read -rp "1. Nombre del proyecto: " input_name
    NAME="${input_name:-mi-proyecto}"
  fi

  if [ -z "$DESC" ]; then
    read -rp "2. ¿Qué problema resuelve? (1 frase): " input_desc
    DESC="${input_desc:-Proyecto creado con agy-starter-template.}"
  fi

  echo "3. Tipo de proyecto:"
  echo "   1) Software + Negocio (recomendado - camino dual completo)"
  echo "   2) Puramente software (poda roles de negocio)"
  echo "   3) Solo validación de idea de negocio (sin código inicial)"
  read -rp "Selecciona una opción [1-3] (defecto: 1): " opt_type
  case "$opt_type" in
    2) TYPE="software" ;;
    3) TYPE="business"; PRESET="business" ;;
    *) TYPE="both" ;;
  esac

  if [ "$TYPE" != "business" ] && [ "$PRESET" = "custom" ]; then
    echo "4. Preset tecnológico:"
    echo "   1) TypeScript + Next.js (Tailwind, Biome, Vitest, pnpm)"
    echo "   2) Python + FastAPI (Pydantic, Ruff, Pytest, uv)"
    echo "   3) Go + Gin (SQLX, Golangci-lint)"
    echo "   4) Rust + Axum (SQLx, Cargo, Clippy)"
    echo "   5) Personalizado / A mano"
    read -rp "Selecciona un preset [1-5] (defecto: 1): " opt_preset
    case "$opt_preset" in
      2) PRESET="fastapi" ;;
      3) PRESET="go" ;;
      4) PRESET="rust" ;;
      5) PRESET="custom" ;;
      *) PRESET="nextjs" ;;
    esac
  fi
fi

NAME="${NAME:-mi-proyecto}"
DESC="${DESC:-Proyecto creado con agy-starter-template.}"

echo ""
echo "Configurando proyecto: $NAME"
echo "Tipo: $TYPE | Preset: $PRESET | Responsable: $OWNER"
echo ""

if [ "$TYPE" = "business" ] && [ "$PRESET" = "custom" ]; then
  PRESET="business"
fi

# 1. Poda de módulos según tipo de proyecto
if [ "$TYPE" = "software" ]; then
  echo "🧹 Podando módulos de negocio innecesarios..."
  rm -f "$REPO_ROOT/.agents/agents/"{business-analyst,market-researcher,product-strategist}.md
  rm -rf "$REPO_ROOT/.agents/skills/"{lean-validation,idea}
  rm -rf "$REPO_ROOT/docs/product"
  # Quitar lean-validation de skill-rules.json si existe Node
  if command -v node >/dev/null 2>&1; then
    node -e '
      const fs = require("fs");
      const p = process.argv[1];
      const data = JSON.parse(fs.readFileSync(p, "utf8"));
      delete data.skills["lean-validation"];
      delete data.directoryMappings["docs/product/"];
      fs.writeFileSync(p, JSON.stringify(data, null, 2) + "\n");
    ' "$REPO_ROOT/.agents/hooks/skill-rules.json" 2>/dev/null || true
  fi
elif [ "$TYPE" = "business" ]; then
  echo "🧹 Podando herramientas y workflows de código..."
  rm -rf "$REPO_ROOT/.agents/skills/"{testing-patterns,systematic-debugging,code-quality,pr-review,pr-summary}
  rm -rf "$REPO_ROOT/.github"
fi

# 2. Reemplazo de metadatos básicos en AGENTS.md
sed -i "s/{{NOMBRE_DEL_PROYECTO}}/$NAME/g" "$AGENTS_MD"
sed -i "s/{{TU_NOMBRE}}/$OWNER/g" "$AGENTS_MD"
sed -i "s/{{software | idea de negocio | ambos}}/$TYPE/g" "$AGENTS_MD"
sed -i "s/{{exploración | prototipo | validación | producción}}/exploración/g" "$AGENTS_MD"

python3 -c '
import sys
path = sys.argv[1]
desc = sys.argv[2]
with open(path, "r", encoding="utf-8") as f:
    c = f.read()
target = "{{Una o dos frases concisas: qué problema resuelve el proyecto y para quién. Si es una idea de negocio sin código, define la hipótesis que estás validando.}}"
c = c.replace(target, desc)
with open(path, "w", encoding="utf-8") as f:
    f.write(c)
' "$AGENTS_MD" "$DESC" 2>/dev/null || true

# Limpieza de placeholders secundarios de git y notas
INITIALS=$(echo "$OWNER" | tr '[:upper:]' '[:lower:]' | awk '{print substr($1,1,2)}')
INITIALS="${INITIALS:-dev}"
sed -i "s|{{iniciales}}/{{descripcion}}|$INITIALS/nueva-funcionalidad|g" "$AGENTS_MD"
sed -i "s|{{iniciales}}/{{descripcion-corta}}|$INITIALS/nueva-funcionalidad|g" "$AGENTS_MD"
sed -i "s|Rellena los {{PLACEHOLDERS}} o usa /setup para aplicar presets automáticos\. ||g" "$AGENTS_MD"
sed -i "s|{{PLACEHOLDERS}}||g" "$AGENTS_MD"
sed -i "s|- {{p. ej. \"La migración inicial requiere 2 minutos; no interrumpir el proceso.\"}}|- Documenta aquí peculiaridades del entorno cuando se descubran.|g" "$AGENTS_MD"

# 3. Aplicar comandos según el Preset
apply_preset() {
  local lang="$1"
  local pkg="$2"
  local db="$3"
  local dev="$4"
  local test="$5"
  local lint="$6"
  local typecheck="$7"
  local build="$8"

  sed -i "s|{{TypeScript + Next.js / Python + FastAPI / Go / Rust}}|$lang|g" "$AGENTS_MD"
  sed -i "s|{{npm \| pnpm \| uv \| poetry \| cargo \| go}}|$pkg|g" "$AGENTS_MD"
  sed -i "s|{{PostgreSQL + Prisma / SQLite / Supabase}}|$db|g" "$AGENTS_MD"

  sed -i "s|{{npm run dev}}|$dev|g" "$AGENTS_MD"
  sed -i "s|{{npm test}}|$test|g" "$AGENTS_MD"
  sed -i "s|{{npm run lint}}|$lint|g" "$AGENTS_MD"
  sed -i "s|{{npm run typecheck}}|$typecheck|g" "$AGENTS_MD"
  sed -i "s|{{npm run build}}|$build|g" "$AGENTS_MD"
  sed -i "s|{{src/}}|src/|g" "$AGENTS_MD"
  sed -i "s|{{Código fuente de la aplicación}}|Código fuente de la aplicación|g" "$AGENTS_MD"
}

case "$PRESET" in
  nextjs)
    echo "📦 Aplicando preset TypeScript / Next.js..."
    apply_preset "TypeScript + Next.js" "pnpm" "PostgreSQL + Prisma / Supabase" \
      "pnpm dev" "pnpm test" "pnpm biome check" "pnpm tsc --noEmit" "pnpm build"
    ;;
  fastapi)
    echo "📦 Aplicando preset Python / FastAPI..."
    apply_preset "Python + FastAPI" "uv" "PostgreSQL + SQLAlchemy" \
      "uv run uvicorn src.main:app --reload" "uv run pytest" "uv run ruff check ." "uv run mypy src" "uv run python -m compileall src"
    ;;
  go)
    echo "📦 Aplicando preset Go / Gin..."
    apply_preset "Go + Gin" "go" "PostgreSQL + SQLX" \
      "go run ./cmd/api" "go test ./..." "golangci-lint run" "go vet ./..." "go build -o bin/api ./cmd/api"
    ;;
  rust)
    echo "📦 Aplicando preset Rust / Axum..."
    apply_preset "Rust + Axum" "cargo" "PostgreSQL + SQLx" \
      "cargo run" "cargo test" "cargo clippy" "cargo check" "cargo build --release"
    ;;
  business)
    echo "💼 Aplicando preset Solo Negocio..."
    python3 -c '
import sys, re
path = sys.argv[1]
with open(path, "r", encoding="utf-8") as f:
    c = f.read()
c = re.sub(r"## Stack y comandos habituales.*?(?=## Mapa del repositorio)", "", c, flags=re.DOTALL)
with open(path, "w", encoding="utf-8") as f:
    f.write(c)
' "$AGENTS_MD" 2>/dev/null || true
    sed -i "/{{src\/}}/d" "$AGENTS_MD"
    ;;
  *)
    echo "ℹ️ Modo personalizado: los comandos se mantienen listos para rellenar."
    ;;
esac

# 4. Validar que la configuración JSON siga íntegra
if [ -f "$REPO_ROOT/tests/test-hooks.sh" ]; then
  echo "🧪 Comprobando integridad del arnés..."
  if ! bash "$REPO_ROOT/tests/test-hooks.sh"; then
    echo "⚠️ Advertencia: Se detectaron fallos en la validación de hooks. Revisa la salida anterior." >&2
  fi
fi

echo ""
echo "✨ ¡Proyecto inicializado con éxito!"
echo "Archivos clave preparados:"
echo "  - AGENTS.md (y GEMINI.md) configurado para $NAME"
echo "  - Hooks y tests operativos"
echo ""
echo "Siguientes pasos sugeridos:"
echo "  - agy                  (para abrir la consola de Antigravity)"
echo "  - /onboard             (para explorar tareas y código inicial)"
echo "  - /plan                (para diseñar tu primer cambio)"
echo ""
