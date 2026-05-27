# Curriculum Design Theory

## Why "Curriculum" and Not "Prompt"

A prompt tells an agent *what to do once*.
A curriculum tells an agent *what to do in what order, and why*.

The difference matters because tool mastery is **sequential and cumulative**:
- You cannot identify gotchas before you understand the happy path
- You cannot generate meaningful QA before you have patterns to test
- You cannot compress before you know what's worth keeping

Curriculum enforces this ordering as a constraint, not a suggestion.

---

## Learning Theory Foundations

tools2skill draws on three pedagogical principles:

### 1. Scaffolded Inquiry (Vygotsky)
Start from what the agent already knows (training data), extend into the zone of proximal development (what docs + examples can teach), then push into genuine novelty (execution failures, edge cases).

```
Known (training data)
    ↓ scaffold
Learnable (docs + examples)
    ↓ scaffold
Novel (execution + failure)
    ↓ scaffold
Mastered (annotated patterns + QA bank)
```

### 2. Deliberate Practice (Ericsson)
Random tool use does not produce expertise. Deliberate practice targets:
- Specific use cases (not random exploration)
- Failure points (not just successes)
- Feedback loops (not just execution)

Phase 2 implements deliberate practice: the agent picks canonical cases, executes, observes failure specifically, and annotates.

### 3. Retrieval Practice (Roediger)
Testing knowledge (Phase 3 QA) is more effective than re-reading docs.
The QA bank forces the agent to retrieve from its own LCD — not from raw docs — which identifies genuine gaps vs. apparent understanding.

---

## Curriculum Sequencing

### The Simple-to-Complex Axis

Within Phase 2, use cases are ordered:

```
Level 1: Hello World (bare minimum invocation)
Level 2: Core use case (primary intended workflow)
Level 3: Parameterized (common option combinations)
Level 4: Integration (combining with other tools)
Level 5: Edge case (boundary conditions, error handling)
```

Do not proceed to Level N+1 until Level N passes.

### The Failure Taxonomy

When Phase 2 execution fails, classify before retrying:

| Failure Type | Likely Cause | Action |
|-------------|-------------|--------|
| `UserError` | Wrong invocation | Fix and retry |
| `EnvError` | Missing dependency / wrong version | Note in GOTCHAS, fix env, retry |
| `DocError` | Documentation was wrong | Note in GOTCHAS, find correct usage |
| `EdgeCase` | Valid input, unexpected behavior | Note in GOTCHAS, do not retry |
| `Blocker` | Cannot resolve in ≤2 retries | Add to OPEN QUESTIONS, skip |

Retry budget: **2 retries per use case**. After 2 failures, classify as Blocker.

---

## QA Category Design

The 5 QA categories test different depth levels:

| Category | Tests | Example |
|----------|-------|---------|
| Factual | Recall of API surface | "What flag enables verbose output?" |
| Procedural | Synthesis of patterns | "How do I do X given constraints Y?" |
| Diagnostic | Gotcha coverage | "Why would I get error Z?" |
| Comparative | Depth of understanding | "What's the difference between A and B mode?" |
| Creative | Transfer ability | "How would I combine this with tool W?" |

Target distribution: 5 Factual + 6 Procedural + 6 Diagnostic + 4 Comparative + 4 Creative = 25 total.

---

## Tool-Type Curriculum Variants

### CLI Tool Variant
Phase 2 sandbox: Bash execution with captured stdout/stderr.
Level 1: `tool --help` → parse output
Level 2: `tool <basic-command>`
Level 3: `tool <command> --option1 --option2`
Level 4: pipe integration (`tool ... | other-tool`)
Level 5: error conditions (`tool --bad-flag`, missing required args)

### Python Library Variant
Phase 2 sandbox: Python REPL or script execution.
Level 1: `import tool; tool.__version__`
Level 2: Primary class instantiation + basic method
Level 3: Full workflow (init → process → output)
Level 4: Exception handling
Level 5: Edge inputs (empty, None, malformed)

### REST API Variant
Phase 2 sandbox: curl or requests.
Level 1: GET on public endpoint
Level 2: Authenticated request
Level 3: POST with body
Level 4: Pagination / streaming
Level 5: Rate limit handling, error codes

---

## Anti-Patterns to Avoid

| Anti-Pattern | Why Bad | Alternative |
|-------------|---------|-------------|
| Reading docs linearly | No prioritization | Identify top 5 use cases first |
| Running examples from docs verbatim | No validation | Paraphrase and reconstruct |
| Skipping failures | Misses critical gotchas | Always classify and annotate failures |
| Over-retrying | Wastes budget on blockers | 2-retry cap, then document |
| Writing QA before execution | QA tests hypotheses, not knowledge | Always Phase 2 before Phase 3 |
| Including raw doc text in skill | Skill bloat | Compression notes force filtering |
