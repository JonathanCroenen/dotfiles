# Oh-my-zsh configuration
export ZSH="$HOME/.zsh"

ZSH_THEME="custom"
HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode disabled

ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"

plugins=(
    git
    colored-man-pages
    sudo
    zsh-syntax-highlighting
    zsh-autosuggestions
    rust
    python
)

fpath+=$ZSH/custom/plugins/zsh-completions/src
ZSH_AUTOSUGGEST_STRATEGY=(completion history)

source $ZSH/oh-my-zsh.sh

# User configuration
export LANG=en_US.UTF-8

alias DGPU="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia"
alias ls=colorls
alias vim=nvim
alias imgcat="wezterm imgcat"

export MANPATH="/usr/local/man:$MANPATH"
export PATH=$PATH:/home/jonathan/.local/bin:/home/jonathan/Dev/Bin:/usr/local/jdk1.8.0/bin
export PATH=$PATH:/usr/local/cuda-12.3/bin:/home/jonathan/.ghcup/bin:/home/jonathan/.cargo/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64/:/home/jonathan/Dev/Lib/

export XDG_CONFIG_HOME=$HOME/.config

# Conda
export CONDA_AUTO_ACTIVATE_BASE=false

__conda_setup="$('/home/jonathan/.miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/jonathan/.miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/jonathan/.miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/jonathan/.miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# opam configuration
[[ ! -r /home/jonathan/.opam/opam-init/init.zsh ]] || source /home/jonathan/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
