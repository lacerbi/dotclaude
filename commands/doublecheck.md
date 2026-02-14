---
description: Deep verification that all changes meet requirements and preserve correctness
allowed-tools: Bash(git diff:*), Bash(git status:*)
argument-hint: [specific-focus-area]
---
## Context
- Current changes: !`git diff HEAD`
- Modified files: !`git status --short`

Note: The diff may include concurrent/independent changes from other agents. **By default, focus on reviewing the changes we made in this conversation** unless otherwise specified.

## Your Task

Perform a meticulous verification and comprehensive review of all work done. **Depending on the size and complexity of the verification, deploy one or more specialized sub-agents** to handle different aspects, split as appropriate for the task. Choose sub-agents appropriate for task complexity (see `CLAUDE.md` for agent selection guidance—verification tasks typically need Opus, maybe Sonnet for routine verifications, never Haiku).

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

For **plans and design documents**, also check:
- Whether the proposed approach accounts for known constraints and prior decisions
- Feasibility of each step and whether dependencies between steps are correctly sequenced
- Whether the plan addresses verification and rollback
- Whether affected documentation (READMEs, API docs, guides) is updated or flagged for update

**Focus area (optional; if empty focus on all changes/files)**:

<focus> $ARGUMENTS </focus>

Provide a structured report highlighting what's working, any issues or concerns, and what still needs attention.

Be thorough but concise. Focus on actionable findings rather than minor stylistic preferences.