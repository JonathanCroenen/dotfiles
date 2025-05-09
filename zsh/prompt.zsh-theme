function prompt_virtualenv_info {
  local env_name=""
  if [[ -n $VIRTUAL_ENV ]]; then
    env_name=$(basename $VIRTUAL_ENV)
  elif [[ -n $CONDA_PREFIX ]]; then
    env_name=$(basename $CONDA_PREFIX)
  fi
  [[ -n $env_name ]] && echo "%F{white}(%F{green}$env_name%F{white}) "
}

function prompt_git_status {
  local INDEX STATUS

  INDEX=$(command git status --porcelain -b 2> /dev/null)

  if $(echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DIRTY"
  elif $(echo "$INDEX" | grep '^A  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DIRTY"
  elif $(echo "$INDEX" | grep '^M  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DIRTY"
  elif $(echo "$INDEX" | grep '^MM ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DIRTY"
  elif $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DIRTY"
  elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DIRTY"
  elif $(echo "$INDEX" | grep '^MM ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DIRTY"
  elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DIRTY"
  fi

  if [[ ! -z "$STATUS" ]]; then
    echo "$STATUS"
  fi
}

function prompt_git_info {
    [ ! -z "$vcs_info_msg_0_" ] && echo "%F{white}(%F{red}${vcs_info_msg_0_}$(prompt_git_status)%F{white})%f "
}

function prompt_path_info {
    local dir
    dir=${PWD/#$HOME/\~}  # Replace home directory with ~
    local IFS='/'          # Set the Internal Field Separator to '/'
    local components=(${(s:/:)dir})  # Split the path into components by '/'
    local len=${#components[@]}
    if [[ $len -gt 3 ]]; then
        dir=".../${components[$((len-2))]}"
        for (( i=$((len-1)); i<=len; i++ )); do
            dir="$dir/${components[$i]}"
        done
    fi
    echo "%F{white}[%F{cyan}$dir%F{white}]%f "
}

setopt PROMPT_SUBST
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '%b'

ZSH_THEME_GIT_PROMPT_DIRTY=" %F{yellow}*%f"

function precmd {
    vcs_info

    PROMPT=" %(?:%F{green}•%f:%F{red}•%f) "
    PROMPT+="%F{white}[%F{magenta}%m%F{white}] "  # Add hostname here
    PROMPT+="$(prompt_virtualenv_info)"
    PROMPT+="$(prompt_path_info)"
    PROMPT+="$(prompt_git_info)"
    PROMPT+="%F{white}->%f "

    RPROMPT="%F{white}[%F{green}%*%F{white}]%f"
}
