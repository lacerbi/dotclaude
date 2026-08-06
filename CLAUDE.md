## Shell tooling

I'm on Windows PowerShell. `@'...'@` here-strings work only in the PowerShell tool, not the Bash tool (and `<<'EOF'` only in Bash). For multi-line text like commit messages, use repeated `-m` flags.

**Smoke tests / long runs must stream output.** Don't pipe `python ... | grep` — a non-TTY pipe makes Python block-buffer stdout, so nothing shows until it exits. `-u` (or `PYTHONUNBUFFERED=1`) is the key bit; have the script `print(..., flush=True)` on a cadence so there's something to watch.
- **Local:** run unbuffered to a **uniquely-named** log (don't clobber a prior run): `python -u script.py > runs/run_$(date +%s).log 2>&1` (background ok), then Read/`tail -F` it. Filter when *reading* (`grep` the file), not in the run pipe.
- **HPC:** don't hand-redirect — Slurm captures each job's stdout to its own per-jobid file (so no clobber across runs). Use `hpc logs <job> --once` / `-n N` for occasional dumps, or `hpc logs` to follow. The script still needs periodic `flush=True` so the Slurm log updates before the job ends.

## Agent Selection

When deploying sub-agents, calibrate agent intelligence to task complexity:

- **Haiku**: Only trivial, read-only tasks requiring no interpretation (listing files, reading contents, checking if something exists). Best suited for parallelizing many simple tasks at scale.
- **Sonnet**: Standard implementation, straightforward execution, mechanical checks (linting output, test pass/fail)
- **Opus**: Anything requiring judgment—analysis, review, verification, planning, debugging, architectural decisions

**Parallel fan-out — only one heavy-compute agent.** When fanning out parallel agents (e.g. for review/doublecheck), at most **ONE** may run heavy compute (GPU/CPU-intensive processes: training, torch, test suites, builds). Instruct the rest to go deep but stay **read-only / static-analysis** (reading files, reasoning, grepping) — explicitly tell them not to run such processes. Running heavy compute in several agents at once once froze the machine. Cleanest variant: keep the single heavy slot in the main thread yourself and make the whole fan-out read-only.

## No memory system

**Never use the file-based memory system** (`~/.claude/projects/*/memory/`). Do not create or update memory files. Anything durable belongs in the repo/project itself, following **that** repo's own conventions for where such things live (each project is different — could be CLAUDE.md, AGENTS.md, a docs directory, skills, or something else; look at what the repo already does). If something seems worth remembering, propose adding it in the project's conventional place instead.

## hpc-launcher location

The `hpc` launcher (for the /hpc skill) is at: `~/Documents/GitHub/hpc-launcher`
