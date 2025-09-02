#!/bin/bash

git submodule update --init

DOTFILES=$(pwd)
mkdir -p $XDG_CONFIG_HOME
rm -rf $XDG_CONFIG_HOME/nvim $HOME/.zshenv $HOME/.zshrc $XDG_CONFIG_HOME/zsh $HOME/.wezterm.lua $HOME/.wezterm

ln -s $DOTFILES/nvim $XDG_CONFIG_HOME/nvim

ln -s $DOTFILES/zsh/.zshenv $HOME/.zshenv
ln -s $DOTFILES/zsh/.zshrc $HOME/.zshrc
ln -s $DOTFILES/zsh $XDG_CONFIG_HOME/zsh

ln -s $DOTFILES/.wezterm.lua $HOME/.wezterm.lua
ln -s $DOTFILES/.wezterm $HOME/.wezterm

sudo chsh -s /bin/zsh $USER

