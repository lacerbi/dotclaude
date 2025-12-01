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

**You (main agent)** orchestrate and synthesize. Sub-agents only analyze.

---

## Sub-Agent Instructions

When spawning sub-agents, explicitly instruct them to:
- Be **extremely thorough**—consider the problem deeply until fully satisfied with their analysis
- Spend **maximum effort**; do not satisfice or stop at "good enough"
- Unless the problem formulation states otherwise (or it's clear from context): **develop a strong understanding of the task by going beyond what they are told**—explore the project folder, read relevant files in full, gather as much context as necessary before analyzing
- Only conclude when they have genuinely exhausted their reasoning on the problem

---

## Cycle 1: Divergent Analysis

Spawn N Opus sub-agents to analyze **independently**:
- Each works in isolation (no shared context beyond the problem)
- Each produces: **analysis**, **conclusion**, **confidence** (high/medium/low), **key assumptions made**
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
- Agents read the previous cycle's synthesis
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