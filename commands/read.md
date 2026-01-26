---
description: Read files in context
allowed-tools: Bash(find:*), Bash(grep:*), Bash(ls:*), Bash(head:*), Bash(cat:*), Bash(wc:*)
argument-hint: [file1 file2 ... or directory or description]
---
## Reading Task

**Files to read in full**: $ARGUMENTS

### Process
1. **Check file sizes first**: Run `wc -l` on all files to get line counts
2. **Read each file in full**:
   - Files ≤1000 lines: Read normally
   - Files >1000 lines: Read in chunks of 1000 lines using offset/limit until complete
3. **Do NOT delegate** to subagents - read the files yourself
4. **After reading**: Wait for further instructions (do not summarize or take additional actions)