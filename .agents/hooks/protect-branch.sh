#!/usr/bin/env bash
# PreToolUse (write_to_file|replace_file_content)
#
# Impide editar archivos estando en una rama protegida en Antigravity. Fuerza el hábito de
# "una rama por cambio" sin depender de que te acuerdes.
#
# Configurable con la variable de entorno AGY_PROTECTED_BRANCHES en
# .agents/settings.json o el entorno (lista separada por espacios). Por defecto: main master.
#
# En el protocolo de hooks de Antigravity:
# - Devuelve JSON en stdout con decision: "deny" o "allow".
# - En modo manual/test en terminal interactiva, sale con código 2 para comprobación rápida.

set -uo pipefail

allow() {
  if [ ! -t 0 ]; then
    echo '{"decision":"allow"}'
  fi
  exit 0
}

deny() {
  local branch="$1"
  local reason="Estás en la rama protegida '$branch'. Crea una rama antes de editar: git checkout -b {{iniciales}}/descripcion-corta (Para desactivar este bloqueo, quita protect-branch de .agents/hooks.json o ajusta AGY_PROTECTED_BRANCHES)"
  
  if [ -t 0 ]; then
    # Modo test interactivo por terminal
    echo "Estás en la rama protegida '$branch'. Crea una rama antes de editar:" >&2
    echo "  git checkout -b {{iniciales}}/descripcion-corta" >&2
    echo "(Para desactivar este bloqueo, quita el hook protect-branch.sh de .agents/hooks.json)" >&2
    exit 2
  else
    # Protocolo Antigravity Hook
    echo "{\"decision\":\"deny\",\"reason\":\"$reason\"}"
    exit 0
  fi
}

command -v git >/dev/null 2>&1 || allow
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || allow

branch="$(git branch --show-current 2>/dev/null)"
[ -n "$branch" ] || allow   # detached HEAD: no bloqueamos

protected="${AGY_PROTECTED_BRANCHES:-main master}"

for p in $protected; do
  if [ "$branch" = "$p" ]; then
    deny "$branch"
  fi
done

allow
