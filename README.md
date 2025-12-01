# Claude Code Custom Commands

Slash commands for common workflows.

## Commands

| Command | Description |
|---------|-------------|
| [`/plan <task>`](commands/plan.md) | Explore codebase and create a detailed plan before execution |
| [`/task <description>`](commands/task.md) | Create a live task checklist that tracks progress in real-time |
| [`/deepthink <problem>`](commands/deepthink.md) | Deep analysis using parallel Opus agents with iterative refinement |
| [`/audit <files>`](commands/audit.md) | Analyze files for quality, consistency, and codebase integration |
| [`/doublecheck [focus]`](commands/doublecheck.md) | Verify all changes meet requirements and preserve correctness |
| [`/triage <feedback>`](commands/triage.md) | Investigate external feedback, validate issues, fix what's real |
| [`/read <files>`](commands/read.md) | Read files in full without summarization |
| [`/x <task-name>`](commands/x.md) | Execute task from `.ath_materials/TASK_*.md` |

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
