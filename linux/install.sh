#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/.."
DOTFILES="$(pwd)"

echo "==> packages"
sudo apt update
sudo apt install -y git zsh unzip gcc ripgrep wget

echo "==> gh cli"
sudo mkdir -p -m 755 /etc/apt/keyrings
wget -qO- https://cli.github.com/packages/cli.github.com.gpg \
  | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
  | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update && sudo apt install -y gh
gh auth login

echo "==> neovim"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz

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
ln -sf "$DOTFILES/linux/.zshrc" ~/.zshrc
mkdir -p ~/.config/systemd/user
ln -sf "$DOTFILES/linux/.config/systemd/user/ssh-agent.service" ~/.config/systemd/user/ssh-agent.service
systemctl --user enable --now ssh-agent

echo "==> neovim config"
cargo install --features lsp --locked taplo-cli
rm -rf ~/.config/nvim
ln -sf "$DOTFILES/linux/.config/nvim" ~/.config/nvim

echo "==> done. restart shell to apply changes."
