#!/usr/bin/env sh
# Claude Code hook for the i-have-adhd skill.
#
# UserPromptSubmit: a prompt containing the word "adhd" turns ADHD mode on and
# injects the ruleset from SKILL.md; "stop adhd" or "adhd stop" turns it off.
# SessionStart (compact): re-injects the ruleset when the mode is on, so it
# survives context compaction.
#
# Mode state is one marker file per session. Any failure exits 0 so a prompt
# is never blocked.

command -v jq >/dev/null 2>&1 || exit 0

input=$(cat)
event=$(printf '%s' "$input" | jq -r '.hook_event_name // empty') || exit 0
session=$(printf '%s' "$input" | jq -r '.session_id // empty') || exit 0
[ -n "$session" ] || exit 0

state_dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/state/i-have-adhd"
marker="$state_dir/$session"
skill_path="$(dirname -- "$0")/../SKILL.md"

emit() {
  jq -n --arg event "$event" --arg ctx "$1" \
    '{hookSpecificOutput: {hookEventName: $event, additionalContext: $ctx}}'
}

rules() {
  # SKILL.md without its leading YAML frontmatter.
  awk '
    NR == 1 && /^---[[:space:]]*$/ { in_fm = 1; next }
    in_fm && /^---[[:space:]]*$/   { in_fm = 0; next }
    !in_fm                         { print }
  ' "$skill_path"
}

activate() {
  [ -f "$skill_path" ] || exit 0
  emit "ADHD MODE ACTIVE. The ruleset below applies to every response in this session until the user says \"stop adhd\" or \"adhd stop\".

$(rules)"
}

case "$event" in
  UserPromptSubmit)
    prompt=$(printf '%s' "$input" | jq -r '.prompt // empty' | tr '[:upper:]' '[:lower:]')
    if printf '%s' "$prompt" | grep -Eq '(^|[^a-z])(stop[[:space:]]+adhd|adhd[[:space:]]+stop)([^a-z]|$)'; then
      rm -f "$marker"
      emit "ADHD MODE OFF. The user turned ADHD mode off. Confirm in one line, then drop the i-have-adhd rules and return to your default style for the rest of the session."
    elif printf '%s' "$prompt" | grep -Eq '(^|[^a-z])adhd([^a-z]|$)'; then
      [ -f "$marker" ] && exit 0
      mkdir -p "$state_dir" && touch "$marker"
      activate
    fi
    ;;
  SessionStart)
    [ -f "$marker" ] && activate
    ;;
esac
exit 0
