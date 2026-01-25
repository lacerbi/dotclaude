---
description: Create and maintain a task checklist that tracks progress in real-time
allowed-tools: Write, Bash(ls:*), Bash(cat:*)
argument-hint: [task-description]
---
## Task
$ARGUMENTS

## Your Instructions

### 1. Use Existing Plan or Create Task Plan

**If a PLAN file was provided or mentioned** (e.g., from a prior `/plan` command) with structured phases:
- **Use the existing PLAN file** as your working document—do NOT create a separate TASK file
- Review the plan and convert implementation bullet points to checkboxes (e.g., "Work" items become `- [ ]` tasks)
- Add new checklist items or sections if gaps are apparent
- Continue to add items as needed during execution
- Update status markers in place as you progress

**If no suitable PLAN file exists**, create a markdown file `TASK_[descriptor]_[timestamp].md` containing:
- Task description
- Checklist of specific steps/subtasks
- Success criteria
- Any dependencies or prerequisites

**KEEP IT BRIEF AND TO THE POINT**:
- Each checklist item should be one concise line
- Link to relevant files rather than explaining details: `[config](./src/config.js)`
- No verbose descriptions - this is a tracking tool, not documentation

Format checklist items as:
- `[ ]` Not started
- `[~]` In progress
- `[x]` Complete
- `[!]` Blocked or needs attention

### 2. Execute While Updating

**CRITICAL**: You MUST update the checklist file after EVERY significant action:
- Mark items as `[~]` when starting them
- Mark items as `[x]` when completing them
- Add new subtasks if discovered during work
- Note any blockers or issues with `[!]`
- Keep any notes extremely brief or link to files

### 3. Work Pattern
Follow this pattern throughout:
1. Update checklist → Do work → Update checklist → Repeat
2. The file is your live working document
3. Anyone should be able to see current progress by reading the file

### 4. Completion Expectations

**Complete the full task/plan.** Do not arbitrarily skip items, defer work, or stop halfway. Minor deviations and unexpected issues are normal—handle them and continue. Only stop early if an overwhelming reason emerges during implementation (e.g., core assumptions are fundamentally wrong, blocking dependencies are unresolvable).

When finished, ensure the file shows:
- Final status of all items
- Any unresolved issues (with explanation if incomplete)
- Brief summary of completion

### 5. Sub-Agent Usage
If deploying sub-agents for subtasks:
- Update checklist to `[~]` before dispatching
- Sub-agent updates checklist to `[x]` or `[!]` upon completion
- Use Opus for complex subtasks, Sonnet for standard implementation (Haiku only for pure read-only information gathering with no interpretation needed—or just do trivial tasks directly)

### 6. Verification
After completing all checklist items, run `/doublecheck` to verify the work before marking the task fully complete.

**Remember**: The checklist file is your required working tracker. Keep entries brief, link to files for details, and update continuously as you progress.