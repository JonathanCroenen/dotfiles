# system
alias shutdown='sudo shutdown -h now'
alias reboot='sudo reboot'
alias suspend='systemctl suspend'

# neovim 
alias vim='nvim'

# ls
alias ls='colorls --sd -A'
alias lsa='colorls --sd -la'
alias lsd='colorls --sd -d'
alias lsf='colorls --sd -f'

# file operations
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

# apt
alias aptu='sudo apt update'
alias aptug='sudo apt update && sudo apt upgrade'
alias apti='sudo apt install'
alias aptr='sudo apt remove'
alias aptl='apt list'

# git
alias gs='git status -s'
alias ga='git add'
alias gps='git push'
alias gpl='git pull'
alias gc='git commit'
alias gbn='git checkout -b'
alias gd='git diff'
alias gl='git log --graph --abbrev-commit --oneline --decorate'
alias gm='git merge'

# misc
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
alias timeit='/usr/bin/time'

