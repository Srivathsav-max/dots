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

# --- Zed ---
link "$DOTS_DIR/zed/settings.json"                          "$HOME/.config/zed/settings.json"
link "$DOTS_DIR/zed/keymap.json"                            "$HOME/.config/zed/keymap.json"
link "$DOTS_DIR/zed/tasks.json"                             "$HOME/.config/zed/tasks.json"
link "$DOTS_DIR/zed/themes/cursor-dark-anysphere.json"      "$HOME/.config/zed/themes/cursor-dark-anysphere.json"

ZED_EXT_DIR="$HOME/Library/Application Support/Zed/extensions/installed"
mkdir -p "$ZED_EXT_DIR"
for ext in "$DOTS_DIR/zed/extensions"/*/; do
  [[ -d "$ext" ]] || continue
  ext_name="$(basename "$ext")"
  link "${ext%/}" "$ZED_EXT_DIR/$ext_name"
done

# --- Neovim (thdxr-derived, customized) ---
link "$DOTS_DIR/nvim"                                       "$HOME/.config/nvim"

# --- Ghostty ---
link "$DOTS_DIR/ghostty"                                    "$HOME/.config/ghostty"

# --- VSCode-fork editors (Cursor / Windsurf / Antigravity) ---
link "$DOTS_DIR/cursor/settings.json"        "$HOME/Library/Application Support/Cursor/User/settings.json"
link "$DOTS_DIR/cursor/keybindings.json"     "$HOME/Library/Application Support/Cursor/User/keybindings.json"
link "$DOTS_DIR/windsurf/settings.json"      "$HOME/Library/Application Support/Windsurf/User/settings.json"
link "$DOTS_DIR/windsurf/keybindings.json"   "$HOME/Library/Application Support/Windsurf/User/keybindings.json"
link "$DOTS_DIR/antigravity/settings.json"   "$HOME/Library/Application Support/Antigravity/User/settings.json"
link "$DOTS_DIR/antigravity/keybindings.json" "$HOME/Library/Application Support/Antigravity/User/keybindings.json"

# --- Helper scripts ---
link "$DOTS_DIR/bin/ghostty-here"                           "$HOME/bin/ghostty-here"

# --- Shell ---
if ! grep -q "dots/zsh/starship.zsh" "$HOME/.zshrc" 2>/dev/null; then
  printf '\n# dots\nsource "%s/zsh/starship.zsh"\n' "$DOTS_DIR" >> "$HOME/.zshrc"
  echo "shell append ~/.zshrc -> source $DOTS_DIR/zsh/starship.zsh"
else
  echo "ok    ~/.zshrc already sources dots/zsh/starship.zsh"
fi

# --- Terminal.app fonts ---
if [[ "$(uname)" == "Darwin" ]]; then
  osascript "$DOTS_DIR/terminal-app/set-font.applescript" >/dev/null 2>&1 \
    && echo "ran   terminal-app/set-font.applescript (Nerd Font applied to all Terminal.app profiles)" \
    || echo "skip  terminal-app font script (Terminal.app not running or no permission)"
fi

echo
echo "done. restart Zed / Cursor / Windsurf / Antigravity / Ghostty to pick up changes."
echo "Zed icon theme: open settings and set \"icon_theme\": \"Seti (Cursor)\"."
