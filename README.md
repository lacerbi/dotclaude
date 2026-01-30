# Claude Code Custom Commands

Slash commands for common workflows.

## Commands

| Command | Description | Comments |
|---------|-------------|----------|
| [`/plan <task>`](commands/plan.md) | Explore project folder and create a detailed plan before execution | Replaces standard plan mode which uses subpar Haiku models as subagents |
| [`/task <description>`](commands/task.md) | Create a live task checklist that tracks progress in real-time | - |
| [`/deepthink <problem>`](commands/deepthink.md) | Deep analysis using parallel Opus agents with iterative refinement | Mimics [GPT 5.x Pro](https://platform.openai.com/docs/models/gpt-5-pro) or [Gemini](https://blog.google/products/gemini/gemini-2-5-deep-think/) parallel/deep thinking modes |
| [`/audit <files>`](commands/audit.md) | Analyze files for quality, consistency, and codebase integration | - |
| [`/doublecheck [focus]`](commands/doublecheck.md) | Verify all changes meet requirements and preserve correctness | - |
| [`/triage <feedback>`](commands/triage.md) | Investigate external feedback, validate issues, fix what's real | - |
| [`/read <files>`](commands/read.md) | Read files in full without summarization | Uses [`toks`](https://www.npmjs.com/package/toks) for token counting |
| [`/x <task-name>`](commands/x.md) | Execute task from `.ath_materials/TASK_*.md` | Obsolete |

## Scripts

| Script | Description |
|--------|-------------|
| [`bin/read-files`](bin/read-files) | Analyzes files and outputs reading instructions (chunking large files) |

## Usage

```
/plan implement user authentication
/task refactor the payment module
/deepthink should we use microservices or monolith?
/audit src/components/
/doublecheck authentication logic
/triage "the login button doesn't work on mobile"
/read src/config.ts src/utils.ts
```

## License

[MIT](LICENSE)
