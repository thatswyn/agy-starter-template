#!/usr/bin/env bash
# PreInvocation
#
# Analiza el prompt o contexto y, si detecta que alguna skill del proyecto es
# relevante, la sugiere como contexto adicional o ephemeral message antes de que Antigravity responda.
#
# Toda la lógica vive en skill-eval.cjs; las reglas en skill-rules.json.
# Si no hay Node, es un no-op silencioso devolviendo `{}`.

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NODE_SCRIPT="$SCRIPT_DIR/skill-eval.cjs"

if ! command -v node >/dev/null 2>&1 || [ ! -f "$NODE_SCRIPT" ]; then
  echo "{}"
  exit 0
fi

cat | node "$NODE_SCRIPT" 2>/dev/null || echo "{}"

exit 0
