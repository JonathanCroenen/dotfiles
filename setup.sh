#!/bin/bash

git submodule update --init

OS=$(uname)
if ! command -v zsh > /dev/null 2>&1
then
  if [[ $OS == "Linux" ]]; then
    sudo apt install zsh -y
  fi
fi

if [[ $OS == "Linux" ]]; then
  XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
elif [[ $OS == "Darwin" ]]; then
  XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/Library/Preferences"}
fi

DOTFILES=$(pwd)
mkdir -p "$XDG_CONFIG_HOME"
rm -rf $XDG_CONFIG_HOME/nvim $HOME/.zshenv $HOME/.zshrc $XDG_CONFIG_HOME/zsh $HOME/.wezterm.lua $HOME/.wezterm

ln -s $DOTFILES/nvim $XDG_CONFIG_HOME/nvim

ln -s $DOTFILES/zsh/.zshenv $HOME/.zshenv
ln -s $DOTFILES/zsh/.zshrc $HOME/.zshrc
ln -s $DOTFILES/zsh $XDG_CONFIG_HOME/zsh

ln -s $DOTFILES/.wezterm.lua $HOME/.wezterm.lua
ln -s $DOTFILES/wezterm $HOME/.wezterm

# Agent configs & skills (Claude Code, Antigravity / agy, Gemini, Codex, T3 Code)
# Link only the shareable files/skills, leaving machine-local state in place
mkdir -p \
  "$HOME/.claude/skills" \
  "$HOME/.agents/skills" \
  "$HOME/.gemini/skills" \
  "$HOME/.gemini/config/skills" \
  "$HOME/.gemini/antigravity-cli/skills" \
  "$HOME/.codex/skills"

ln -sf "$DOTFILES/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
ln -sf "$DOTFILES/claude/CLAUDE.md" "$HOME/.gemini/GEMINI.md"
ln -sf "$DOTFILES/claude/CLAUDE.md" "$HOME/.gemini/config/GEMINI.md"
ln -sf "$DOTFILES/claude/CLAUDE.md" "$HOME/.agents/AGENTS.md"
ln -sf "$DOTFILES/claude/CLAUDE.md" "$HOME/.codex/AGENTS.md"
ln -sf "$DOTFILES/claude/settings.json" "$HOME/.claude/settings.json"

for skill in "$DOTFILES"/claude/skills/*/; do
  name=$(basename "$skill")
  target="${skill%/}"
  ln -sfn "$target" "$HOME/.claude/skills/$name"
  ln -sfn "$target" "$HOME/.agents/skills/$name"
  ln -sfn "$target" "$HOME/.gemini/skills/$name"
  ln -sfn "$target" "$HOME/.gemini/config/skills/$name"
  ln -sfn "$target" "$HOME/.gemini/antigravity-cli/skills/$name"
  ln -sfn "$target" "$HOME/.codex/skills/$name"
  for provider_dir in "$HOME"/.t3/userdata/providers/antigravity/*/; do
    [ -d "$provider_dir" ] || continue
    mkdir -p "${provider_dir}config/skills" "${provider_dir}antigravity-cli/skills"
    ln -sfn "$target" "${provider_dir}config/skills/$name"
    ln -sfn "$target" "${provider_dir}antigravity-cli/skills/$name"
  done
done

sudo chsh -s /bin/zsh $USER
