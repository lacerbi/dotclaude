## Shell tooling

**Smoke tests / long runs must stream output.** Don't pipe `python ... | grep` — a non-TTY pipe makes Python block-buffer stdout, so nothing shows until it exits. `-u` (or `PYTHONUNBUFFERED=1`) is the key bit; have the script `print(..., flush=True)` on a cadence so there's something to watch.
- Run unbuffered to a **uniquely-named** log (don't clobber a prior run): `python -u script.py > runs/run_$(date +%s).log 2>&1` (background ok), then Read/`tail -F` it. Filter when *reading* (`grep` the file), not in the run pipe.

## Commit messages

Leave the session link out of commit messages and pull request descriptions: no `Claude-Session:` trailer and no `claude.ai/code/session_…` URL. Keep the `Co-Authored-By:` line.

## Python environments

**Create venvs with uv** (`uv venv` + `uv pip install -r requirements.txt`, or `uv sync` with a `pyproject.toml`), not `python -m venv` + pip. Cloud VMs have no GPU, and their network allowlist blocks the PyTorch wheel index (`download.pytorch.org`), so torch installs from PyPI as the CUDA build, which runs fine on CPU. Don't point uv at the PyTorch CPU index.

## Agent Selection

Sub-agents are **Opus** by default (`model: opus`) — exploration, review, verification, and implementation alike. Use Sonnet only for narrow, fully specified mechanical work where no judgment is needed (run a linter or test suite and report the result; apply a spelled-out edit). Never Haiku: it is a generation behind and can't be trusted with interpretation. Fable sub-agents only when the user asks for them — too expensive to spawn routinely.

**Cross-ecosystem roles: Astra ≈ Fable, Sol ≈ Opus.** The companion Codex setup (`~/.codex`) names its models that way, and plans written there label executors accordingly; read an Astra phase as written for Fable and a Sol phase as written for Opus.

**Split large work that parallelises.** A large task usually goes to several agents, not one: when it splits into independent parts (per module, per file group, per question), fan out, with any shared code the parts depend on done first by one agent. A single agent for a large task is the exception, for work that really has to stay together. The same holds when writing plans: mark the phases or steps that can run in parallel.

## Documents have one reader: the person holding the final text

When writing or editing anything meant to stand alone (specs, docs, READMEs, docstrings, comments), write for a reader who has only the final text. They did not see the conversation or the previous version. The common failure is a sentence that is true and locally plausible but exists only because of the session: a reassurance about a concern the document never raised, a qualifier pointing at context the document never gave ("at this scale"), a "X, not Y" where no reader would have thought of Y, a "now" describing a change rather than a state. A fresh reader experiences each as a mild non-sequitur. Test every clause you add or change: would it exist, in this shape, if you were writing the document from scratch knowing only the final facts? If its shape comes from a correction or a debate in the session rather than from the subject, rewrite it from the subject. Mentioning a rejected alternative or an earlier behavior is fine when deliberate and given enough context to stand alone.