#!/bin/bash

git submodule update --init

OS=$(uname)
if ! command -v zsh > /dev/null 2>&1
then
  if [[ $OS == "Linux" ]]; then
    sudo apt install zsh -y
  elif [[ $OS == "Darwin" ]]; then
    brew install zsh
  fi
fi

if [[ $OS == "Linux" ]]; then
  XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
elif [[ $OS == "Darwin" ]]; then
  XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/Library/Preferences"}
fi

DOTFILES=$(pwd)
mkdir -p "$XDG_CONFIG_HOME"
rm -rf $XDG_CONFIG_HOME/nvim $HOME/.zshenv $HOME/.zshrc $XDG_CONFIG_HOME/zsh $HOME/.wezterm.lua $HOME/.wezterm

ln -s $DOTFILES/nvim $XDG_CONFIG_HOME/nvim

ln -s $DOTFILES/zsh/.zshenv $HOME/.zshenv
ln -s $DOTFILES/zsh/.zshrc $HOME/.zshrc
ln -s $DOTFILES/zsh $XDG_CONFIG_HOME/zsh

ln -s $DOTFILES/.wezterm.lua $HOME/.wezterm.lua
ln -s $DOTFILES/.wezterm $HOME/.wezterm

sudo chsh -s /bin/zsh $USER

