# dots

Personal dotfiles for macOS. Symlink-based — clone, run `install.sh`, restart the affected apps.

## Layout

```
dots/
├── nvim/                  # Neovim config (Lua, lazy.nvim) — derived from thdxr/environment, customized
├── ghostty/               # Ghostty terminal config
├── zed/                   # Zed editor config + Cursor Dark Anysphere theme + Seti icon theme
├── cursor/                # Cursor.app settings + keybindings
├── windsurf/              # Windsurf settings + keybindings
├── antigravity/           # Antigravity settings + keybindings
├── bin/
│   └── ghostty-here       # opens Ghostty in a given dir; used by VSCode-fork keybinds
├── zsh/
│   └── starship.zsh       # appended to ~/.zshrc; loads starship + adds ~/bin to PATH
├── terminal-app/
│   └── set-font.applescript  # one-shot script to set Nerd Font across all Terminal.app profiles
└── install.sh
```

## Setup

```sh
git clone https://github.com/Srivathsav-max/dots.git ~/dots
cd ~/dots
./install.sh
```

`install.sh` symlinks each tracked file into the right place under `~/.config/` and `~/Library/Application Support/`. If a file already exists at the destination, it's moved to `<file>.backup.<timestamp>` first — nothing gets silently overwritten.

### Prereqs

```sh
brew install neovim ripgrep fd lazygit fzf starship stow
brew install --cask ghostty font-jetbrains-mono-nerd-font font-symbols-only-nerd-font
```

## What's included

### Neovim (`nvim/`)
Started from [thdxr/environment](https://github.com/thdxr/environment) and customized:

- `lazy.nvim` plugin manager, ~38 plugins.
- LSP via Mason (TypeScript/vtsls, Lua, Python, Rust, ESLint, HTML, CSS, Tailwind, JSON, YAML, Bash, Markdown, Docker, Prisma, GraphQL — gopls is opt-in).
- Migrated from deprecated `require("lspconfig")` framework to `vim.lsp.config` / `vim.lsp.enable` (Neovim 0.11+).
- Treesitter, telescope, harpoon, conform.
- Fuzzy AI: Supermaven (free tier) + Avante.nvim + gp.nvim.
- Git: gitsigns (inline hunks/blame), lazygit (full TUI), diffview, fugitive, neogit.
- Floating terminal via toggleterm (`<leader>tt`, `<leader>th`, `<leader>tv`, `<C-\>`).
- nvim-tree pinned to the left as a 36-col sidebar, opens automatically on startup.
- Window navigation: `<C-h>` / `<C-l>` move between windows; `<leader>w` is the `<C-w>` prefix.
- Tokyonight (night) theme.

Leader is `<Space>`. See `nvim/lua/plugins/*.lua` for the full keymap surface.

### Ghostty (`ghostty/`)
- Tokyonight theme.
- `JetBrainsMono Nerd Font Mono` with `Symbols Nerd Font Mono` as glyph fallback.
- Native macOS title bar + tab bar (`window-decoration = true`, `macos-titlebar-style = tabs`).
- `macos-non-native-fullscreen = true`, `window-save-state = always`.
- `ctrl+n`, `ctrl+e`, `ctrl+p`, `ctrl+w`, `ctrl+h`, `ctrl+l` unbound so nvim receives them.

### Zed (`zed/`)
- **Cursor Dark Anysphere theme** — translated from Cursor.app's bundle. All workbench colors mapped 1:1 against Zed's v0.2.0 schema; alpha-channel text colors pre-blended against the editor background.
- **Seti (Cursor) icon theme** — Seti glyphs extracted from Cursor.app's `.woff` bundle into individual SVGs (each glyph drawn through fontTools' `SVGPathPen`). Coverage: 192 file icons, 501 extension mappings, 170 filename-stem mappings.
- **`Cmd+Shift+T` / `Cmd+Alt+T`** — open Ghostty in project root / current file's dir via `tasks.json`.
- Integrated terminal uses `JetBrainsMono Nerd Font Mono`.

### VSCode-fork editors (`cursor/`, `windsurf/`, `antigravity/`)
Same config in each:
- Integrated terminal: `JetBrainsMono Nerd Font Mono`.
- `terminal.external.osxExec` set to Ghostty (best-effort — VSCode hardcodes its supported list, so this often falls back to Terminal.app — see microsoft/vscode#284265).
- **`Cmd+Shift+T`** — try external terminal (uses Ghostty if the fork respects osxExec).
- **`Cmd+Alt+T`** — when integrated terminal is focused, types `ghostty-here "$PWD"` and runs it. Always works.

### Helper scripts (`bin/`)
- `ghostty-here [dir]` — `open -na Ghostty --args --working-directory="$dir"`. Used by all editor keybinds.

### Shell (`zsh/`)
- `starship.zsh` is sourced from `~/.zshrc` (the install script appends the line). Adds `~/bin` to PATH and inits Starship.

### Terminal.app (`terminal-app/`)
- `set-font.applescript` iterates every settings set in Terminal.app and sets the font to `JetBrainsMonoNFM-Regular` at 14pt. Run via `osascript`.

## Not tracked

- `zed/prompts/`, `zed/conversations/`, `zed/db/` (LMDB runtime data)
- `nvim/lazy-lock.json` is tracked for reproducibility; delete it locally and run `:Lazy sync` if you want to update everything to the latest.
