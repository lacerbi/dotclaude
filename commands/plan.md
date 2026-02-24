---
description: Create a detailed plan with exploration before execution
argument-hint: <task description>
allowed-tools: Skill(doublecheck)
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

**For moderate/complex tasks**: Spawn Explore agents in parallel (Task tool, subagent_type='Explore'), each focused on a relevant aspect:

- **Structure Explorer**: Project organization, key components, how things connect
- **Prior Work Explorer**: Existing similar work, patterns, or approaches to build on
- **Context Explorer**: Related materials, dependencies, constraints
- **Domain Explorer**: Subject matter, conventions, standards relevant to the task

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

## Phase 4: Plan Creation

Create a plan file in the user-specified plans folder, or project root if not specified.

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

## Open Questions
- [Unresolved questions for the user]

---
**Please review. Edit directly if needed, then confirm to proceed.**
```

Add sections as needed: Prerequisites, Risks, Rollback, Testing Strategy, etc.

## Phase 5: Plan Review

Run `/doublecheck` against the plan file to verify completeness, correctness, feasibility, and internal consistency before presenting it to the user. Fix any issues found.

## Phase 6: User Confirmation

1. Tell the user where the plan file is
2. Share the doublecheck findings (and any fixes applied)
3. Ask them to review and edit if needed
4. Wait for explicit confirmation
5. Do NOT begin work until confirmed

## Phase 7: Execute

Once confirmed:
1. Re-read the plan file (user or double-check may have edited it)
2. Note any changes
3. Proceed following the plan

## Rules

- Don't skip exploration
- Don't start work during planning
- Verify, don't assume
- If unclear, ask the user (AskUserQuestion)
- Get user confirmation before executing
- Re-read the plan after confirmation
- The plan should be clear enough for someone else to follow
