---
name: handoff
description: Make the current work resumable from a clean checkout — commit/push, record in-flight async work, flag what isn't durable. INVOKE ONLY when the user explicitly runs /handoff or asks for a handoff.
---

# /handoff — make the work resumable from a clean checkout

Goal: a fresh `git clone` plus a read of the project's durable docs is enough for the next session to
resume — **except artifacts a project keeps local by design** (gitignored checkpoints, pools, weights,
venvs; `.gitignore` is the source of truth). Nothing meant to be tracked may live only in this
conversation, the working tree, or a session-bound process. Close every gap you find — don't just report it.

## 1. Commit and push what's meant to be tracked

- `git status` clean; local `HEAD` == `origin` (no unpushed commits).
- **Respect `.gitignore`** — don't commit the local-by-design artifacts above. If a file is a mid-edit, or
  you're unsure it should be tracked, surface it and confirm before committing.

## 2. Capture the session's substance (if any emerged)

Decisions and their rationale, findings/results, approaches tried and rejected, open questions — anything
from the discussion worth keeping that isn't already in the code — into the project's durable docs (DEVLOG
/ TODO / notes, whatever the project uses). The conversation is not durable: a decision or finding that
lives only in chat is lost. Skip if nothing substantive emerged or if it has already been recorded.

## 3. Record in-flight / async work

For anything still running or pending — cluster jobs, background processes, scheduled tasks, open PRs —
record in a durable doc its **ID**, the **exact command/config**, **where outputs land**, **how to
retrieve them**, and its **status**, so a reader can resume it without this conversation.

## 4. Surface what is NOT durable

- uncommitted files; remote/scratch artifacts not yet collected; local-only artifacts the next session
  must regenerate or fetch (say how);
- session-bound watchers / background tasks that die with this session (the underlying job keeps running —
  say how to re-attach by ID);
- auth / secrets / local state that won't carry over.

## 5. State the pickup point

In the durable doc (e.g. the top DEVLOG entry or a TODO file, etc.), not only your reply: where to resume, the next decision, and what unblocks it.

## Report

What's durable (committed/pushed), what's in flight (with the retrieve command), where you saved the information (if any), what isn't durable yet, and the one-line pickup point.
