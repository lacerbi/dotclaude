---
name: plan
disable-model-invocation: true
description: Create a detailed plan with exploration before execution
argument-hint: <task description>
---
You are entering PLANNING MODE. Explore and analyze before doing any work.

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

**Subagent selection**: Opus for tasks requiring judgment. Sonnet for straightforward subtasks. Haiku only for trivial read-only tasks.

Instruct Explore agents to:
- Return hypotheses, not conclusions
- Provide full file paths for relevant files
- Identify locations, not deep analysis
- Be thorough but efficient - scouts, not implementers

## Phase 3: Synthesis

After exploration:
1. Read/verify key files and materials identified
2. Confirm or refute hypotheses
3. Build a mental model of the current state and what the task requires
4. Identify existing documentation that must be updated, and whether any new document has a distinct durable purpose

Before proposing a new document:
- Identify the durable audience or question it will serve and the information it will uniquely own.
- Check project conventions and existing authoritative docs, plans, source comments, tests, TODOs,
  and issues first.
- Prefer updating an existing authoritative artifact when it can serve the same purpose.
- Do not create a new artifact merely to restate the plan or record work performed.

## Phase 4: Plan Creation

Create a plan file named `PLAN-<task-slug>.md` (e.g., `PLAN-add-user-auth.md`) in the project root, unless the user or project instructions (CLAUDE.md, AGENTS.md) specify a different location. The task slug should be lowercase, hyphen-separated, and concise (3-5 words max).

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
**Goal**: [What this achieves]

**Work**:
- [Item] - [Details]
- [Item] - [Details]

**Steps**:
1. [Step]
2. [Step]

**Verification**:
- [ ] [How to verify]

### Phase 2: [Name]
[Same structure]

## Documentation
What existing documentation must be updated and, only when it has a distinct durable role, what new document must be created. For each new artifact, state what it uniquely owns and why an existing artifact cannot own it.
Include documentation as steps in the relevant phase above, or as a dedicated phase if substantial. Remove this section only if the task genuinely has no documentation impact.

## Open Questions
- [Unresolved questions for the user]

---
**Please review. Edit directly if needed, then confirm to proceed.**
```

Add sections as needed: Prerequisites, Risks, Rollback, Testing Strategy, etc.

## Phase 5: Plan Review

You MUST run `/doublecheck` against the plan file to verify completeness, correctness, feasibility, and internal consistency before presenting it to the user. Fix any issues found.

Do not skip this step. Do not decide it's "not worth it" because the plan looks complete or the task seems simple — past instances have skipped it and shipped flawed plans. This step is non-negotiable.

## Phase 6: User Confirmation

1. Send the plan file to the user with SendUserFile (`display: 'render'` for inline rendering)
2. Tell the user where the plan file is
3. Share the doublecheck findings (and any fixes applied)
4. Ask them to review and edit if needed
5. Wait for explicit confirmation
6. Do NOT begin work until confirmed

## Phase 7: Execute

Once confirmed:
1. Re-read the plan file (user or double-check may have edited it)
2. Note any changes
3. Proceed following the plan

## Rules

- Don't skip exploration
- Don't start work during planning
- Always run `/doublecheck` in Phase 5 — never skip it, no exceptions
- After doublecheck, always send the plan file via SendUserFile (inline render)
- Verify, don't assume
- If unclear, ask the user (AskUserQuestion)
- Get user confirmation before executing
- Re-read the plan after confirmation
- The plan should be clear enough for someone else to follow
