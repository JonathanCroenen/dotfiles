# locale
export LANG=en_US.UTF-8

# xdg
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

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

# fzf
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

FZF_COLORS="bg+:-1,\
fg:gray,\
fg+:white,\
border:black,\
spinner:0,\
hl:yellow,\
header:blue,\
info:green,\
pointer:red,\
marker:blue,\
prompt:gray,\
hl+:red"

export FZF_DEFAULT_OPTS="--border sharp \
--layout reverse \
--color '$FZF_COLORS' \
--prompt '∷ ' \
--pointer ▶ \
--marker ⇒"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -n 10'"
export FZF_COMPLETION_DIR_COMMANDS="cd pushd rmdir tree ls"

# man pages
export MANPAGER="nvim +Man!"

# path
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Dev/Bin:$PATH"
export PATH="/usr/local/jdk1.8.0/bin:$PATH"
export PATH="/usr/local/cuda-12.3/bin:$PATH"
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# lib path
export LD_LIBRARY_PATH="/usr/local/cuda/lib64/:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="/usr/local/cuda-12.3/lib64/:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="$HOME/Dev/Lib/:$LD_LIBRARY_PATH"
