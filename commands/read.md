---
description: Read files in context
allowed-tools: Bash(~/.claude/bin/read-files:*), Read
argument-hint: [file1 file2 ... or glob pattern]
---
## Reading Task

**Files to read**: $ARGUMENTS

### Process

1. Run the analysis script:
   ```bash
   ~/.claude/bin/read-files file1 file2 ...
   ```

2. Follow the output instructions exactly:
   - `READ FULL: path` → Use Read tool on the file with no offset/limit
   - `CHUNK: path` → Use Read tool with the specified offset and limit for each chunk

3. **After reading**: Wait for further instructions (do not summarize or take additional actions)
