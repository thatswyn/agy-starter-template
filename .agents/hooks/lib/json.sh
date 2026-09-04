#!/usr/bin/env bash
# Helper compartido por los hooks de Antigravity.
#
# Antigravity entrega a cada hook un objeto JSON por stdin. Este helper lo lee
# una vez en $HOOK_INPUT y expone json_get para extraer campos por ruta
# separada por puntos, p. ej.: json_get toolCall.args.TargetFile
#
# Usa jq si está disponible; si no, python3; si no, node. Si no hay ninguno,
# devuelve vacío y el hook debe comportarse como no-op (nunca romper la sesión).

read_hook_input() {
  HOOK_INPUT="$(cat)"
  export HOOK_INPUT
}

json_get() {
  local path="$1"
  [ -n "${HOOK_INPUT:-}" ] || return 0

  if command -v jq >/dev/null 2>&1; then
    printf '%s' "$HOOK_INPUT" | jq -r --arg p "$path" \
      'try (getpath($p | split(".")) // empty) catch empty' 2>/dev/null
  elif command -v python3 >/dev/null 2>&1; then
    printf '%s' "$HOOK_INPUT" | python3 -c '
import sys, json
try:
    d = json.load(sys.stdin)
except Exception:
    sys.exit(0)
for k in sys.argv[1].split("."):
    d = d.get(k) if isinstance(d, dict) else None
    if d is None:
        break
print(d if d is not None else "")
' "$path" 2>/dev/null
  elif command -v node >/dev/null 2>&1; then
    printf '%s' "$HOOK_INPUT" | node -e '
let s = "";
process.stdin.on("data", d => s += d).on("end", () => {
  try {
    const v = process.argv[1].split(".").reduce((a, k) => (a == null ? a : a[k]), JSON.parse(s));
    if (v != null) process.stdout.write(String(v));
  } catch {}
});' "$path" 2>/dev/null
  fi
}
