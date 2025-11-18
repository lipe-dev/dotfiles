# dotfiles

This is just a repo with my archlinux/mac stuff that I need for work.
I like keeping stuff as close to default as I can, so I only do minimal changes.

- Change shell to ZSH + Oh My Zsh
- Install basic tools like git and ssh
- Install nvim + modular kickstart + a few of my own configs
- Create some SSH creds for github and such

This repo can be cloned anywhere in my machine and uses simlinks to place
the correct files in the correct places from there.

I am pretty much sold on Omarchy now, so this is basically all the setup I need.

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
ln -sf "$(pwd)/default-packages" $NVM_DIR/default-packages
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
nvm install --lts

# claude code
curl -fsSL https://claude.ai/install.sh | bash

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Windows Setup

**Note:** Run PowerShell as Administrator for symlink creation

```powershell
# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install basic tools
winget install Git.Git
winget install Neovim.Neovim
choco install autohotkey
choco install glazewm

# Disable iCUE Windows key remap if you had it enabled
```

## GlazeWM setup (Windows Only)

```powershell
# Run as Administrator
mkdir -p "$env:USERPROFILE\.glzr\glazewm"
mklink "$env:USERPROFILE\.glzr\glazewm\config.yaml" "$PWD\.glzr\glazewm\config.yaml"
```

## AutoHotkey setup (Windows Only)

```powershell
# Run as Administrator
mkdir -p "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
mklink "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\winmarchy.ahk" "$PWD\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\winmarchy.ahk"
```

## Neovim setup (Windows Only)

```powershell
# Run as Administrator
Remove-Item -Path "$env:LOCALAPPDATA\nvim" -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\nvim" -Target "$PWD\.config\nvim"
```

## Arch Setup

```bash

# basic apps
pacman -S git
pacman -S openssh
pacman -S zsh
pacman -S unzip
pacman -S gcc
pacman -S elixir
pacman -S ripgrep
pacman -S neovim

# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# nvm
ln -sf "$(pwd)/default-packages" $NVM_DIR/default-packages
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
nvm install --lts

# claude code
curl -fsSL https://claude.ai/install.sh | bash

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Aerospace setup (Mac Only)

```bash
ln -sf "$(pwd)/.aerospace.toml" ~/.aerospace.toml
```

## Hyprland setup (Arch Only)

```bash

```

## WezTerm setup

```bash
ln -sf "$(pwd)/.wezterm.lua" ~/.wezterm.lua
```

## ZSH setup

```bash
chsh -s $(which zsh)
rm ~/.zshrc
ln -sf "$(pwd)/.zshrc" ~/.zshrc
```

## SSH setup

```bash
ssh-keygen -t rsa -C "fe@lipe.dev"

# Mac only
mkdir -p ~/.ssh
ln -sf "$(pwd)/.ssh/config" ~/.ssh/config
ssh-add --apple-use-keychain ~/.ssh/id_rsa

# Arch only
mkdir -p ~/.config/systemd/user
ln -sf "$(pwd)/.config/systemd/user/ssh-agent.service" ~/.config/systemd/user/ssh-agent.service
systemctl --user enable --now ssh-agent
ssh-add

cat ~/.ssh/id_rsa.pub
```

## NVIM setup

```bash
cargo install --features lsp --locked taplo-cli
rm -rf ~/.config/nvim
ln -s "$(pwd)/.config/nvim" ~/.config/nvim
```
