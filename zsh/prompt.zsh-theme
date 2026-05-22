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
    
    # Adapt directory depth based on terminal width
    local max_components=3
    if (( COLUMNS < 60 )); then
        max_components=1
    elif (( COLUMNS < 85 )); then
        max_components=2
    fi

    if [[ $len -gt $max_components ]]; then
        if (( max_components == 1 )); then
            dir="${components[$len]}"
        else
            dir=".../${components[$((len - max_components + 1))]}"
            for (( i=$((len - max_components + 2)); i<=len; i++ )); do
                dir="$dir/${components[$i]}"
            done
        fi
    fi
    echo "%F{white}[%F{cyan}$dir%F{white}]%f "
}

setopt PROMPT_SUBST
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '%b'

ZSH_THEME_GIT_PROMPT_DIRTY=" %F{yellow}*%f"

function set_prompt {
    # Base prompt (exit status dot)
    # Wrap the multi-byte bullet '•' in %{...%G%} so Zsh treats it as 1 column
    # even if the system's UTF-8 locale is not fully configured or working.
    PROMPT=" %(?:%F{green}%{•%G%}%f:%F{red}%{•%G%}%f) "

    # 1. Hostname: only show if terminal is wide enough (> 85 cols)
    if (( COLUMNS > 85 )); then
        PROMPT+="%F{white}[%F{magenta}%m%F{white}] "
    fi

    # 2. Virtual Environment: show if wide enough (> 60 cols)
    if (( COLUMNS > 60 )); then
        PROMPT+="$(prompt_virtualenv_info)"
    fi

    # 3. Directory path: dynamically shortened inside prompt_path_info
    PROMPT+="$(prompt_path_info)"

    # 4. Git status: show if wide enough (> 50 cols)
    if (( COLUMNS > 50 )); then
        PROMPT+="$(prompt_git_info)"
    fi

    PROMPT+="%F{white}->%f "

    # 5. Right prompt: only show if wide enough (> 75 cols)
    if (( COLUMNS > 75 )); then
        RPROMPT="%F{white}[%F{green}%*%F{white}]%f"
    else
        RPROMPT=""
    fi
}

function precmd {
    vcs_info
    set_prompt
}

# Redraw prompt instantly when terminal is resized
TRAPWINCH() {
    if [[ -o zle ]]; then
        set_prompt
        zle && zle reset-prompt
    fi
}

