# locale
export LANG=en_US.UTF-8

OS=$(uname)

# paths
if [[ $OS == "Linux" ]]; then
  # xdg
  export XDG_CONFIG_HOME="$HOME/.config"
  export XDG_DATA_HOME="$HOME/.local/share"
  export XDG_CACHE_HOME="$HOME/.cache"
  export XDG_BIN_HOME="$HOME/.local/bin"

  export DOTFILES="$HOME/Dev/Dotfiles"

  # path
  export PATH="$XDG_BIN_HOME:$PATH"
  export PATH="$HOME/Dev/Bin:$PATH"
  export PATH="/usr/local/jdk1.8.0/bin:$PATH"
  export PATH="/usr/local/cuda-12.3/bin:$PATH"
  export PATH="$HOME/.ghcup/bin:$PATH"
  export PATH="$HOME/.cargo/bin:$PATH"
  export PATH="$HOME/.go/bin:$PATH"
  export PATH="/opt/nvim-linux-x86_64/bin:$PATH"
  export PATH="/opt/renderdoc_1.37/bin:$PATH"

  # lib path
  export LD_LIBRARY_PATH="/usr/local/cuda/lib64/:$LD_LIBRARY_PATH"
  export LD_LIBRARY_PATH="/usr/local/cuda-12.3/lib64/:$LD_LIBRARY_PATH"
  export LD_LIBRARY_PATH="$HOME/Dev/Lib/:$LD_LIBRARY_PATH"

elif [[ $OS == "Darwin" ]]; then
  # xdg
  export XDG_CONFIG_HOME="$HOME/Library/Preferences"
  export XDG_DATA_HOME="$HOME/Library"
  export XDG_CACHE_HOME="$HOME/Library/Caches"
  export XDG_BIN_HOME="$HOME/.local/bin"

  export DOTFILES="$HOME/Dev/dotfiles"
  export GOPATH="$HOME/.go"

  # path
  export PATH="$GOPATH/bin:$PATH"
  export PATH="$XDG_BIN_HOME:$PATH"
  export PATH="/opt/homebrew/bin:$PATH"
  export PATH="$HOME/.cargo/bin:$PATH"
else
  echo "Unsupported OS"
  exit 1
fi

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000

# vars
export TERM="xterm-256color"

# editor
export EDITOR="nvim"
export VISUAL="nvim"

# man pages
export MANPAGER="nvim +Man!"

# git
export GIT_AUTHOR_NAME="Jonathan Croenen"
export GIT_COMMITTER_NAME="Jonathan Croenen"
