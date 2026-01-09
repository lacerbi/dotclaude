---
description: Deep analysis using parallel reasoning with iterative refinement
argument-hint: [problem or question, optionally mention number of agents/cycles]
---
## Problem
$ARGUMENTS

## Configuration
Defaults: **10 agents**, **2–3 cycles** (2 if early convergence, 3 if significant disagreement persists). Adjust if the user specifies (e.g., "use 5 agents", "do 4 rounds", "go deeper").

## Your Task

Achieve higher-quality analysis through **parallel independent reasoning with iterative refinement**.

**You (main agent)** orchestrate and synthesize. Sub-agents analyze based on the context you provide.

---

## Phase 0: Context Preparation

**Before spawning any sub-agents, ensure you have sufficient context.**

If you lack understanding of the problem domain, codebase, or relevant materials:
- Explore the project structure
- Read relevant files in full
- Gather whatever context is needed to deeply understand the problem

If you already have sufficient context from the current conversation, proceed directly.

**Critical**: Sub-agents will only know what you tell them. They start cold with no access to your conversation history or accumulated understanding.

---

## Spawning Sub-Agents: Context Requirements

When spawning each sub-agent, you **must** include in the prompt:

1. **Full problem statement** with background and goals
2. **Relevant file contents** (or key excerpts) that inform the analysis
3. **Key findings** you've already established
4. **Specific constraints or requirements** the user has mentioned
5. **The assigned lens** for that agent's perspective

Do NOT assume sub-agents will figure out context from a thin prompt. Give them everything they need to reason well.

---

## Sub-Agent Instructions

When spawning sub-agents, instruct them to:
- Be **extremely thorough**—consider the problem deeply until fully satisfied with their analysis
- Spend **maximum effort**; do not satisfice or stop at "good enough"
- **Start from the provided context**, then explore further to deepen understanding, fill gaps, and verify assumptions
- Only conclude when they have genuinely exhausted their reasoning on the problem
- Produce: **analysis**, **conclusion**, **confidence** (high/medium/low), **key assumptions made**

---

## Cycle 1: Divergent Analysis

Spawn N Opus sub-agents to analyze **independently**:
- Each works in isolation (no shared context beyond what you provide)
- Assign each a distinct lens. Examples:
  - **Skeptic**: Assumes hidden problems, stress-tests assumptions
  - **Advocate**: Builds the strongest case, finds opportunities
  - **First-principles**: Reasons from fundamentals, ignores convention
  - **Pragmatist**: Focuses on real-world constraints and tradeoffs
  - **Edge-case hunter**: Explores boundaries and failure modes
  - **Framing challenger**: Questions whether the problem as stated contains false premises, hidden assumptions, or misconceptions—should we be solving a different problem?
  - **Historian**: Looks for analogies, precedents, what's been tried before
  - **Contrarian**: Argues for the least popular position to ensure it gets heard
  - **Systems thinker**: Examines second-order effects, feedback loops, emergent behavior
  - **Steelman**: Constructs the strongest possible counter-argument to the emerging consensus
  - (Adapt lenses to problem domain as appropriate)

### Verification Pass
Before synthesizing, review each agent's output for:
- Logical errors or invalid inferences
- Unsupported claims or circular reasoning
- Internal contradictions
- Unstated assumptions that may not hold

Flag or discount flawed reasoning. Note which analyses survive verification intact.

### Synthesis
Collect analyses, then synthesize and write to `ANALYSIS_[descriptor]_cycle1.md`:
- **Agreement**: High-confidence conclusions (multiple verified agents concur)
- **Disagreement**: Conflicting views and which reasoning wins
- **Unique insights**: Things only one agent caught (validate or discard)
- **Open questions**: What remains uncertain
- **Confidence map**: Overall confidence per conclusion

---

## Cycle 2+: Convergent Refinement

Spawn a new round of N Opus sub-agents:
- **Pass the previous cycle's synthesis as context** along with the original problem context
- Agents critique it, identify weaknesses, propose improvements
- Focus on: unresolved disagreements, weak reasoning, missing perspectives

### Verification Pass
Same as Cycle 1—review each agent's critique for logical validity before incorporation.

### Synthesis
If continuing to another cycle, synthesize and write to `ANALYSIS_[descriptor]_cycle[N].md`:
- Updated conclusions with refined confidence levels
- How disagreements were resolved (or why they remain open)
- What changed from previous cycle and why

Each cycle tightens the analysis.

### Cycle Continuation Check
After Cycle 2, assess:
- **If convergence**: Key conclusions stable, disagreements resolved or clearly irresolvable without user input → proceed to Final Output
- **If significant unresolved disagreement**: Agents still genuinely conflicting on substance (not matters requiring user decision, but actual analytical uncertainty) → run Cycle 3

If this is the last cycle, move to Final Output.

---

## Final Output

Write `ANALYSIS_[descriptor]_final.md` containing:
- Synthesized answer with confidence levels
- Key disagreements and how they were resolved
- Assumptions & limitations: What this analysis depends on
- Recommendations for further investigation (if any), or decisions requiring user input

**Length**: The final output can be as long as needed for the task. Do not pad or add fluff, but if the task is genuinely complex, use all the space required to address it thoroughly.

Provide a brief summary in chat pointing to the final file.

---

**Use Opus only**—the value comes from parallel high-quality reasoning.