# options
unsetopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

unsetopt CORRECT
setopt EXTENDED_GLOB

setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY

# colors
autoload -U colors; colors

# custom
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/scripts.zsh"
source "$ZDOTDIR/prompt.zsh-theme"

# plugins
source "$ZDOTDIR/plugins/completion.zsh"
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZDOTDIR/plugins/vim-mode.zsh"
source "$ZDOTDIR/plugins/sudo.zsh"
source "$ZDOTDIR/plugins/conda-integration.zsh"
source "$ZDOTDIR/plugins/nvm-integration.zsh"
source "$ZDOTDIR/plugins/opam-integration.zsh"
source "$ZDOTDIR/plugins/fzf-integration.zsh"
