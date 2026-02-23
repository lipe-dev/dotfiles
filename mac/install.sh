#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/.."
DOTFILES="$(pwd)"

echo "==> homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "==> packages"
brew install ripgrep neovim gh
brew install --cask nikitabobko/tap/aerospace
brew install --cask wezterm

echo "==> gh auth"
gh auth login

echo "==> oh-my-zsh"
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s "$(which zsh)"

echo "==> nvm"
mkdir -p ~/.nvm
ln -sf "$DOTFILES/linux/default-packages" ~/.nvm/default-packages
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
\. "$NVM_DIR/nvm.sh"
nvm install --lts

echo "==> claude code"
curl -fsSL https://claude.ai/install.sh | bash

echo "==> rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

echo "==> symlinks"
rm -f ~/.zshrc
ln -sf "$DOTFILES/mac/.zshrc" ~/.zshrc
ln -sf "$DOTFILES/mac/.aerospace.toml" ~/.aerospace.toml
ln -sf "$DOTFILES/mac/.wezterm.lua" ~/.wezterm.lua

echo "==> neovim config"
cargo install --features lsp --locked taplo-cli
rm -rf ~/.config/nvim
mkdir -p ~/.config
ln -sf "$DOTFILES/mac/.config/nvim" ~/.config/nvim

echo "==> done. restart shell to apply changes."
