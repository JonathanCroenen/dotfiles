#!/bin/bash

source zsh/.zshenv

ln -s $DOTFILES/nvim $XDG_CONFIG_HOME/nvim

ln -s $DOTFILES/zsh/.zshenv $HOME/.zshenv
ln -s $DOTFILES/zsh/.zshrc $HOME/.zshrc

ln -s $DOTFILES/.wezterm.lua $HOME/.wezterm.lua
ln -s $DOTFILES/.wezterm $HOME/.wezterm
