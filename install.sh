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

# Zed config
link "$DOTS_DIR/zed/settings.json"                          "$HOME/.config/zed/settings.json"
link "$DOTS_DIR/zed/keymap.json"                            "$HOME/.config/zed/keymap.json"
link "$DOTS_DIR/zed/themes/cursor-dark-anysphere.json"      "$HOME/.config/zed/themes/cursor-dark-anysphere.json"

# Zed extensions (installed by symlinking into Zed's extensions directory)
ZED_EXT_DIR="$HOME/Library/Application Support/Zed/extensions/installed"
mkdir -p "$ZED_EXT_DIR"
for ext in "$DOTS_DIR/zed/extensions"/*/; do
  [[ -d "$ext" ]] || continue
  ext_name="$(basename "$ext")"
  link "${ext%/}" "$ZED_EXT_DIR/$ext_name"
done

echo
echo "done. restart Zed to pick up changes."
echo "to use the Seti icon theme: open Zed settings and set \"icon_theme\": \"Seti (Cursor)\"."
