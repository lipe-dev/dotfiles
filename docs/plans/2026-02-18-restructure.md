# Dotfiles Restructure Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Reorganize flat dotfiles into `mac/`, `windows/`, `linux/` platform folders, each mimicking `~`, with `linux/` as canonical for shared configs.

**Architecture:** Move files with `git mv` to preserve history. Create `linux/` as the primary target (WSL Ubuntu). Intra-repo symlinks in `mac/` point to `linux/` for shared configs (nvim, wezterm). Windows is self-contained.

**Tech Stack:** bash, git, zsh, symlinks

---

### Task 1: Create directory structure

**Files:**
- Create: `linux/.config/nvim/` (placeholder, will be filled by git mv)
- Create: `linux/.config/systemd/user/`
- Create: `mac/.config/`
- Create: `windows/.glzr/glazewm/`
- Create: `windows/AppData/`

**Step 1: Create all needed directories**

```bash
mkdir -p linux/.config mac/.config windows
```

**Step 2: Commit**

```bash
git add linux/ mac/ windows/
git commit -m "chore: scaffold mac/ windows/ linux/ directory structure"
```

---

### Task 2: Move Linux configs to `linux/`

**Files:**
- Move: `.zshrc` → `linux/.zshrc`
- Move: `.wezterm.lua` → `linux/.wezterm.lua`
- Move: `.config/nvim/` → `linux/.config/nvim/`
- Move: `.config/systemd/` → `linux/.config/systemd/`
- Move: `default-packages` → `linux/default-packages`

**Step 1: Move files with git mv (preserves history)**

```bash
git mv .zshrc linux/.zshrc
git mv .wezterm.lua linux/.wezterm.lua
git mv .config/nvim linux/.config/nvim
git mv .config/systemd linux/.config/systemd
git mv default-packages linux/default-packages
```

**Step 2: Verify moves look correct**

```bash
git status
```

Expected: all as "renamed:" entries, nothing unexpected.

**Step 3: Commit**

```bash
git commit -m "chore: move linux configs into linux/"
```

---

### Task 3: Create `linux/.ssh/config`

The root `.ssh/config` has `UseKeychain yes` which is Mac-only. Linux needs its own version without it.

**Files:**
- Create: `linux/.ssh/config`

**Step 1: Create the file**

```
mkdir -p linux/.ssh
```

Create `linux/.ssh/config` with this content:

```
Host *
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_rsa
```

**Step 2: Commit**

```bash
git add linux/.ssh/config
git commit -m "chore: add linux ssh config (no UseKeychain)"
```

---

### Task 4: Move Mac configs to `mac/`

**Files:**
- Move: `.aerospace.toml` → `mac/.aerospace.toml`
- Move: `.ssh/config` → `mac/.ssh/config`

**Step 1: Move files**

```bash
mkdir -p mac/.ssh
git mv .aerospace.toml mac/.aerospace.toml
git mv .ssh/config mac/.ssh/config
```

**Step 2: Commit**

```bash
git commit -m "chore: move mac configs into mac/"
```

---

### Task 5: Create `mac/.zshrc`

The root `.zshrc` is Linux-specific (has `/opt/nvim-linux-x86_64/bin` in PATH). Mac needs its own version — identical except that path is removed (nvim is installed via homebrew on Mac and is already in PATH).

**Files:**
- Create: `mac/.zshrc`

**Step 1: Create `mac/.zshrc`**

```zsh
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
export PATH="$HOME/.local/bin:$PATH"
```

**Step 2: Commit**

```bash
git add mac/.zshrc
git commit -m "chore: add mac zshrc (no linux nvim path)"
```

---

### Task 6: Create intra-repo symlinks in `mac/`

`mac/.wezterm.lua` and `mac/.config/nvim/` are identical to the Linux versions. Symlink them to avoid duplication.

**Files:**
- Create: `mac/.wezterm.lua` (symlink)
- Create: `mac/.config/nvim` (symlink)

**Step 1: Create symlinks (relative paths)**

```bash
cd mac
ln -s ../linux/.wezterm.lua .wezterm.lua
mkdir -p .config
cd .config
ln -s ../../linux/.config/nvim nvim
cd ../..
```

**Step 2: Verify symlinks resolve correctly**

```bash
ls -la mac/.wezterm.lua
ls -la mac/.config/nvim
```

Expected: both show `->` pointing to the linux paths.

**Step 3: Commit**

```bash
git add mac/.wezterm.lua mac/.config/nvim
git commit -m "chore: add mac symlinks for shared wezterm and nvim configs"
```

---

### Task 7: Move Windows configs to `windows/`

**Files:**
- Move: `.glzr/` → `windows/.glzr/`
- Move: `AppData/` → `windows/AppData/`

**Step 1: Move files**

```bash
git mv .glzr windows/.glzr
git mv AppData windows/AppData
```

**Step 2: Commit**

```bash
git commit -m "chore: move windows configs into windows/"
```

---

### Task 8: Clean up empty root dirs

After all moves, `.config/` and `.ssh/` at root should be empty.

**Step 1: Remove empty directories**

```bash
rmdir .config .ssh 2>/dev/null; echo "done"
```

Expected: "done" with no errors if they were empty, or error messages if something was left (investigate before proceeding).

**Step 2: Commit if anything changed**

```bash
git status
# only commit if there's something to commit
git add -A
git commit -m "chore: remove empty root dirs after restructure"
```

---

### Task 9: Update README

Replace the current README with updated setup instructions per platform, reflecting:
- New symlink paths (e.g. `linux/.zshrc` instead of `.zshrc`)
- WSL Ubuntu section (new, replaces Arch)
- Remove Arch Linux section

**Files:**
- Modify: `README.md`

**Step 1: Rewrite README.md**

Replace the full content of `README.md` with:

````markdown
# dotfiles

Minimal configs for Mac, Windows (WSL), and Linux (WSL Ubuntu).

## Mac Setup

```bash
# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# basic apps
brew install --cask nikitabobko/tap/aerospace
brew install --cask wezterm
brew install ripgrep
brew install neovim

# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# nvm
ln -sf "$(pwd)/linux/default-packages" $NVM_DIR/default-packages
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
nvm install --lts

# claude code
curl -fsSL https://claude.ai/install.sh | bash

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Mac Symlinks

```bash
ln -sf "$(pwd)/mac/.aerospace.toml" ~/.aerospace.toml
ln -sf "$(pwd)/mac/.wezterm.lua" ~/.wezterm.lua
ln -sf "$(pwd)/mac/.zshrc" ~/.zshrc
mkdir -p ~/.ssh
ln -sf "$(pwd)/mac/.ssh/config" ~/.ssh/config
cargo install --features lsp --locked taplo-cli
rm -rf ~/.config/nvim
ln -sf "$(pwd)/mac/.config/nvim" ~/.config/nvim
```

## Windows Setup

**Note:** Run PowerShell as Administrator for symlink creation.

```powershell
# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install basic tools
winget install Git.Git
winget install Neovim.Neovim
choco install autohotkey
choco install glazewm
```

## Windows Symlinks

```powershell
# GlazeWM
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.glzr\glazewm"
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.glzr\glazewm\config.yaml" -Target "$PWD\windows\.glzr\glazewm\config.yaml"

# AutoHotkey
New-Item -ItemType Directory -Force -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
New-Item -ItemType SymbolicLink -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\winmarchy.ahk" -Target "$PWD\windows\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\winmarchy.ahk"
```

## WSL Ubuntu Setup

```bash
# basic apps
sudo apt update
sudo apt install -y git zsh unzip gcc ripgrep

# nvim (latest binary)
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz

# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# nvm
ln -sf "$(pwd)/linux/default-packages" $NVM_DIR/default-packages
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
nvm install --lts

# claude code
curl -fsSL https://claude.ai/install.sh | bash

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## WSL Ubuntu Symlinks

```bash
chsh -s $(which zsh)
rm ~/.zshrc
ln -sf "$(pwd)/linux/.zshrc" ~/.zshrc
ln -sf "$(pwd)/linux/.wezterm.lua" ~/.wezterm.lua
mkdir -p ~/.ssh
ln -sf "$(pwd)/linux/.ssh/config" ~/.ssh/config
mkdir -p ~/.config/systemd/user
ln -sf "$(pwd)/linux/.config/systemd/user/ssh-agent.service" ~/.config/systemd/user/ssh-agent.service
systemctl --user enable --now ssh-agent
ssh-add
cargo install --features lsp --locked taplo-cli
rm -rf ~/.config/nvim
ln -sf "$(pwd)/linux/.config/nvim" ~/.config/nvim
```
````

**Step 2: Commit**

```bash
git add README.md
git commit -m "docs: update README for new platform folder structure and WSL Ubuntu"
```

---

### Task 10: Final check

**Step 1: Verify repo state**

```bash
git log --oneline -10
find . -not -path './.git/*' -not -path './docs/*' | sort
```

Expected output should show a clean tree with `mac/`, `windows/`, `linux/` and no stray config files at the root.

**Step 2: Verify symlinks in mac/**

```bash
ls -la mac/.wezterm.lua mac/.config/nvim
```

Expected: both resolve to their `linux/` counterparts.
