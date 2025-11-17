# dotfiles

## Install stuff

```
pacman -S git
pacman -S openssh
pacman -S zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz
```

## ZSH setup

```
chsh -s $(which zsh)
ln -sf "$(pwd)/.zshrc" ~/.zshrc
```

## SSH setup

```
ssh-keygen -t rsa -C "fe@lipe.dev"
mkdir -p ~/.config/systemd/user
ln -sf "$(pwd)/.config/systemd/user/ssh-agent.service" ~/.config/systemd/user/ssh-agent.service
systemctl --user enable --now ssh-agent
ssh-add
cat ~/.ssh/id_rsa.pub
```

## NVIM setup

```
ln -s "$(pwd)/.config/nvim" ~/.config/nvim
```
