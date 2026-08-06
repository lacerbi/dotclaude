---
name: audit
disable-model-invocation: true
description: Analyze files for quality and consistency within the codebase
allowed-tools: Bash(find:*), Bash(grep:*), Bash(ls:*), Bash(head:*), Bash(cat:*), Write
argument-hint: [file1 file2 ... or directory or description]
---
## Files to Audit
$ARGUMENTS

## Context
- Project structure: !`ls -la`
- Recent modifications: !`git status --short 2>/dev/null || echo "Not a git repository"`

## Your Task

Treat the audit as read-only. Do not fix findings, edit files, create issues, or write an audit
artifact unless the user explicitly asks for one.

**Deploy specialized sub-agents as needed** to audit the specified files across these key areas. Use Opus for all audit tasks (Sonnet only for mechanical checks like linting output, test pass/fail status, or counting TODOs; never Haiku).

### 1. Correctness & Quality
- Bugs, errors, or logical flaws
- Completeness and accuracy
- Whether the file effectively serves its intended purpose

### 2. Codebase Integration
- Inconsistencies with related files (same directory, imports, dependencies)
- Conflicting patterns or duplicated functionality
- Missing companion files (tests, docs, configs)
- Broken references or dependencies

### 3. Standards & Best Practices
- Security vulnerabilities or unsafe patterns
- Performance issues or inefficiencies
- Maintainability concerns (complexity, documentation, naming)
- Compliance with project/industry standards

### 4. Impact & Risk
- What depends on these files
- Potential breaking changes
- Areas needing immediate attention

**Output**: Report the audit in the conversation by default. Include:
- Executive summary
- Detailed findings by area
- Prioritized action items
- Recommendations

If the user explicitly requests a file, write it at the repository's prescribed location or use
`AUDIT_[descriptor]_[timestamp].md` when no convention exists, then also provide a brief summary in
the conversation highlighting critical findings.
