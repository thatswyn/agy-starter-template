#!/usr/bin/env bash
# PostToolUse (write_to_file|replace_file_content)
#
# Formatea el archivo recién escrito con el formateador que el proyecto ya
# tenga instalado. Agnóstico de stack: si no encuentra la herramienta, no hace
# nada. Nunca descarga paquetes y nunca bloquea.
#
# En el protocolo de hooks de Antigravity:
# Devuelve un objeto JSON vacío `{}` en stdout.

set -uo pipefail

finish() {
  echo "{}"
  exit 0
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/json.sh
if [ -f "$SCRIPT_DIR/lib/json.sh" ]; then
  . "$SCRIPT_DIR/lib/json.sh"
  read_hook_input
  file="$(json_get toolCall.args.TargetFile)"
else
  finish
fi

[ -n "$file" ] && [ -f "$file" ] || finish

root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

# Devuelve la ruta de un binario si existe en node_modules/.bin o en el PATH.
bin() {
  if [ -x "$root/node_modules/.bin/$1" ]; then
    echo "$root/node_modules/.bin/$1"
  elif command -v "$1" >/dev/null 2>&1; then
    command -v "$1"
  fi
}

run() { "$@" >/dev/null 2>&1 || true; }

case "$file" in
  *.js|*.jsx|*.mjs|*.cjs|*.ts|*.tsx|*.json|*.jsonc|*.css|*.scss|*.less|*.html|*.vue|*.svelte|*.md|*.yml|*.yaml)
    if b="$(bin biome)"        && [ -n "$b" ]; then run "$b" format --write "$file"
    elif b="$(bin prettier)"   && [ -n "$b" ]; then run "$b" --write --ignore-unknown "$file"
    elif b="$(bin dprint)"     && [ -n "$b" ]; then run "$b" fmt "$file"
    fi
    ;;
  *.py)
    if b="$(bin ruff)"         && [ -n "$b" ]; then run "$b" format "$file"
    elif b="$(bin black)"      && [ -n "$b" ]; then run "$b" -q "$file"
    fi
    ;;
  *.go)
    if b="$(bin gofmt)"        && [ -n "$b" ]; then run "$b" -w "$file"; fi
    ;;
  *.rs)
    if b="$(bin rustfmt)"      && [ -n "$b" ]; then run "$b" --edition 2021 "$file"; fi
    ;;
  *.rb)
    if b="$(bin rubocop)"      && [ -n "$b" ]; then run "$b" -a "$file"; fi
    ;;
  *.sh|*.bash)
    if b="$(bin shfmt)"        && [ -n "$b" ]; then run "$b" -w "$file"; fi
    ;;
  *.php)
    if b="$(bin php-cs-fixer)" && [ -n "$b" ]; then run "$b" fix "$file"; fi
    ;;
esac

finish
