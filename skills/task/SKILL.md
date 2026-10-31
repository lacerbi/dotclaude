---
name: task
description: Create and maintain a task checklist that tracks progress in real-time
allowed-tools: Read, Edit, Write
argument-hint: [task-description]
---
## Task
$ARGUMENTS

## Your Instructions

### 1. Use Existing Plan or Create Task Plan

**If a PLAN file was provided or mentioned** (e.g., from a prior `/plan` command) with structured phases, it is your working document — do not create a separate TASK file.

**Never replace or condense a PLAN file.** It is the user's reviewed work product: goals, file references, verification details, rationale. Add tracking to it in place — convert implementation bullets to checkboxes (`- Item` → `- [ ] Item`), append new items or sections as gaps appear, update status markers as you progress — so that the checkboxes sit alongside the existing prose, never instead of it. An edit that removes more text than it adds is almost certainly wrong.

**If no suitable PLAN file exists**, create a markdown file `TASK_[descriptor]_[timestamp].md` containing:
- Task description
- Checklist of specific steps/subtasks
- Success criteria
- Any dependencies or prerequisites

Keep it brief: one concise line per item, links to files instead of explanations (`[config](./src/config.js)`). This is a tracking tool, not documentation.

Status markers:
- `[ ]` Not started
- `[~]` In progress
- `[x]` Complete
- `[!]` Blocked or needs attention

### 2. Execute While Updating

Update the checklist after every significant action — `[~]` when starting an item, `[x]` when done, `[!]` on blockers — and add subtasks as they surface. The file is the live record: sessions crash mid-run, and anyone (including a fresh session) must be able to read current progress from the file alone. Keep notes extremely brief or link to files.

### 3. Completion Expectations

Complete the full task/plan. Do not skip items, defer work, or stop halfway; minor deviations and unexpected issues are normal — handle them and continue. Stop early only for an overwhelming reason (core assumptions fundamentally wrong, blocking dependencies unresolvable).

When finished, the file shows the final status of all items, any unresolved issues (with explanation if incomplete), and a brief completion summary.

### 4. Sub-Agent Usage

Use the executor the plan names for each phase (see Agent Selection in the global `CLAUDE.md`). Carry out orchestrator phases yourself and delegate the others to the named model as the global `CLAUDE.md` describes: Claude models through the Agent tool, Astra and Sol through the Codex CLI where it is available. The phase text is the core of the sub-agent's brief; add current tree state, relevant conventions, return format and the files the sub-agent owns.

Before execution, fill missing context or task-critical detail in the plan, with concrete steps, paths and commands where the work's uncertainty or risk warrants them. Let the executor investigate evidence that contradicts a plan assumption. Preserve the goal and decisions; seek input only for a material change beyond the user's authorization. Tell the user about every substantial or consequential change you make to the approved plan, whether it fills a gap or follows from an investigation; minor ones need no mention. A model change alone does not require rewriting a sufficient approved phase.

- Update the checklist to `[~]` before dispatching
- The sub-agent (or you, from its result) marks `[x]` or `[!]` on completion

### 5. Verification

After completing all checklist items, run `/doublecheck` before marking the task complete. It briefs fresh-context reviewers rather than relying on your own recollection, and it consistently catches problems the executor missed.

### 6. Task File Disposition

Apply only to `TASK_*.md` files created by this skill, never to existing PLAN files.

After `/doublecheck` passes:

- Delete the TASK file if it contains only transient execution tracking, routine verification, and a completion summary.
- If it records durable findings, decisions, constraints, or follow-ups, propose an appropriate destination based on repository conventions.
- After approval, preserve the information there and delete the TASK file, unless archiving the file itself is appropriate.
- Keep the file while work is incomplete or blocked.
