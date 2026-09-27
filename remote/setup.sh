#!/bin/bash
# Install my global Claude Code config (github.com/lacerbi/dotclaude) into ~/.claude.
# A failure here must not stop the session from starting, so every step is soft.
SRC="$(mktemp -d)/dotclaude"
if git clone --depth 1 https://github.com/lacerbi/dotclaude "$SRC"; then
  mkdir -p ~/.claude/skills ~/.claude/bin
  cp -r "$SRC/skills/." ~/.claude/skills/
  rm -rf ~/.claude/skills/hpc  # the hpc launcher is not installed in the cloud
  cp "$SRC/bin/read-files" ~/.claude/bin/
  cp "$SRC/remote/CLAUDE.md" ~/.claude/CLAUDE.md \
    || echo "dotclaude has no remote/CLAUDE.md; no global CLAUDE.md installed" >&2
  npm install -g toks >/dev/null 2>&1 || echo "toks install failed: /load's read-files needs it" >&2
else
  echo "dotclaude clone failed; continuing without it" >&2
fi
exit 0
