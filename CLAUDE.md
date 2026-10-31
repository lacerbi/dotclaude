## Shell tooling

The user is on Windows PowerShell. `@'...'@` here-strings work only in the PowerShell tool, not the Bash tool (and `<<'EOF'` only in Bash). For multi-line text like commit messages, use repeated `-m` flags.

**Smoke tests / long runs must stream output.** Don't pipe `python ... | grep` — a non-TTY pipe makes Python block-buffer stdout, so nothing shows until it exits. `-u` (or `PYTHONUNBUFFERED=1`) is the key bit; have the script `print(..., flush=True)` on a cadence so there's something to watch.
- **Local:** run unbuffered to a **uniquely-named** log (don't clobber a prior run): `python -u script.py > runs/run_$(date +%s).log 2>&1` (background ok), then Read/`tail -F` it. Filter when *reading* (`grep` the file), not in the run pipe.
- **HPC:** don't hand-redirect — Slurm captures each job's stdout to its own per-jobid file (so no clobber across runs). Use `hpc logs <job> --once` / `-n N` for occasional dumps, or `hpc logs` to follow. The script still needs periodic `flush=True` so the Slurm log updates before the job ends.

## Commit messages

Leave the session link out of commit messages and pull request descriptions: no `Claude-Session:` trailer and no `claude.ai/code/session_…` URL. Keep the `Co-Authored-By:` line.

## Python environments

**Create venvs with uv** (`uv venv` + `uv pip install -r requirements.txt`, or `uv sync` with a `pyproject.toml`), not `python -m venv` + pip. uv hardlinks packages from its cache, so venvs on the same package versions share disk; pip copies everything, and a CUDA torch venv is ~4.5 GB. Keep one venv per project, since projects pin different torch builds and install different editable sources. Install CPU torch unless the project actually runs on GPU, and when nothing pins the torch version, match a version that other local venvs already use, so the cached wheel is reused.

## Agent Selection

Sub-agents are **Opus** by default (`model: opus`) for planning, design, exploration, review, verification and implementation. Use Sonnet only for narrow, fully specified mechanical work where no judgment is needed (run a linter or test suite and report the result; apply a spelled-out edit). Do not use Haiku as a sub-agent. Use Fable when the user asks for it or when project instructions or an approved workflow call for it; it is too expensive to spawn routinely.

**Project instructions and approved workflows take precedence.** Explicit project instructions and approved workflows (a plan, skill or workflow the user approved or invoked) can override the model and effort defaults here and can prescribe their own agents, such as a Fable step, an Astra review or a fixed set of reviewers. Invoking or continuing such a workflow authorizes the agents it prescribes: run them as named, without asking again because a step uses Fable or Astra. Keep any model or reviewer choice the user made explicitly. The one-heavy-compute-agent rule (below) still applies, as do the limits of what the current environment can run.

**Choosing across Claude and Codex.** Pick each executor by what the assignment demands: its role, how uncertain it is and how much judgment it needs. In the user's experience so far, Astra handles complex work better than Sol, while ordinary coding suits Opus and Sol alike. Fable and Astra are worth adding for an independent perspective where their use is authorized. A model named in a request, plan or workflow is a choice to keep, not a label to translate to its nearest equivalent: an Astra or Sol executor runs as a Codex agent (see Codex agents).

Give every executor the goal, context, constraints, the files it owns and acceptance checks, and leave routine details to its judgment. Add exact steps and commands where uncertainty, reproducibility or operational risk warrants them.

**Split large work that parallelises.** A large task usually goes to several agents, not one: when it splits into independent parts (per module, per file group, per question), fan out, with any shared code the parts depend on done first by one agent. A single agent for a large task is the exception, for work that really has to stay together. The same holds when writing plans: mark the phases or steps that can run in parallel.

**Parallel fan-out — only one heavy-compute agent.** When fanning out parallel agents (e.g. for review/doublecheck), at most **ONE** may run heavy compute (GPU/CPU-intensive processes: training, torch, test suites, builds). Instruct the rest to go deep but stay **read-only / static-analysis** (reading files, reasoning, grepping) — explicitly tell them not to run such processes. Running heavy compute in several agents at once once froze the machine. Cleanest variant: keep the single heavy slot in the main thread yourself and make the whole fan-out read-only.

## Codex agents (Astra, Sol)

When the user asks for an "Astra agent" or an "Astra review", it means GPT-6 Astra (`gpt-6-astra`), run through the Codex CLI, not a Claude sub-agent; "Sol" means GPT-6.1 Sol (`gpt-6.1-sol`). Use the effort named by the user or by the plan or workflow that calls for the agent (`high`, `xhigh` or `max`), and `xhigh` when none is named. Run one when the user asks for it, or when project instructions or an approved plan, skill or workflow call for one; that call also authorizes it (see Agent Selection).

- **Brief.** Write a self-contained brief to a file: the goal, the files to read, what counts as a finding, the report's format, and the rules. Read-only is the default, and the one-heavy-compute rule applies to Codex agents too. Codex reads the repository's `AGENTS.md`, but not the conversation that asked for it.
- **Run.** Run it in the background, in a read-only sandbox (Bash syntax):
  `codex exec -m gpt-6-astra -c model_reasoning_effort='"xhigh"' -s read-only -C <repo> -o <report.md> - < <brief.md> > <log> 2>&1`
  Put `--search` before `exec` (`codex --search exec …`) when the task needs web sources. Use a writable sandbox (`-s workspace-write`) only when the user asks for edits, or when an approved plan or workflow gives the agent editing work.
- **Check.** The log's header names the model, the effort and the sandbox; read it once after starting. The final message goes to the `-o` file, and the log holds the whole run. A `max` run can take an hour.
- **Keep.** A report the work relies on goes where the project keeps its analysis outputs, not in a temporary directory.

## No memory system

**Never use the file-based memory system** (`~/.claude/projects/*/memory/`). Do not create or update memory files. Anything durable belongs in the repo/project itself, following **that** repo's own conventions for where such things live (each project is different — could be CLAUDE.md, AGENTS.md, a docs directory, skills, or something else; look at what the repo already does). If something seems worth remembering, propose adding it in the project's conventional place instead.

## Documents have one reader: the person holding the final text

When writing or editing anything meant to stand alone (specs, docs, READMEs, docstrings, comments), write for a reader who has only the final text. They did not see the conversation or the previous version. The common failure is a sentence that is true and locally plausible but exists only because of the session: a reassurance about a concern the document never raised, a qualifier pointing at context the document never gave ("at this scale"), a "X, not Y" where no reader would have thought of Y, a "now" describing a change rather than a state. A fresh reader experiences each as a mild non-sequitur. Test every clause you add or change: would it exist, in this shape, if you were writing the document from scratch knowing only the final facts? If its shape comes from a correction or a debate in the session rather than from the subject, rewrite it from the subject. Mentioning a rejected alternative or an earlier behavior is fine when deliberate and given enough context to stand alone.

When asking the user to decide something, in the chat or on a decision board, give them what they need to answer it: what the thing is, why it needs a decision, and whose idea it is, in the project's own terms. Assume they have not read the files, reviews or notes behind the question.

## hpc-launcher location

The `hpc` launcher (for the /hpc skill) is at: `~/Documents/GitHub/hpc-launcher`
