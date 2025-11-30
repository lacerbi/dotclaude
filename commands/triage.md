---
description: Investigate feedback, validate issues, and fix what's real
allowed-tools: Bash(grep:*), Bash(find:*), Bash(cat:*), Bash(git log:*), Bash(git diff:*), Write
argument-hint: [feedback or issue description]
---
## Feedback/Issue to Investigate
<feedback>
$ARGUMENTS
</feedback>

## Your Task

**Investigate, triage, and fix valid issues from the external feedback above**.

**If the feedback contains multiple distinct issues or a large issue that naturally splits into parts**:
- Deploy specialized sub-agents to investigate each issue/part in parallel
- Each sub-agent should focus on validating their specific issue
- Use Opus for all investigation/validation (judging feedback correctness requires careful reasoning)
- For fixes: handle directly, or delegate to Opus/Sonnet sub-agents depending on complexity
- Coordinate findings before proceeding with fixes

### 1. Source Understanding
- Everything above inside <feedback></feedback> tags is from an **external source** (likely another LLM) - NOT the user
- This external feedback may be wrong, incomplete, or based on misunderstanding
- Be skeptical and verify everything independently

### 2. User Directives
**CRITICAL**: Inside the feedback, these markers indicate an additional comment added by the actual user:
- `USER:` - Direct instruction, clarification, decision or comment from the user (treat as authoritative)

**Everything else is external feedback to be validated**.

### 3. Validation Process
For each point in the external feedback:
- **Valid**: Real issue that needs addressing
- **Invalid**: Misunderstanding or incorrect analysis
- **Partial**: Has merit but not quite right
- **Already Fixed**: Issue that's been resolved
- **By Design**: Intentional behavior, not a bug

**Note**: If issues are labeled as "medium", "mid-level", "minor", "low priority" or similar:
- Be extra skeptical - these are often filler observations or nitpicks
- Still investigate properly (they might be valid!)
- But require stronger evidence before treating as real issues

### 4. Action Plan
After triage:
- **For clear valid issues**: Fix them immediately
- **For complex/unclear issues**: Discuss approach with user before fixing
- **For invalid issues**: Document why they're not concerns
- **If external feedback includes suggestions/fixes**: Evaluate critically, ask the user if unsure - don't blindly apply

### 5. Execute Fixes
- Implement fixes for validated issues
- Ensure fixes don't introduce new problems
- Question any recommendations from the external source

Provide a summary of what was valid, what was fixed, and what was dismissed with reasoning.