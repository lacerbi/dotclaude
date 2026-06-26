## Shell tooling

I'm on Windows PowerShell. `@'...'@` here-strings work only in the PowerShell tool, not the Bash tool (and `<<'EOF'` only in Bash). For multi-line text like commit messages, use repeated `-m` flags.

## Agent Selection

When deploying sub-agents, calibrate agent intelligence to task complexity:

- **Haiku**: Only trivial, read-only tasks requiring no interpretation (listing files, reading contents, checking if something exists). Best suited for parallelizing many simple tasks at scale.
- **Sonnet**: Standard implementation, straightforward execution, mechanical checks (linting output, test pass/fail)
- **Opus**: Anything requiring judgment—analysis, review, verification, planning, debugging, architectural decisions

**Parallel fan-out — only one heavy-compute agent.** When fanning out parallel agents (e.g. for review/doublecheck), at most **ONE** may run heavy compute (GPU/CPU-intensive processes: training, torch, test suites, builds). Instruct the rest to go deep but stay **read-only / static-analysis** (reading files, reasoning, grepping) — explicitly tell them not to run such processes. Running heavy compute in several agents at once once froze the machine. Cleanest variant: keep the single heavy slot in the main thread yourself and make the whole fan-out read-only.

## hpc-launcher location

The `hpc` launcher (for the /hpc skill) is at: `/c/Users/luigi/Documents/GitHub/hpc-launcher`
