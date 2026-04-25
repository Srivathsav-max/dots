# dots

Personal dotfiles. Symlink-based — clone, run `install.sh`, restart the app.

## Layout

```
dots/
├── zed/
│   ├── settings.json
│   ├── keymap.json
│   ├── themes/
│   │   └── cursor-dark-anysphere.json   # faithful port of Cursor.app's "Cursor Dark Anysphere v0.0.3"
│   └── extensions/
│       └── seti-cursor/                 # Seti icon theme ported from Cursor.app (383 SVGs, 501 ext mappings)
└── install.sh
```

Add new tools as siblings to `zed/` (e.g. `nvim/`, `ghostty/`, `git/`) and extend `install.sh` with a new `link` line.

## Setup

```sh
git clone https://github.com/Srivathsav-max/dots.git ~/dots
cd ~/dots
./install.sh
```

`install.sh` symlinks each tracked file into the right place under `~/.config/`. If a file already exists at the destination, it's moved to `<file>.backup.<timestamp>` first — nothing gets silently overwritten.

## What's included

### Zed

- **Cursor Dark Anysphere theme** — translated from the Cursor.app bundle (`/Applications/Cursor.app/Contents/Resources/app/extensions/theme-cursor/themes/cursor-dark-color-theme.json`). All workbench colors mapped 1:1 against Zed's v0.2.0 schema; alpha-channel text colors pre-blended against the editor background to avoid Zed's brighter-than-Cursor text rendering.
- **Seti (Cursor) icon theme** — Cursor ships Seti icons as a single `.woff` font with 385 glyphs, but Zed icon themes need individual SVGs. The 383 glyphs were extracted with `fontTools` (each glyph drawn through `SVGPathPen` and emitted as a standalone SVG with its Seti color baked in). Seti's `languageIds` mapping was flattened to per-extension entries by scanning every `package.json` in `Cursor.app/Contents/Resources/app/extensions/` for `contributes.languages`. Final coverage: 192 file icons, 501 extension mappings, 170 filename-stem mappings. Folder and chevron icons added (Seti doesn't ship them — VS Code paints its own).
- **Editor font** — Menlo 14, matching Cursor's macOS default (so font weight and metrics line up between the two editors).

To switch to the Seti icon theme after install: open Zed settings and set `"icon_theme": "Seti (Cursor)"`.

### Not tracked

- `zed/prompts/` (LMDB runtime data)
- `zed/extensions/`, `zed/db/`, `zed/conversations/` (local state)
