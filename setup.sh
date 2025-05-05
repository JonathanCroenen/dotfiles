#!/bin/bash

DOTFILES=$(pwd)
XDG_CONFIG_HOME="$1"

ln -s $DOTFILES/nvim $XDG_CONFIG_HOME/nvim

ln -s $DOTFILES/zsh/.zshenv $HOME/.zshenv
ln -s $DOTFILES/zsh/.zshrc $HOME/.zshrc
ln -s $DOTFILES/zsh $XDG_CONFIG_HOME/zsh

ln -s $DOTFILES/.wezterm.lua $HOME/.wezterm.lua
ln -s $DOTFILES/.wezterm $HOME/.wezterm

sudo chsh -s $USER

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
