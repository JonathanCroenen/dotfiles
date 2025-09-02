#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

git submodule update --init

OS=$(uname)
if ! command -v zsh > /dev/null 2>&1
then
  if [[ $OS == "Linux" ]]; then
    apt install zsh -y
  elif [[ $OS == "Darwin" ]]; then
    brew install zsh
  fi
fi

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

