---
name: hpc
description: >-
  Launch and manage jobs on the HPC cluster (INVOKE ONLY when the user explicitly runs /hpc or asks to use this skill).
---

# /hpc — launch work on the HPC cluster

You run the `hpc` launcher yourself to put the user's work on the cluster. That is
the point of the tool — do not hand commands to the user to run, unless asked.

## 1. Find the launcher

1. Look for its path in the user's global `~/.claude/CLAUDE.md`, under an
   `## hpc-launcher location` heading.
2. If it isn't there, discover it: run `command -v hpc` with the **Bash tool**
   (Git Bash) and take the directory of that path. If that fails, ask the user
   where the `hpc-launcher` folder is.
3. Record it so later calls skip discovery — append to `~/.claude/CLAUDE.md`:

   ```
   ## hpc-launcher location
   The `hpc` launcher (for the /hpc skill) is at: `<absolute path>`
   ```

## 2. Read the launcher's own docs

- `<path>/README.md` — what it does, setup, every command. **Always.**
- `<path>/clusters/<HPC_CLUSTER>.md` — facts for the cluster this repo targets
  (`HPC_CLUSTER` in `.hpc.env`; `hpc clusters` lists them). Read it when running or
  configuring a job — partitions, filesystem, gotchas (e.g. Roihu's split login
  hosts + 24 h SSH cert).
- `<path>/AGENTS.md`, `DESIGN.md`, `TODO.md` — only when you need rationale,
  limitations, or current status.

Read the live files. Do not rely on remembered defaults (partitions, modules,
torch module/wheel, walltimes) — they live in the cluster's `clusters/<name>.env`
profile and `hpc-env.example`, not in your memory.

## 3. Run it yourself

- `hpc` is bash; use the **Bash tool** (Git Bash / MSYS), not PowerShell.
- Execute the commands directly — `hpc run`, `hpc test`, `hpc status`, `hpc logs`,
  `hpc collect`, `hpc upload`, `hpc wait`, `hpc init`, etc. Don't delegate them to
  the user. (For unattended/scripted use, `hpc wait` blocks until a job is done and
  exits its rc, and `hpc status --json` / `hpc logs --once` are non-interactive —
  see the README.)
- Auth: the user's ssh-agent holds the cluster key. If an `hpc` call fails on SSH
  auth, ask the user to load it once (`ssh-add` their key), then keep running the
  commands yourself.
- A project needs a `.hpc.env` (run `hpc init`) before `hpc run` / `hpc test`.

## 4. Carry out the user's request, following the docs you just read.
