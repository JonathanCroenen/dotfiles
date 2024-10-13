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

autoload -U colors; colors
autoload -U +X compinit && compinit

# custom
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/scripts.zsh"
source "$ZDOTDIR/prompt.zsh-theme"

# plugins
source "$ZDOTDIR/plugins/per-directory-history.zsh"
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$ZDOTDIR/plugins/vim-mode.zsh"
source "$ZDOTDIR/plugins/sudo.zsh"
source "$ZDOTDIR/plugins/conda-integration.zsh"
source "$ZDOTDIR/plugins/nvm-integration.zsh"
source "$ZDOTDIR/plugins/opam-integration.zsh"
source "$ZDOTDIR/plugins/fzf-integration.zsh"
source "$ZDOTDIR/plugins/wezterm-integration.zsh"
source "$ZDOTDIR/plugins/extra-completions.zsh"
source "$ZDOTDIR/plugins/completion.zsh"
source "$ZDOTDIR/plugins/autosuggestions.zsh"

# history completion
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

bindkey -M vicmd "k" up-line-or-beginning-search 
bindkey -M vicmd "j" down-line-or-beginning-search

bindkey -M viins "^K" up-line-or-beginning-search
bindkey -M viins "^J" down-line-or-beginning-search
bindkey -M viins "^L" autosuggest-accept

# fix for insert -> type -> normal -> insert -> cant backspace anymore
bindkey "^?" backward-delete-char

