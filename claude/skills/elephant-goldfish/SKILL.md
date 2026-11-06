---
name: elephant-goldfish
description: Design-first workflow for substantial changes (the Elephant-Goldfish Model). One long-context session (the Elephant) interviews the user and writes a design doc but no code; fresh zero-context subagents (Goldfish) review only that doc and the repo, attacking it until it gets a go; only then is code written, exactly as designed. Use when the user asks for elephant-goldfish, EGM, "design doc first", or a design review before coding, and offer it for new features, new entities or schema changes, migrations, cross-cutting or hard-to-revert changes. Not for one-liners, typos, copy edits or changelog entries.
---

# Elephant-Goldfish

AI writes code fast, so its mistakes pile up fast. Separate **design** from **review**, and both from **code**: debate the design while it is still a cheap Markdown file, not a PR.

- 🐘 **Elephant**: this session. Holds the whole project in context, writes no code, only the design doc.
- 🐟 **Goldfish**: fresh subagents with zero conversation context. They see only the doc and the repo, so they don't share the Elephant's assumptions and catch what it missed.

Input: `$ARGUMENTS` is the change to design. If it names an existing design doc, skip to Phase 2.

## Phase 1 🐘 Design (no code)

1. **Load the project's memory.** Read CLAUDE.md/AGENTS.md, then whatever specs, architecture docs, ADRs or earlier design docs cover the area (`docs/`, `docs/designs/`, `specs/`, …), then the code the change touches. This is what makes the Elephant an elephant; don't skip it.
2. **Interview the user.** Ask about the decisions that are genuinely theirs, one topic at a time, each with your recommendation and the trade-off (AskUserQuestion where it fits). Derive the topics from the codebase rather than a fixed list, typically: which entity/module owns it, which layer, data model and migration, compatibility with existing data or API consumers, UI wording, rollout. Argue back when a choice has a cost the user may not see. Settle facts yourself by reading code instead of asking.
3. **Write the design doc** from `design-doc-template.md` (next to this file). Put it where the project keeps designs; if there is no such place, `docs/designs/<yyyy-mm-dd>-<slug>.md`. Keep it short: a reviewer must be able to read it in one go. Write only this file in this phase: no code, no scaffolding, no "quick spike" edits.

## Phase 2 🐟 Review (fresh subagents, doc + repo only)

Spawn the Goldfish **in parallel, in one message**, with the Agent tool, using a **non-fork** read-only agent type (e.g. `Plan`; never `fork`, which inherits this conversation). Prompts come from `goldfish-prompts.md`. Give each one the doc path, the repo root and its role, nothing else: no summary of the interview, no hint at what you think is weak. Anything you add becomes a shared assumption, which defeats the point.

The panel, 4–5 agents:

| Goldfish | Asks | Fails when |
|---|---|---|
| Comprehension | "Explain back what this changes." | Its paraphrase differs from what you and the user meant: the doc is unclear, even if the design is right. |
| Antagonist × 2–3 | "Find what breaks." One per angle that matters for this change, e.g. domain rules, persistence/migration, API consumers, frontend/UX, concurrency, security, performance, ops. Name the project's own fragile spots in the angle (invariants, validators, loaders, translations, generated code). | Any 🔴 Blocker. |
| Readiness | "Could you build this without asking anything?" | Anything but GO. |

Then, as the Elephant:

1. Compare the Comprehension paraphrase with the intent. Every mismatch is a doc fix.
2. Merge the findings, drop duplicates, and verify each against the code before acting on it: a Goldfish can be wrong too. Note which you reject and why.
3. Show the user a short verdict: blockers, majors, the readiness answer, and what you propose to change in the doc. The user decides: fix the doc, accept a risk (record it in the doc), or stop.
4. After doc fixes, re-review with **new** Goldfish (new Agent calls, never SendMessage to the old ones: they are no longer goldfish). Re-run at least Comprehension and Readiness; re-run an Antagonist if its area changed.

**The gate:** Readiness says GO and no Blocker is open. Don't write code before it.

## Phase 3 ⚙️ Implement (only after GO)

- One change per session or worktree. Offer a separate worktree for anything big; implementation can be handed to a fresh session or subagent with only the doc as its brief, a good test of the doc.
- Build exactly what the doc says, in the order of its implementation plan.
- **When reality differs from the doc, update the doc first, then the code.** If the deviation changes the design (not just a detail), stop and tell the user; a large one goes back through Phase 2.

## Phase 4 🔁 Close the loop

1. Run the project's own checks (build, tests, lint, type check, plus anything CLAUDE.md asks for before a PR).
2. Review the diff with a Goldfish that never saw the design: the project's review command (e.g. `/code-review`) or a fresh agent given only the diff. It reviews the code on its own terms.
3. Optionally, one more fresh agent given the doc and the diff checks they match: every planned file changed, nothing unplanned.
4. **Feed the lesson back.** When diff review catches something the design review missed, add the rule to the place the next Elephant will read (CLAUDE.md, a spec or architecture doc), so the next design avoids it. Propose the edit to the user.
5. Keep the final doc in the repo with the change if the project keeps designs; otherwise ask the user whether to commit it or drop it.

## Rule of thumb

Design is cheap to change and code isn't. Spend the debate on the doc, not the PR. If the change is small enough that writing the doc takes longer than writing the code, it doesn't need this skill.
