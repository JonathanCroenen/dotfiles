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
