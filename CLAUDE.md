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

Sub-agents are **Opus** by default (`model: opus`) for planning, design, exploration, review, verification and implementation. Use Sonnet only for narrow, fully specified mechanical work where no judgment is needed (run a linter or test suite and report the result; apply a spelled-out edit), and for exploration that only has to find or identify something; exploration that must produce a high-quality summary goes to Opus. Do not use Haiku as a sub-agent. Use Fable when the user asks for it or when project instructions or an approved workflow call for it; it is too expensive to spawn routinely.

**Project instructions and approved workflows take precedence.** Explicit project instructions and approved workflows (a plan, skill or workflow the user approved or invoked) can override the model and effort defaults here and can prescribe their own agents, such as a Fable step, an Astra review or a fixed set of reviewers. Invoking or continuing such a workflow authorizes the agents it prescribes: run them as named, without asking again because a step uses Fable or Astra. Keep any model or reviewer choice the user made explicitly. The one-heavy-compute-agent rule (below) still applies, as do the limits of what the current environment can run.

**Choosing across Claude and Codex.** Pick each executor by what the assignment demands: its role, how uncertain it is and how much judgment it needs. In the user's experience so far, Astra handles complex work better than Sol, while ordinary coding suits Opus and Sol alike. Fable and Astra are worth adding for an independent perspective where their use is authorized. Keep the model a request, plan or workflow names: run a named Astra, Sol or Terra executor as a Codex agent (see Codex agents).

Give every executor the goal, context, constraints, the files it owns and acceptance checks, and leave routine details to its judgment. Add exact steps and commands where uncertainty, reproducibility or operational risk warrants them.

**Split large work that parallelises.** A large task usually goes to several agents, not one: when it splits into independent parts (per module, per file group, per question), fan out, with any shared code the parts depend on done first by one agent. A single agent for a large task is the exception, for work that really has to stay together. The same holds when writing plans: mark the phases or steps that can run in parallel.

**Parallel fan-out — only one heavy-compute agent.** When fanning out parallel agents (e.g. for review/doublecheck), at most **ONE** may run heavy compute (GPU/CPU-intensive processes: training, torch, test suites, builds). Instruct the rest to go deep but leave reviewed sources unchanged and use **static analysis** (reading files, reasoning, grepping), writing only their assigned reports when required — explicitly tell them not to run such processes. Running heavy compute in several agents at once once froze the machine. Cleanest variant: keep the single heavy slot in the main thread yourself and keep the whole fan-out limited to static analysis and its assigned report files.

## Agent-authored documents

When you delegate a draft, proposal or report longer than a short reply, assign it an output
file: give the agent the file's exact path, file-writing tools and, in its task message, the
instruction to write the document to that file instead of returning it in its final reply.
Once its initial source reading is done, the agent creates the file with its title and
outline, then writes the document section by section, composing each section just before it
saves it, in sections of a size it judges manageable. It continues without human prompts
between sections and reads and checks the completed file; its final reply gives only the
path, whether the document is complete and a short summary.

Assign exclusive ownership of the output. Reviewing sources does not authorize editing them,
the brief or other agents' files; after the run, check that nothing outside the assigned
output changed (`git status --short` in a repository). Keep stdout, stderr and any
`codex exec -o` file separate from the document, so that a launch or an exit cannot
overwrite saved sections. Leave turn limits and output allowances at their defaults: writing
in sections takes many turns, and a smaller allowance leaves less room to reason before each
save. After an interruption, keep the partial file and its log, relaunch with a new log
name, and have the resumed or new agent continue the existing file, adding only the missing
sections. A review whose brief asks for its findings in the final reply and assigns no file,
and output that a program parses, keep the delivery their brief defines.

## Codex agents (Astra, Sol, Terra)

When the user asks for an "Astra agent" or an "Astra review", it means GPT-6 Astra (`gpt-6-astra`), run through the Codex CLI, not a Claude sub-agent; "Sol" means GPT-6.1 Sol (`gpt-6.1-sol`), and "Terra", a lighter model for mechanical work, means GPT-6.1 Terra (`gpt-6.1-terra`). Use the effort named by the user or by the plan or workflow that calls for the agent (`high`, `xhigh` or `max`), and `xhigh` when none is named. Run one when the user asks for it, or when project instructions or an approved plan, skill or workflow call for one; that call also authorizes it (see Agent Selection).

Always pass these exact IDs with `-m`. Do not use the 6.2 versions of Astra or Sol (reported regressions, 2026-11-17) until the user says so.

- **Brief.** Write a self-contained brief to a file: the goal, the files to read and the rules, plus what counts as a finding and the report's format for a review, or what Agent Selection says every executor gets for execution. Source files stay unchanged unless edits are authorized; an assigned report is writable and follows Agent-authored documents above. The one-heavy-compute rule applies to Codex agents too. Codex reads the repository's `AGENTS.md`, but not the conversation that asked for it.
- **Run.** For an assigned document, put its exact absolute path and the writing instructions of Agent-authored documents in the brief. Run in the background with file-writing permission (Bash syntax):
  `codex exec -m gpt-6-astra -c model_reasoning_effort='"xhigh"' -s workspace-write -C <repo> --add-dir <output-directory> - < <brief.md> > <run.log> 2>&1`
  The workspace sandbox is broader than the brief's file-ownership rule: the agent may write only its assigned output. `--add-dir` covers an output directory outside the workspace. For a review that answers in its final reply and has no output file, use `-s read-only`, omit `--add-dir` and save the reply with `-o <review.md>`. Put `--search` before `exec` (`codex --search exec …`) when the task needs web sources.
- **Check.** The log's header names the model, the effort and the sandbox; read it once after starting. The report grows on disk through file-tool writes; stdout and any `-o` file hold only the short handback, separate from the report. Completion requires a successful exit, a completion reply and inspection of the saved document. A `max` run can take an hour.
- **Keep.** A report the work relies on goes where the project keeps its analysis outputs, not in a temporary directory.

## Antigravity agents

"Neon" means Gemini 4 Neon, run through the Antigravity CLI (`agy`). Use one only when the user explicitly asks for a Gemini agent. Write its brief to a file as for Codex agents. It writes no files, so its final reply is the document, saved from stdout. Run it in the background:
`agy -p 'Read and follow <brief.md>; reply with the complete document only.' --model gemini-4-neon-xhigh --effort xhigh --add-dir <dir> > <output.md> 2> <run.log>`
To check which files it read, look at the `read_file` calls in its transcript, `~/.gemini/antigravity-cli/brain/<session>/.system_generated/logs/transcript_full.jsonl`.

## No memory system

**Never use the file-based memory system** (`~/.claude/projects/*/memory/`). Do not create or update memory files. Anything durable belongs in the repo/project itself, following **that** repo's own conventions for where such things live (each project is different — could be CLAUDE.md, AGENTS.md, a docs directory, skills, or something else; look at what the repo already does). If something seems worth remembering, propose adding it in the project's conventional place instead.

## Documents have one reader: the person holding the final text

When writing or editing anything meant to stand alone (specs, docs, READMEs, docstrings, comments), write for a reader who has only the final text. They did not see the conversation or the previous version. The common failure is a sentence that is true and locally plausible but exists only because of the session: a reassurance about a concern the document never raised, a qualifier pointing at context the document never gave ("at this scale"), a "X, not Y" where no reader would have thought of Y, a "now" describing a change rather than a state. A fresh reader experiences each as a mild non-sequitur. Test every clause you add or change: would it exist, in this shape, if you were writing the document from scratch knowing only the final facts? If its shape comes from a correction or a debate in the session rather than from the subject, rewrite it from the subject. Mentioning a rejected alternative or an earlier behavior is fine when deliberate and given enough context to stand alone.

When asking the user to decide something, in the chat or on a decision board, give them what they need to answer it: what the thing is, why it needs a decision, and whose idea it is, in the project's own terms. Assume they have not read the files, reviews or notes behind the question.

## hpc-launcher location

The `hpc` launcher (for the /hpc skill) is at: `~/Documents/GitHub/hpc-launcher`
