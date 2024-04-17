function virtualenv_info {
    [[ -n $VIRTUAL_ENV ]] && echo '%F{white}(%F{green}'`basename $VIRTUAL_ENV`'%F{white}) '
}

function git_prompt_status {
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
    [ ! -z "$vcs_info_msg_0_" ] && echo "%F{white}(%F{red}${vcs_info_msg_0_}$(git_prompt_status)%F{white})%f"
}

function prompt_path {
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
    echo "%F{white}[%F{cyan}$dir%F{white}]%f"
}

setopt PROMPT_SUBST
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '%b'

ZSH_THEME_GIT_PROMPT_DIRTY=" %F{yellow}*%f"

function precmd {
    vcs_info

    PROMPT=" %(?:%F{green}•%f:%F{red}•%f) "
    PROMPT+="$(virtualenv_info) "
    PROMPT+="$(prompt_path) "
    PROMPT+="$(prompt_git_info) "
    PROMPT+="%F{white}->%f "

    RPROMPT="%F{white}[%F{green}%*%F{white}]%f"
}
