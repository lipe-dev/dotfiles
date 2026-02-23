# dotfiles

Minimal configs for Mac, Windows, and Linux (WSL Ubuntu).

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
ln -sf "$(pwd)/linux/default-packages" ~/.nvm/default-packages
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
nvm install --lts

# gh cli
sudo mkdir -p -m 755 /etc/apt/keyrings
wget -qO- https://cli.github.com/packages/cli.github.com.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update && sudo apt install gh -y
gh auth login

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
mkdir -p ~/.config/systemd/user
ln -sf "$(pwd)/linux/.config/systemd/user/ssh-agent.service" ~/.config/systemd/user/ssh-agent.service
systemctl --user enable --now ssh-agent
cargo install --features lsp --locked taplo-cli
rm -rf ~/.config/nvim
ln -sf "$(pwd)/linux/.config/nvim" ~/.config/nvim
```
