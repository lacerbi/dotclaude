---
description: Read files in context
allowed-tools: Bash(~/.claude/bin/read-files:*), Read, Glob
argument-hint: [file1 file2 ... or glob pattern]
---
## Reading Task

**User input**: $ARGUMENTS

### Process

1. **Resolve file references first**:
   - If inputs are already valid absolute/relative paths, use them directly
   - If inputs are ambiguous (partial names, no extension, shorthand), resolve them:
     - Use project context (CLAUDE.md, known directory structure)
     - Use Glob to find matching files if needed
     - Apply common sense (e.g., "index" in a docs project → `docs/index.md`)
   - Confirm the resolved paths exist before proceeding

2. **Run the analysis script** with resolved paths:
   ```bash
   ~/.claude/bin/read-files path1 path2 ...
   ```

3. **Follow the output instructions exactly**:
   - `READ FULL: path` → Use Read tool on the file with no offset/limit
   - `CHUNK: path` → Use Read tool with the specified offset and limit for each chunk

4. **After reading**: Wait for further instructions (do not summarize or take additional actions)
