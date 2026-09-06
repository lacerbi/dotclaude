## Shell tooling

I'm on Windows PowerShell. `@'...'@` here-strings work only in the PowerShell tool, not the Bash tool (and `<<'EOF'` only in Bash). For multi-line text like commit messages, use repeated `-m` flags.

**Smoke tests / long runs must stream output.** Don't pipe `python ... | grep` — a non-TTY pipe makes Python block-buffer stdout, so nothing shows until it exits. `-u` (or `PYTHONUNBUFFERED=1`) is the key bit; have the script `print(..., flush=True)` on a cadence so there's something to watch.
- **Local:** run unbuffered to a **uniquely-named** log (don't clobber a prior run): `python -u script.py > runs/run_$(date +%s).log 2>&1` (background ok), then Read/`tail -F` it. Filter when *reading* (`grep` the file), not in the run pipe.
- **HPC:** don't hand-redirect — Slurm captures each job's stdout to its own per-jobid file (so no clobber across runs). Use `hpc logs <job> --once` / `-n N` for occasional dumps, or `hpc logs` to follow. The script still needs periodic `flush=True` so the Slurm log updates before the job ends.

## Agent Selection

Sub-agents are **Opus** by default (`model: opus`) — exploration, review, verification, and implementation alike. Use Sonnet only for narrow, fully specified mechanical work where no judgment is needed (run a linter or test suite and report the result; apply a spelled-out edit). Never Haiku: it is a generation behind and can't be trusted with interpretation. Fable sub-agents only when the user asks for them — too expensive to spawn routinely.

**Cross-ecosystem roles: Astra ≈ Fable, Sol ≈ Opus.** The companion Codex setup (`~/.codex`) names its models that way, and plans written there label executors accordingly; read an Astra phase as written for Fable and a Sol phase as written for Opus.

**Parallel fan-out — only one heavy-compute agent.** When fanning out parallel agents (e.g. for review/doublecheck), at most **ONE** may run heavy compute (GPU/CPU-intensive processes: training, torch, test suites, builds). Instruct the rest to go deep but stay **read-only / static-analysis** (reading files, reasoning, grepping) — explicitly tell them not to run such processes. Running heavy compute in several agents at once once froze the machine. Cleanest variant: keep the single heavy slot in the main thread yourself and make the whole fan-out read-only.

## No memory system

**Never use the file-based memory system** (`~/.claude/projects/*/memory/`). Do not create or update memory files. Anything durable belongs in the repo/project itself, following **that** repo's own conventions for where such things live (each project is different — could be CLAUDE.md, AGENTS.md, a docs directory, skills, or something else; look at what the repo already does). If something seems worth remembering, propose adding it in the project's conventional place instead.

## Documents have one reader: the person holding the final text

When writing or editing anything meant to stand alone (specs, docs, READMEs, docstrings, comments), write for a reader who has only the final text. They did not see the conversation or the previous version. The common failure is a sentence that is true and locally plausible but exists only because of the session: a reassurance about a concern the document never raised, a qualifier pointing at context the document never gave ("at this scale"), a "X, not Y" where no reader would have thought of Y, a "now" describing a change rather than a state. A fresh reader experiences each as a mild non-sequitur. Test every clause you add or change: would it exist, in this shape, if you were writing the document from scratch knowing only the final facts? If its shape comes from a correction or a debate in the session rather than from the subject, rewrite it from the subject. Mentioning a rejected alternative or an earlier behavior is fine when deliberate and given enough context to stand alone.

## hpc-launcher location

The `hpc` launcher (for the /hpc skill) is at: `~/Documents/GitHub/hpc-launcher`
