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

**Focus area (optional; if empty focus on all changes/files)**:

<focus> $ARGUMENTS </focus>

Provide a structured report highlighting what's working, any issues or concerns, and what still needs attention.

Be thorough but concise. Focus on actionable findings rather than minor stylistic preferences.