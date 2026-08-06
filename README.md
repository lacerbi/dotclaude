# Claude Code Skills

Personal [skills](https://code.claude.com/docs/en/skills) for common Claude Code workflows. Each lives in `skills/<name>/SKILL.md` and runs when you type `/<name>`; some can also be invoked by Claude on its own when relevant.

## Skills

| Skill | Description | Invoke | Comments |
|-------|-------------|--------|----------|
| [`/plan <task>`](skills/plan/SKILL.md) | Explore the project and create a detailed plan before execution | Explicit | Replaces standard plan mode, which uses subpar Haiku models as subagents |
| [`/task <description>`](skills/task/SKILL.md) | Create a live task checklist that tracks progress in real-time | Auto | - |
| [`/deepthink <problem>`](skills/deepthink/SKILL.md) | Deep analysis using parallel Opus agents with iterative refinement | Explicit | Mimics [GPT 5.x Pro](https://platform.openai.com/docs/models/gpt-5-pro) or [Gemini](https://blog.google/products/gemini/gemini-2-5-deep-think/) parallel/deep thinking modes |
| [`/files <task>`](skills/files/SKILL.md) | Identify the essential context files to read before starting a task | Explicit | - |
| [`/load <files>`](skills/load/SKILL.md) | Read files in full without summarization | Auto | Uses [`toks`](https://www.npmjs.com/package/toks) for token counting |
| [`/audit <files>`](skills/audit/SKILL.md) | Analyze files for quality, consistency, and codebase integration | Explicit | - |
| [`/doublecheck [focus]`](skills/doublecheck/SKILL.md) | Verify all changes meet requirements and preserve correctness | Auto | - |
| [`/triage <feedback>`](skills/triage/SKILL.md) | Investigate external feedback, validate issues, fix what's real | Explicit | - |
| [`/handoff`](skills/handoff/SKILL.md) | Make work resumable from a clean checkout: commit/push, record in-flight async work, flag what isn't durable | Explicit | - |
| [`/hpc`](skills/hpc/SKILL.md) | Launch and manage jobs on the HPC cluster | Explicit | Requires the `hpc` launcher tool |

**Invoke**: *Auto* skills may be triggered by Claude when relevant; *Explicit* skills run only when you call `/<name>` (or ask for them) — they set `disable-model-invocation: true` or are explicit-only by convention.

## Scripts

| Script | Description |
|--------|-------------|
| [`bin/read-files`](bin/read-files) | Analyzes files and outputs reading instructions (chunking large files) |

## Usage

```
/plan implement user authentication
/task refactor the payment module
/deepthink should we use microservices or monolith?
/files add a caching layer to the API
/audit src/components/
/doublecheck authentication logic
/triage "the login button doesn't work on mobile"
/load src/config.ts src/utils.ts
/handoff
```

## Adding a skill

Skills are published one at a time. A new `skills/<name>/` is ignored by default —
add `!skills/<name>/**` to `.gitignore` to publish it. This keeps skills that carry
machine paths, hostnames, or private-project details local unless you opt in.

## License

[MIT](LICENSE)
