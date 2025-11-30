---
description: Read files in context
allowed-tools: Bash(find:*), Bash(grep:*), Bash(ls:*), Bash(head:*), Bash(cat:*)
argument-hint: [file1 file2 ... or directory or description]
---
## Reading Task
1. Read the following files **in full**: $ARGUMENTS
  - If a file is too large for a single read action, the tool will indicate truncation
  - In that case, read it in full using appropriately sized chunks until complete (e.g., 1000 lines at a time)
2. Do NOT delegate this task to subagents - read the files yourself
3. After reading, do not summarize the files: just wait for further instructions without taking additional actions