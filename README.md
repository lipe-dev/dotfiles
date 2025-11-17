
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

## Install stuff

```shell
pacman -S git
pacman -S openssh
pacman -S zsh
pacman -S unzip
pacman -S elixir
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
nvm install --lts
curl -fsSL https://claude.ai/install.sh | bash
```

## ZSH setup

```shell
chsh -s $(which zsh)
ln -sf "$(pwd)/.zshrc" ~/.zshrc
```

## SSH setup

```shell
ssh-keygen -t rsa -C "fe@lipe.dev"
mkdir -p ~/.config/systemd/user
ln -sf "$(pwd)/.config/systemd/user/ssh-agent.service" ~/.config/systemd/user/ssh-agent.service
systemctl --user enable --now ssh-agent
ssh-add
cat ~/.ssh/id_rsa.pub
```

## NVIM setup

```shell
ln -s "$(pwd)/.config/nvim" ~/.config/nvim
```
