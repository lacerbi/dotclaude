## Shell tooling

**Smoke tests / long runs must stream output.** Don't pipe `python ... | grep` — a non-TTY pipe makes Python block-buffer stdout, so nothing shows until it exits. `-u` (or `PYTHONUNBUFFERED=1`) is the key bit; have the script `print(..., flush=True)` on a cadence so there's something to watch.
- Run unbuffered to a **uniquely-named** log (don't clobber a prior run): `python -u script.py > runs/run_$(date +%s).log 2>&1` (background ok), then Read/`tail -F` it. Filter when *reading* (`grep` the file), not in the run pipe.

## Commit messages

Leave the session link out of commit messages and pull request descriptions: no `Claude-Session:` trailer and no `claude.ai/code/session_…` URL. Keep the `Co-Authored-By:` line.

## Python environments

**Create venvs with uv** (`uv venv` + `uv pip install -r requirements.txt`, or `uv sync` with a `pyproject.toml`), not `python -m venv` + pip. Cloud VMs have no GPU, and their network allowlist blocks the PyTorch wheel index (`download.pytorch.org`), so torch installs from PyPI as the CUDA build, which runs fine on CPU. Don't point uv at the PyTorch CPU index.

## Agent Selection

Sub-agents are **Opus** by default (`model: opus`) for planning, design, exploration, review, verification and implementation. Use Sonnet only for narrow, fully specified mechanical work where no judgment is needed (run a linter or test suite and report the result; apply a spelled-out edit). Do not use Haiku as a sub-agent. Use Fable when the user asks for it or when project instructions or an approved workflow call for it; it is too expensive to spawn routinely.

**Project instructions and approved workflows take precedence.** Explicit project instructions and approved workflows (a plan, skill or workflow the user approved or invoked) can override the model and effort defaults here and can prescribe their own agents, such as a Fable step or a fixed set of reviewers. Invoking or continuing such a workflow authorizes the agents it prescribes: run them as named, without asking again because a step uses Fable. Keep any model or reviewer choice the user made explicitly.

**Astra and Sol run as Opus here.** The user, or a plan or project instructions written for the companion Codex setup (`~/.codex`), can ask for its models: GPT-6 Astra or GPT-6.1 Sol. Cloud sessions cannot run OpenAI models, so give that work to an Opus sub-agent and tell the user about the substitution. Sol's work keeps its effort level; Astra's gets one level more (`high` → `xhigh`, `xhigh` → `max`, `max` stays `max`). When no effort is named, take it as `xhigh`. Do not substitute Fable for Astra unless Fable is separately authorized.

Give every executor the goal, context, constraints, the files it owns and acceptance checks, and leave routine details to its judgment. Add exact steps and commands where uncertainty, reproducibility or operational risk warrants them.

**Split large work that parallelises.** A large task usually goes to several agents, not one: when it splits into independent parts (per module, per file group, per question), fan out, with any shared code the parts depend on done first by one agent. A single agent for a large task is the exception, for work that really has to stay together. The same holds when writing plans: mark the phases or steps that can run in parallel.

## Documents have one reader: the person holding the final text

When writing or editing anything meant to stand alone (specs, docs, READMEs, docstrings, comments), write for a reader who has only the final text. They did not see the conversation or the previous version. The common failure is a sentence that is true and locally plausible but exists only because of the session: a reassurance about a concern the document never raised, a qualifier pointing at context the document never gave ("at this scale"), a "X, not Y" where no reader would have thought of Y, a "now" describing a change rather than a state. A fresh reader experiences each as a mild non-sequitur. Test every clause you add or change: would it exist, in this shape, if you were writing the document from scratch knowing only the final facts? If its shape comes from a correction or a debate in the session rather than from the subject, rewrite it from the subject. Mentioning a rejected alternative or an earlier behavior is fine when deliberate and given enough context to stand alone.