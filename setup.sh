#!/bin/bash

DOTFILES=$(pwd)
if [ $# -ne 1 ]; then
    echo "Usage: $0 <XDG_CONFIG_HOME>"
    exit 1
fi
XDG_CONFIG_HOME="$1"

ln -s $DOTFILES/nvim $XDG_CONFIG_HOME/nvim

ln -s $DOTFILES/zsh/.zshenv $HOME/.zshenv
ln -s $DOTFILES/zsh/.zshrc $HOME/.zshrc
ln -s $DOTFILES/zsh $XDG_CONFIG_HOME/zsh

ln -s $DOTFILES/.wezterm.lua $HOME/.wezterm.lua
ln -s $DOTFILES/.wezterm $HOME/.wezterm

sudo chsh -s /bin/zsh $USER

