---
name: doublecheck
description: Deep verification that all changes meet requirements and preserve correctness
allowed-tools: Read, Agent, Bash(git diff:*), Bash(git status:*), Bash(git log:*), Bash(git show:*)
argument-hint: [specific-focus-area]
---

## Context

- Branch and files: !`git status --short --branch`
- Unstaged changes: !`git diff`
- Staged changes: !`git diff --cached`

The injected diffs cover working-tree changes. If a diff was too large to inline and arrived as a file path with a preview, read that file (or have reviewers run `git diff` themselves). If relevant work was committed during this conversation, inspect the corresponding commit or branch diff too. Focus on work from this conversation unless otherwise specified; unrelated changes may belong to the user or another agent.

## Your Task

Perform a meticulous verification and comprehensive review of all work done. Establish the actual change scope before reviewing. Treat verification as read-only unless the user explicitly asks for fixes.

**Deploy one or more fresh-context Opus reviewers** (see Agent Selection in the global `CLAUDE.md`, including the one-heavy-compute-agent rule), split by aspect as the size and complexity of the change warrant. Review directly yourself only when the change is so small that a reviewer would add nothing: the point of this skill is a review by agents that did not do the work and don't share its assumptions. A fresh-context reviewer knows nothing of this conversation, so brief each one with: the original goals and requirements, its exact scope (files, commits, or the plan file), what counts as a finding (below), and the report format (below).

Verify that:

- All changes align with the original goals and requirements
- Modifications preserve file integrity and correctness
- Nothing is missing or requires additional updates
- Changes work coherently together

### Deeper Review

Go beyond surface-level correctness. Evaluate the work for:

- **Completeness**: Are all requirements addressed? Are there gaps, missing scenarios, or implicit expectations left unhandled?
- **Correctness**: Does the logic hold? Are there subtle errors, flawed assumptions, or reasoning gaps?
- **Consistency**: Do the changes match the provided or discussed specs? Do they follow the conventions and patterns already established in the project?
- **Structural integrity**: Is the work well-organized? Watch for unclear boundaries, redundancy, or unnecessary entanglement between parts that will make future changes harder.
- **Consolidation**: Flag spaghettification—duplicated logic, parallel structures doing similar things, components that could be merged or reused. In code: identify candidates for shared functions, similar modules that could be unified, redundant abstractions. In plans/docs: overlapping sections, repeated concepts, restated prerequisites or duplicated steps. Report what you find; do not refactor.
- **Hazard avoidance**: Identify footguns—things that look correct now but will mislead or break later (e.g., ambiguous naming, brittle assumptions, implicit dependencies, information that will drift out of sync).

**Look beyond the immediate task.** Explore the surrounding project enough to catch:

- Existing material that overlaps with or is affected by the changes
- Patterns or conventions elsewhere that the changes should respect
- Downstream consequences the author may not have considered

For **code** specifically, also check:

- Error handling and boundary conditions
- Thread safety or concurrency concerns (if applicable)
- Whether tests cover the new behavior adequately
- API surface changes and their impact on callers
- Whether documentation (READMEs, guides, API docs, inline comments) needs updating or creation to reflect the changes

For **plans and design documents**, also check:

- Whether the proposed approach accounts for known constraints and prior decisions
- Feasibility of each step and whether dependencies between steps are correctly sequenced
- Whether each phase is precise enough for its stated executor (an Opus executor needs explicit steps, paths, and commands)
- Whether the plan addresses verification and rollback
- Whether documentation (READMEs, API docs, guides) needs updating or creation to reflect the changes

**Focus area (optional; if empty focus on all changes/files)**:

<focus> $ARGUMENTS </focus>

## What counts as a finding

Report anything that affects correctness, the stated requirements, coherence of the changes, or future maintainability — including minor but real issues. Style counts when it is part of the criteria (a style guide, a house convention, or the focus area — typical when reviewing prose or docs); otherwise drop personal style preferences. Drop speculative or unverifiable items. Each finding carries a location, a one-line statement of the problem, and a confidence (high / medium / low). Reviewers apply this bar themselves so the report that reaches the orchestrator stays high-signal.

## Report

Group findings by severity:

- **Must fix**: breaks correctness, requirements, or file/data integrity.
- **Should fix**: real issues that don't block — gaps, footguns, inconsistencies, missing tests or docs.
- **Optional**: consolidation candidates and improvements worth knowing about.

Then cover what's working, the checks run, the checks skipped and why, and any residual risk. Be thorough but concise: every finding actionable, with its location and confidence.
