---
name: plan
disable-model-invocation: true
description: Create a detailed plan with exploration before execution
argument-hint: <task description>
---
You are planning, not executing. Explore and analyze first; probing is part of that — run scripts,
tests, or quick experiments where they resolve a real uncertainty about the task. Don't start on the
task itself until the user confirms the plan.

## Phase 1: Task Understanding

State your understanding of the task: $ARGUMENTS

If unclear, use AskUserQuestion to clarify before proceeding.

**Assess complexity** to calibrate planning depth:
- **Simple**: Single-focus task, few components → lighter exploration, concise plan
- **Moderate**: Multiple components or unknowns → targeted exploration, structured plan
- **Complex**: Cross-cutting concerns, many dependencies → thorough exploration, detailed plan

## Phase 2: Exploration

Explore the project to understand what exists and what the task involves. Scale exploration to task complexity.

**For simple tasks**: You may explore directly without subagents.

**For moderate/complex tasks**: Spawn Explore agents in parallel (Agent tool, subagent_type='Explore'), each focused on a relevant aspect:

- **Structure Explorer**: Project organization, key components, how things connect
- **Prior Work Explorer**: Existing similar work, patterns, or approaches to build on
- **Context Explorer**: Related materials, dependencies, constraints
- **Domain Explorer**: Subject matter, conventions, standards relevant to the task
- **Docs Explorer**: Documentation (READMEs, guides, API docs, comments) — what exists in or adjacent to the task area, what will need updating, and what doesn't exist yet but should

(For code-heavy tasks: Architecture, Feature, Dependency, Test explorers may be more appropriate)

Explore agents run as Opus (see Agent Selection in the global `CLAUDE.md`). Instruct them to:
- Return hypotheses, not conclusions
- Provide full file paths for relevant files
- Identify locations, not deep analysis
- Be thorough but efficient - scouts, not implementers

## Phase 3: Synthesis

After exploration:
1. Read/verify key files and materials identified — verify, don't assume
2. Confirm or refute hypotheses
3. Build a mental model of the current state and what the task requires
4. Identify existing documentation that must be updated, and whether any new document has a distinct durable purpose
5. Decide the execution shape — what you will do yourself and what you will delegate to Opus sub-agents (see Phase 4) — and record it per phase when writing the plan

Before proposing a new document:
- Identify the durable audience or question it will serve and the information it will uniquely own.
- Check project conventions and existing authoritative docs, plans, source comments, tests, TODOs,
  and issues first.
- Prefer updating an existing authoritative artifact when it can serve the same purpose.
- Do not create a new artifact merely to restate the plan or record work performed.

## Phase 4: Plan Creation

Create a plan file named `PLAN-<task-slug>.md` (e.g., `PLAN-add-user-auth.md`) in the project root, unless the user or project instructions (CLAUDE.md, AGENTS.md) specify a different location. The task slug should be lowercase, hyphen-separated, and concise (3-5 words max).

Write each phase for whoever will execute it, and name that executor by model — `Fable (orchestrator)`,
`Opus (orchestrator)`, or `Opus sub-agent` — so a later session on a different model can tell whether
the phase is written for it:

- **Opus-executed** (an Opus orchestrator, or a sub-agent delegated by Fable): explicit numbered
  steps with file paths, exact commands, and acceptance checks, so the executor never has to re-derive
  anything, plus what to do when a check contradicts an assumption the steps rest on — by default, stop
  and report the mismatch rather than improvise around it or push on with steps that no longer apply.
  The phase text is the durable core of that sub-agent's brief; the spawn-time brief adds only what is
  situational (current tree state, conventions learned during execution, return format, files another
  agent owns).
- **Fable-executed**: goal, constraints, acceptance criteria, and the decisions that bound the work.
  No step list — Fable fills the steps in as it goes. If Opus later picks up such a phase, it must be
  expanded to the Opus standard first (`/task` handles this).

If you are Opus (or any non-Fable model), every phase is Opus-executed. If you are Fable, use your
judgment on the split. Fable usage is limited, so normal implementation work should go to Opus
sub-agents unless a task is so small that delegating it costs more than doing it. Keep for yourself
what needs frontier judgment — design, creative or scientific thinking, cross-cutting integration —
but once you have worked out the design, Opus can implement it if the phase spells it out and its
acceptance checks would catch an implementation mistake Opus wouldn't notice. The user can override
the split. Precision that matters belongs in the plan, not in a spawn-time brief: the plan is what
gets reviewed in Phase 5 and what survives a crashed session.

**Scale the plan to complexity**:

### For simple tasks:
```markdown
# Plan: [Task Title]

## Goal
[What we're accomplishing]

## Approach
1. [Step]
2. [Step]
3. [Step]

## Documentation
- [ ] [Docs to update; a new doc only if it uniquely owns something — remove section if genuinely none]

## Verification
- [ ] [How to confirm success]
```

Simple plans always meet the Opus standard — files, commands, expected results per step. They are
short, so the precision costs nothing, and it makes the plan safe for any executor.

### For moderate/complex tasks:
```markdown
# Plan: [Task Title]

Created: [Date]
Status: PENDING APPROVAL

## Summary
[2-3 sentences on what will be accomplished]

## Scope
- **In scope**: [What will be done]
- **Out of scope**: [What won't be done]

## Phases

### Phase 1: [Name]
**Executor**: [Fable (orchestrator) | Opus (orchestrator) | Opus sub-agent]
**Goal**: [What this achieves]

**Work**:
- [Item] - [Details: files/components involved; for Fable-executed phases, the constraints and acceptance criteria]
- [Item] - [Details]

**Steps** (Opus-executed phases only):
1. [Concrete step: file, command, expected result]
2. [Step]

**Verification**:
- [ ] [How to verify]

### Phase 2: [Name]
[Same structure]

## Documentation
What existing documentation must be updated and, only when it has a distinct durable role, what new document must be created. For each new artifact, state what it uniquely owns and why an existing artifact cannot own it.
Include documentation as steps in the relevant phase above, or as a dedicated phase if substantial. Remove this section only if the task genuinely has no documentation impact.

## Decisions
Choices made while drafting that a reasonable person could have made differently and that would be
costly to reverse once executed. Write each one down as you make it — do not reconstruct this
section afterwards. Everything below that bar stays a plain statement in the plan.
- **[What was chosen]** — [why]. Rejected: [alternative] ([its appeal, and why it lost]).

## Open Questions
- [Unresolved questions for the user]

---
**Please review. Edit directly if needed, then confirm to proceed.**
```

Add sections as needed: Prerequisites, Risks, Rollback, Testing Strategy, etc. A simple plan that
turns on one material choice should carry a Decisions section too.

## Phase 5: Plan Review

**Run `/doublecheck` on the plan file before presenting it — always, including for simple plans.**
Past instances judged it "not worth it" and shipped flawed plans; the review is cheap next to the
execution it protects. A new plan file is untracked, so the diff `/doublecheck` injects is empty:
pass the plan file's path as the argument, followed by the focus — completeness, correctness,
feasibility, internal consistency, and whether each phase is precise enough for its stated executor.
Fix any issues found.

## Phase 6: User Confirmation

Present the plan in the conversation — do not make the user reconstruct it from the file. A plan
reads as a series of settled statements, which hides the fact that choices were made at all; your
job here is to expose the choices so approval means something. Scale this to complexity: a simple
plan needs the summary plus anything genuinely open, and nothing more.

1. **Summarize the plan in plain language.** Assume a technical reader who knows the project
   broadly but may not recall the details, or was never in them. Say what will change and why —
   not a phase-by-phase recital. Be direct; skip jargon unless a term genuinely carries meaning
   no plain phrasing does. If you are Fable, include the execution split — what you keep and
   what goes to Opus sub-agents — so the user can override it.
2. **Present the decisions** from the plan's Decisions section: what was chosen, why, and what was
   rejected along with its tradeoffs. Present the calls **you** made; skip the ones the user
   already made or settled with you in conversation — don't re-litigate their own choices back
   at them.
3. **Present the open questions.** Give each enough context to be understood cold, the viable
   options with their tradeoffs, and **your recommended default** — so the user can accept the set
   as a whole or override just the ones they care about, rather than adjudicating every fork. Use
   AskUserQuestion for any that genuinely block.
4. Share the doublecheck findings (and any fixes applied)
5. Say where the plan file lives. If the SendUserFile tool is available (Remote Control or web
   sessions), also send it with `display: 'render'`.
6. Ask them to review and edit if needed, and wait for explicit confirmation. Do not begin work
   until confirmed.

## Phase 7: Execute

Execution is tracked with `/task` against the plan file. Once confirmed:
1. Re-read the plan file — the user or the doublecheck may have edited it — and note any changes.
2. Recommend where to execute. If planning left context light, continue in this session: the
   conversation holds rationale the file doesn't, which helps an orchestrator. If exploration
   and writing consumed substantial context, recommend a fresh session. Before recommending it,
   move into the plan any rationale that so far lives only in this conversation. If the plan has
   Fable-executed phases and the fresh session may run on Opus, say so: those phases must be
   expanded to the Opus standard before Opus executes them. The user decides.
3. Invoke `/task` on the plan file here — or, for a fresh session, end with a fenced text block the
   user can paste verbatim as the new session's first message: the `/task` invocation on the plan
   file, plus the orientation files to read first (devlog, README, design notes — whatever helped
   you orient), skipping anything loaded automatically such as CLAUDE.md and the files it pulls in
   (e.g., AGENTS.md).
