# Dotfiles Restructure Design

## Goal

Reorganize the flat dotfiles repo into platform folders (`mac/`, `windows/`, `linux/`) and add WSL Ubuntu as the primary Linux target.

## Structure

```
dotfiles/
├── mac/
│   ├── .aerospace.toml
│   ├── .zshrc
│   ├── .ssh/config
│   ├── .wezterm.lua        → symlink → ../linux/.wezterm.lua
│   └── .config/nvim/       → symlink → ../linux/.config/nvim/
│
├── windows/
│   ├── .glzr/glazewm/config.yaml
│   └── AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup/winmarchy.ahk
│
├── linux/
│   ├── .zshrc
│   ├── .wezterm.lua
│   ├── .ssh/config
│   ├── default-packages
│   └── .config/
│       ├── nvim/
│       └── systemd/user/ssh-agent.service
│
├── docs/plans/
├── README.md
├── KEYBINDS.md
├── .editorconfig
├── .gitattributes
└── .gitignore
```

## Key Decisions

- **`linux/` is canonical** for shared configs (nvim, wezterm, default-packages) — it's the primary environment now (WSL Ubuntu)
- **`mac/` symlinks** to `linux/` for `.wezterm.lua` and `.config/nvim/` since they're identical
- **`windows/` is self-contained** — no cross-platform sharing makes sense across the OS boundary
- **Per-platform `.zshrc` and `.ssh/config`** — they have real differences (Mac SSH uses `UseKeychain yes`; zshrc has different PATH entries)
- **Linux target is WSL Ubuntu** — no nested distro folders (YAGNI)

## README Updates

- Remove Arch Linux section
- Add WSL Ubuntu section with `apt`-based install instructions and WSL-specific SSH agent setup
- Update all symlink paths to reflect new folder structure
