---
name: counsel
description: Hill-climb a change to a score target. A builder subagent makes the change; a counsel (council) of at least two reviewer subagents, from different providers in T3 Code (Claude plus Gemini, GPT, …) and different Claude models elsewhere, grades it on categories the user names; this agent directs the loop, feeding reviews back to the builder and keeping the best version, until the target is met. Use when the user asks to build or improve something "with a counsel" or "council", wants a change graded on named categories ("grade on architecture, clean code and frontend design"), or sets a score target ("stop once every category has 8/10", "overall 9/10").
---

# Counsel

You are the **director**. You don't write the change yourself: a **builder** subagent does, a **counsel** of reviewer subagents grades it, and you run the loop between them, keeping the best version, until the scores meet the user's target.

Prompts for the builder and reviewers are in `prompts.md` next to this file.

## 1. Parse the brief

From `$ARGUMENTS` and the conversation, pin down:

| Item | Default when the user doesn't say |
|---|---|
| **Change**: what to build or improve | Ask; never guess. |
| **Categories**: what is graded, each with a one-line meaning | Ask. Offer correctness, architecture, code quality as a starting point. |
| **Target**: a threshold per category and/or overall. "Every category 8, frontend design 9" means min 8 each, 9 for that one. | Overall = mean of the category scores. |
| **Counsel**: reviewers and their providers/models | 2 reviewers: in T3 Code one Claude and one non-Claude, elsewhere two Claude models (see §3). |
| **Builder helpers**: may the builder spawn its own subagents? | No. |
| **Round limit** | 5 rounds. |
| **Workspace** | A new branch `counsel/<slug>`, in a worktree if the current tree has uncommitted work; each round checkpointed as a commit there. |

Restate the brief as a short block (change, rubric with thresholds, counsel, limits, workspace) and ask only about what is missing or ambiguous. A brief like "Build X with a counsel. Grade on architecture, clean code and frontend design. Stop once every category has 8/10 and frontend design 9/10" is complete: state the defaults you are applying and start.

Before the first round, read enough of the project (CLAUDE.md, the code the change touches, how to build and test it) to brief the builder well and to judge reviews.

## 2. The loop

Each round:

1. **Build.** Round 1: give the builder the build prompt. Later rounds: give it the consolidated feedback (step 5). Continue the same builder when your tooling allows (e.g. SendMessage to the Agent), so it keeps its own context; otherwise start a fresh one with the brief, the current state and the feedback.
2. **Gate on the objective checks.** Run the project's build, tests, lint and type check yourself. If they fail, send the failures back to the builder and don't review; a round that doesn't build isn't worth a reviewer's time.
3. **Checkpoint.** Commit the round on the counsel branch (`counsel: round N`), so any round can be restored.
4. **Review.** Start every reviewer in parallel, **fresh each round** (new agents, never a continued conversation), with the review prompt. Give them the original request, the rubric and how to see the change (base commit and branch). **Don't** give them the target, the round number, earlier scores or who the builder is: they grade the work against the rubric's anchors, not against a goal or a trend.
5. **Score and consolidate.**
   - Category score = mean across reviewers (one decimal), unless the user asked for something else, e.g. every reviewer must meet the threshold.
   - Spot-check reviewer claims against the code; drop issues that are wrong and note why. If reviewers disagree by 3+ points on a category, read the code there and say which view holds.
   - **Gap** = sum over every threshold of max(0, threshold − score). Gap 0 means the target is met.
   - Write the builder's feedback: per category below its threshold, the issues most likely to raise it, deduplicated and ordered by expected impact. Leave out praise and issues in categories already at target, unless they're cheap.
6. **Hill climb.** If this round's gap is smaller than the best so far, it becomes the best. If it is larger, restore the best checkpoint (`git reset --hard <best>` on the counsel branch only), tell the builder its last attempt was reverted and why, and give it the best round's feedback plus what made this round worse.
7. **Report the round** to the user in one or two lines: the scorecard against the target and what the builder will tackle next.

**Stop** when:
- the gap is 0: done;
- the round limit is reached;
- the best gap hasn't improved for 2 rounds in a row (a plateau): more rounds of the same won't help;
- reviewers keep asking for something that contradicts the user's request, or the builder can't meet one category without lowering another: that trade-off is the user's call. Ask.

## 3. Choosing the counsel

At least two reviewers. Provider diversity is the point, because a model shares its blind spots with itself.

Cross-provider reviewers are expected **only in T3 Code**, whose tools handle the calls to other providers:

- **In T3 Code** (the `t3-code` MCP tools are present): call `orchestrator_capabilities` once, then `delegate_task` once per reviewer with `role: "review"` and the provider and model in `target`. Start every reviewer before collecting any result. Claude reviewers can use the same tool or the Agent tool.
- **Anywhere else**: the counsel is Claude only. Use Agent subagents (never `fork`) on different models (`opus`, `sonnet`, `fable`), and tell the user up front that the counsel is single-provider and so less independent. Don't reach for other agent CLIs or APIs to get around this.

If a provider or model the user named isn't available, say so and ask before substituting. Don't silently swap it.

Reviewers are read-only: they read the diff and the code, and they may run the tests or the app, but they don't edit. The builder is a normal writing agent: Agent `general-purpose`, or in T3 Code `delegate_task` with `role: "implementation"` if the user wants another provider to build.

## 4. Finish

1. Make sure the branch is at the best checkpoint.
2. Report a table of scores per round per category, with the target as the last row; what the final version does; the issues still open from the last review; and why it stopped.
3. Leave the round commits on the counsel branch for the user to inspect. Squashing, merging, pushing or opening a PR is the user's call; ask.

## Guardrails

- The builder must not game the grade: no weakening or deleting tests, no disabling lint rules, no changes outside the request's scope to please a reviewer. Check the diff for this each round.
- Reviews are evidence, not orders. A reviewer asking for something the user didn't want (a rewrite, a new dependency, a scope change) goes to the user, not the builder.
- Costs add up: each round is one builder and N reviewers. Mention it when the user asks for many rounds or a large counsel.
