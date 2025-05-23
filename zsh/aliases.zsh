# system
alias shutdown='sudo shutdown -h now'
alias reboot='sudo reboot'
alias suspend='systemctl suspend'

# tools
alias vim='nvim'
alias imgcat='wezterm imgcat'

# ls
# alias ls='colorls --sd -A'
# alias lsa='colorls --sd -la'
# alias lsd='colorls --sd -d'
# alias lsf='colorls --sd -f'

# file operations
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'

# apt
alias aptup='sudo apt update'
alias aptug='sudo apt update && sudo apt upgrade'
alias apti='sudo apt install'
alias aptr='sudo apt remove'
alias aptl='apt list'

# git
alias gcl='git clone'
alias gs='git status -s'
alias ga='git add'
alias gps='git push'
alias gpl='git pull'
alias gc='git commit'
alias gcm='git commit -m'
alias gbn='git checkout -b'
alias gd='git diff'
alias gl='git log --graph --abbrev-commit --oneline --decorate'
alias gm='git merge'
alias gor='git open-remote'

# misc
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
alias timeit='/usr/bin/time'
