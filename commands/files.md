---
description: Identify files needed to accomplish a task
allowed-tools: Bash(find:*), Bash(grep:*), Bash(ls:*), Glob, Grep, Read
argument-hint: <task description>
---
## Task
$ARGUMENTS

## Your Task

Output a list of files that someone should read before working on this task.

### 1. Assess Your Knowledge

Do you already have enough context about this project and task to identify the relevant files?

- **If yes**: Skip exploration, go directly to output
- **If no**: Do targeted exploration (Glob, Grep, file reads) to identify relevant files

Be efficient. Don't explore if you already know the answer from the current session.

### 2. Output Format

Output a simple list of files with brief explanations:

```
path/to/file.md - why it's relevant
path/to/other.txt - why it's relevant
```

Guidelines:
- **Be selective**: Only include files genuinely needed for the task
- **Order by importance**: Most critical files first
- **Keep explanations minimal**: A few words per file
- **Use full relative paths**: From project root
- **Group logically**: If helpful, group related files together

### 3. No Additional Actions

After outputting the list:
- Do NOT read the files
- Do NOT start working on the task
- Do NOT provide lengthy analysis
- Just output the file list and stop
