# The Harness Context Framework

## Core Principle

Context Engineering distinguishes between two roles of the context window:

| Traditional View | tools2skill View |
|-----------------|-----------------|
| Notepad (store what happened) | Classroom (structure what is learned) |
| Accumulates arbitrarily | Grows according to schema |
| Passive | Active — each section has a write protocol |
| Forgotten at session end | Distilled into skill artifact |

---

## The Living Context Document

Every session maintains one **Living Context Document (LCD)**. It is initialized at session start and updated at the end of each phase.

### LCD Schema

```
═══════════════════════════════════════════
TOOLS2SKILL SESSION — <TOOL_NAME>
Started: <ISO datetime>
Phase: <current phase>
═══════════════════════════════════════════

[IDENTITY]
- Tool: <name>
- Version: <detected or unknown>
- Type: <CLI | Python lib | REST API | SDK | Config | Other>
- Docs URL: <primary documentation URL>

[CONCEPT MAP]
Purpose: <1-sentence purpose statement>
Primary Abstractions:
  - <abstraction>: <what it represents>
  - ...
Core Operations:
  - <operation>: <what it does>
  - ...
Dependencies:
  - Required: <...>
  - Optional: <...>

[CANONICAL PATTERNS]
<!-- Populated in Phase 2. Format: -->
Pattern: <name>
  Code: <working snippet>
  When to use: <condition>
  Validated: YES/NO
  Notes: <any surprises>

[GOTCHAS & EDGE CASES]
<!-- Populated in Phase 2. Format: -->
Gotcha: <name>
  Symptom: <what you see when you hit this>
  Root cause: <why it happens>
  Fix: <what to do>
  Severity: LOW | MEDIUM | HIGH | CRITICAL

[OPEN QUESTIONS]
<!-- Populated in Phase 2 failures and Phase 3 gaps. -->
Q: <question>
  Status: UNRESOLVED | RESOLVED
  Resolution: <answer if resolved>

[QA BANK]
<!-- Populated in Phase 3. Format: -->
Q: <question>
  A: <answer>
  Category: Factual | Procedural | Diagnostic | Comparative | Creative
  Confidence: Confident | Uncertain | Missing
  Source: <which section of LCD answered this>

[COMPRESSION NOTES]
<!-- Populated during Phase 4 planning. -->
Keep: <what must survive in the skill>
Drop: <what is doc-retrievable and can be omitted>
Prioritize: <what is most non-obvious>
```

---

## Write Protocols

Each phase follows a strict **write protocol** — it only writes to designated sections:

| Phase | May Write To | May Read From |
|-------|-------------|---------------|
| Phase 1 (Recon) | IDENTITY, CONCEPT MAP | — |
| Phase 2 (Curriculum) | CANONICAL PATTERNS, GOTCHAS, OPEN QUESTIONS | CONCEPT MAP |
| Phase 3 (QA) | QA BANK, OPEN QUESTIONS | All sections |
| Phase 4 (Synthesis) | COMPRESSION NOTES → output skill | All sections |

This prevents earlier phases from being contaminated by later speculation.

---

## Context Budgeting

The LCD is designed to stay within a manageable context budget:

| Section | Target Size |
|---------|-------------|
| IDENTITY | ~100 tokens |
| CONCEPT MAP | ~300 tokens |
| CANONICAL PATTERNS | ~600 tokens (10 patterns × 60 tokens) |
| GOTCHAS | ~300 tokens |
| OPEN QUESTIONS | ~150 tokens |
| QA BANK | ~600 tokens (25 QA × 24 tokens) |
| COMPRESSION NOTES | ~100 tokens |
| **Total** | **~2150 tokens** |

The output skill targets ≤800 tokens (distillation ratio ~2.7:1).

---

## Why This Design

### Schemas prevent drift
Without a schema, agents tend to write verbose prose and lose structure over long sessions. The LCD schema forces each piece of knowledge into a typed slot.

### Write protocols prevent contamination
If Phase 4 synthesis logic could overwrite Phase 2 raw observations, we'd lose the authentic failure record. Write isolation preserves the audit trail.

### Budget constraints force compression thinking
By targeting 800-token skills, the agent must decide what is *essential* vs. *derivable*. This mirrors how expert humans write good documentation.
