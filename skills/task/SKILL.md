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

Sub-agents are Opus by default (see Agent Selection in the global `CLAUDE.md`). When the plan states an executor per phase, follow it: delegated phases go to Opus sub-agents, orchestrator phases you do yourself. The delegated phase's text is the core of the sub-agent's brief; add only what is situational (current tree state, conventions learned so far, return format, files another agent owns).

A phase written for a different model than you is not ready to execute. In particular, a `Fable (orchestrator)` phase has no step list; if you are Opus, expand it in the plan to explicit steps with files, commands, and acceptance checks, tell the user you did so, and only then execute it.

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
