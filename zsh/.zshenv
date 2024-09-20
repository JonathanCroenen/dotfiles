# locale
export LANG=en_US.UTF-8

# xdg
export XDG_CONFIG_HOME="$HOME/Library/Preferences"
export XDG_DATA_HOME="$HOME/Library"
export XDG_CACHE_HOME="$HOME/Library/Caches"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000

# vars
export TERM="xterm-256color"
export DOTFILES="$HOME/Dev/Dotfiles"

# editor
export EDITOR="nvim"
export VISUAL="nvim"

# man pages
export MANPAGER="nvim +Man!"

# path
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# lib path

