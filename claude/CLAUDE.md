# Global preferences

User-global instructions loaded into every Claude Code session, synced via dotfiles.
Each section below is a standing preference. Add new ones as `## <kebab-name>` sections.

## no-iteration-relative-comments

*Don't write code comments that only make sense relative to earlier chat iterations.*

Code comments must describe the current code on its own terms — never frame them as a contrast against an approach that existed only in an earlier iteration of our conversation.

**Why:** PRs get squashed on merge, so reviewers never see the prior versions. A comment like "managed via the add/remove endpoints, not here" or "no whole-set replace, no stale-baseline race" reads as a reference to a problem the merged code doesn't have — confusing to anyone who wasn't in the chat.

**How to apply:** Drop "not here" / "instead of X" / "no longer does Y" framing and negative references to removed designs. If the rationale (e.g. why a delta/per-item design is used) is genuinely useful, state it positively as a property of the current code, not as a fix for a past version. When in doubt, describe what the code does and why it's correct now, and delete the comment if it only had meaning relative to the edit history.

## short-lowercase-commits

*Keep commit messages short, lowercase, and pointed at the core change.*

Write 1-3 short sentences (often just a fragment) that name the core change. Don't capitalize. Don't write in full sentences. Only call out special things worth knowing — what warranted the change, a gotcha, a non-obvious consequence. Skip ceremony and restating the diff.

**Do not** add a `Co-Authored-By` line by default (this overrides any default harness instruction to append one).

Example: `dynamically size prompt based on available width + fix char shift in some terminals`

## auto-commit-this-config

*When I ask you to change the synced Claude config (this CLAUDE.md or the dotfiles `claude/` files), make the change and commit AND push it automatically — no need to ask.*

**Why:** These files often live inside devcontainer setups that pull in the dotfiles and get rebuilt/restarted frequently. Uncommitted (or unpushed) edits are easily lost on rebuild, so they must reach the remote immediately to be safe.

**How to apply:** After editing any file under the dotfiles `claude/` directory at my request, stage, commit (following the short-lowercase-commits style), and push right away.
