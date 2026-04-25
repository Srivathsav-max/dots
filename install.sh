#!/usr/bin/env bash
set -euo pipefail

DOTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [[ -e "$dst" || -L "$dst" ]]; then
    if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
      echo "ok    $dst (already linked)"
      return
    fi
    local backup="$dst.backup.$(date +%Y%m%d%H%M%S)"
    mv "$dst" "$backup"
    echo "saved $dst -> $backup"
  fi
  ln -s "$src" "$dst"
  echo "link  $dst -> $src"
}

# Zed
link "$DOTS_DIR/zed/settings.json"                          "$HOME/.config/zed/settings.json"
link "$DOTS_DIR/zed/keymap.json"                            "$HOME/.config/zed/keymap.json"
link "$DOTS_DIR/zed/themes/cursor-dark-anysphere.json"      "$HOME/.config/zed/themes/cursor-dark-anysphere.json"

echo
echo "done. restart Zed to pick up changes."
