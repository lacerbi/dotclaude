---
description: Read files in context
allowed-tools: Bash(find:*), Bash(grep:*), Bash(ls:*), Bash(head:*), Bash(cat:*), Bash(wc:*), Bash(toks:*), Bash(du:*)
argument-hint: [file1 file2 ... or directory or description]
---
## Reading Task

**Files to read in full**: $ARGUMENTS

### Process

1. **Check file metrics** (all files in one command each):
   - Size in KB: `du -k file1 file2 ...`
   - Token count: `toks file1 file2 ...`
   - Line count: `wc -l file1 file2 ...`

2. **For each file, decide whether to split**:
   - If size > 80 KB OR tokens > 22,000 → split the file
   - Otherwise → read in full

3. **If splitting, calculate chunks**:
   - `chunks = max(ceil(size_kb / 80), ceil(tokens / 22000))`
   - `lines_per_chunk = ceil(total_lines / chunks)`
   - Read file in chunks using offset/limit

4. **Do NOT delegate** to subagents - read the files yourself

5. **After reading**: Wait for further instructions (do not summarize or take additional actions)