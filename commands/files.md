---
description: Identify files needed to accomplish a task
allowed-tools: Bash(find:*), Bash(grep:*), Bash(ls:*), Glob, Grep, Read
argument-hint: <task description>
---
## Task
$ARGUMENTS

## Your Task

Identify the **essential context files** someone needs to read before starting this task — the files that rebuild the broader understanding an agent needs to avoid tunnel vision.

### What This Is For

A fresh agent is about to work on this task with a clean context window. It will naturally discover specific implementation files as it works. **Your job is different**: identify the 3–6 files that provide the *surrounding context* — the big picture that prevents the agent from being over-focused on the immediate task and making mistakes from ignorance.

### What to Include

- **The task/plan file** if one exists (e.g., `PLAN-foo.md`)
- **Core project docs**: Architecture files, design docs, devlogs, or READMEs that explain *why* things are the way they are — *if* they are useful to understand the broader context
- **Key conventions or patterns**: Files that show how similar work was done, or that establish standards the task must follow
- **Critical implicit context**: Things that someone familiar with the project would know but a fresh agent won't

### What NOT to Include

- Files the agent will find on its own through normal exploration
- Every file tangentially related to the task
- CLAUDE.md/AGENTS.md (loaded automatically)
- Long lists of implementation files — if you're listing more than ~6 files, you're being too granular

### Process

1. Understand the task scope
2. Explore the project for broader context docs (architecture, design, devlogs, guides)
3. Select the smallest set of files that gives a fresh agent the big picture

### Output Format

Output a short list with brief explanations:

```
path/to/file - why it matters for context
path/to/other - why it matters for context
```

Aim for **~6 files** (3–6 typical; a few extra are allowed if truly important, e.g., for a fragmented knowledge base). After outputting the list, stop — do not read the files or start working.
