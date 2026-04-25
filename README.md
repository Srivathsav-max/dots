# dots

Personal dotfiles. Symlink-based — clone, run `install.sh`, restart the app.

## Layout

```
dots/
├── zed/
│   ├── settings.json
│   ├── keymap.json
│   └── themes/
│       └── cursor-dark-anysphere.json   # faithful port of Cursor.app's "Cursor Dark Anysphere v0.0.3"
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
- **Editor font** — Menlo 14, matching Cursor's macOS default (so font weight and metrics line up between the two editors).
- **Material Icon Theme** — set as `icon_theme`. Install the extension separately from Zed's Extensions panel.

### Not tracked

- `zed/prompts/` (LMDB runtime data)
- `zed/extensions/`, `zed/db/`, `zed/conversations/` (local state)
