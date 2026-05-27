# tools2skill — System Specification v0.1

> **Version:** 0.1 (initial design)
> **Date:** 2026-05-26
> **Status:** Draft

---

## 1. Problem Statement

When a coding agent encounters a new, unfamiliar tool (CLI, library, API, framework), its current options are:
- **Hope**: rely on training data (stale, incomplete, hallucination-prone)
- **RAG retrieval**: fetch docs verbatim (no synthesis, no validation)
- **One-shot prompting**: try once, fail silently

None of these produce **durable, validated, reusable knowledge**.

`tools2skill` introduces a **third path**: autonomous, structured tool mastery that ends in a portable skill artifact.

---

## 2. Definitions

| Term | Definition |
|------|------------|
| **Tool** | Any software artifact the agent can invoke: CLI binary, Python library, REST API, SDK, config system |
| **Skill** | A Claude Code skill file (`.md` with frontmatter) that gives an agent expert-level operational knowledge of the tool |
| **Session** | One complete tools2skill run for one tool |
| **Harness** | The structured context framework that governs a session |
| **Mastery** | The condition where the agent can correctly answer ≥90% of self-generated QA pairs without referring to raw docs |

---

## 3. Architecture

### 3.1 The Harness Context Schema

The harness maintains a **living context document** throughout the session. It has fixed sections that accumulate knowledge:

```markdown
## [TOOL]: <tool_name>
## [VERSION]: <detected version>
## [DOMAIN]: <category: CLI / Python lib / REST API / ...>

### CONCEPT MAP
<!-- High-level mental model built in Phase 1 -->

### CANONICAL PATTERNS
<!-- Validated usage patterns from Phase 2 -->

### GOTCHAS & EDGE CASES
<!-- Failures encountered and annotated in Phase 2 -->

### OPEN QUESTIONS
<!-- Gaps identified in Phase 3, re-enter Phase 2 if non-trivial -->

### QA BANK
<!-- Self-generated Q&A pairs with correctness assessment -->

### COMPRESSION NOTES
<!-- What to keep / drop in final skill synthesis -->
```

This document is **the working memory** of the session. All phases read from and write to it.

### 3.2 Phase Design

#### Phase 1 — Reconnaissance (Mapping the Unknown)

**Goal:** Build a concept map without touching the tool.

**Steps:**
1. Fetch official documentation (context7 → WebFetch fallback)
2. Search GitHub for real-world usage (≥5 distinct repositories)
3. Identify: primary use cases, core abstractions, CLI flags / API surface
4. Detect: version, dependencies, known gotchas in issues/discussions
5. Write CONCEPT MAP into harness context

**Outputs:** Populated CONCEPT MAP section, a ranked list of 5-10 canonical use cases

**Exit criterion:** Agent can describe the tool's purpose and top 3 use cases without docs

---

#### Phase 2 — Curriculum Execution (Structured Trial)

**Goal:** Validate the concept map through controlled execution.

**Curriculum design principle:** Go from simple to complex, from happy path to edge cases.

**Per use-case loop:**
```
FOR each use_case IN canonical_use_cases:
    1. Formulate minimal working example
    2. Execute in sandbox
    3. Observe output / error
    4. IF success:
        - Extract pattern → add to CANONICAL PATTERNS
        - Note any surprising behavior → GOTCHAS
    5. IF failure:
        - Classify failure type (user error / env issue / doc error / edge case)
        - Self-correct → retry ≤2 times
        - If still failing: annotate as OPEN QUESTION
    6. Annotate what would trip up a future agent
```

**Outputs:** Populated CANONICAL PATTERNS, GOTCHAS, initial OPEN QUESTIONS

**Exit criterion:** ≥80% of canonical use cases executed successfully

---

#### Phase 3 — QA Validation (Gap Analysis)

**Goal:** Stress-test understanding, surface hidden gaps.

**QA generation strategy:**
- Generate 25-30 Q&A pairs across 5 categories:
  1. **Factual** (what flag does X?) — tests recall
  2. **Procedural** (how do I do Y?) — tests patterns
  3. **Diagnostic** (why does Z fail?) — tests gotcha coverage
  4. **Comparative** (what's the difference between A and B?) — tests depth
  5. **Creative** (how would you combine tool with W?) — tests transfer

**Self-evaluation:**
- Answer each question from harness context alone (no raw docs)
- Mark: Confident / Uncertain / Missing
- All Uncertain/Missing → add to OPEN QUESTIONS → re-enter Phase 2

**Exit criterion:** ≥90% of QA pairs answered Confident; no Critical gaps remain

---

#### Phase 4 — Skill Synthesis, Packaging & Registration

**Goal:** Distill harness context into a minimal, portable, hot-pluggable skill artifact.

Phase 4 has three sub-steps:

##### 4a — Synthesis (Compression)

**Compression principles:**
1. **Exclude** raw doc content (retrievable on demand)
2. **Include** patterns that are non-obvious from docs alone
3. **Prioritize** gotchas, edge cases, and sequencing requirements
4. **Format** for agent consumption, not human reading
5. **Pass portability check** before proceeding to 4b (see `methodology/portability_rules.md`)

Output: `skills/<tool_name>.md`

##### 4b — Packaging (Manifest Creation)

Create `skills/<tool_name>.manifest.json` using `templates/manifest_template.json`.
Fill in all fields: version, tool_version_tested, mastery_metrics M1-M5, triggers, tags.

Run portability validation:
```bash
./t2s validate <tool_name>
```
Fix any violations before proceeding.

##### 4c — Registration & Hot-Plug

Install into Claude Code:
```bash
./t2s install <tool_name>
```

This copies the skill to `~/.claude/skills/<tool_name>.md`, making it
**immediately available in all new Claude Code sessions** without any restart.

The registry (`registry.json`) is updated automatically.

**Exit criterion:** `t2s list --installed` shows the skill as INSTALLED.

---

#### Export (Optional, post-Phase 4)

To make the skill portable and shareable:
```bash
./t2s export <tool_name>          # creates <tool_name>.t2s bundle
./t2s export <tool_name> --out /tmp  # specify output dir
```

Recipients install with:
```bash
./t2s import <tool_name>.t2s
./t2s install <tool_name>
```

---

## 4. Mastery Metrics

| Metric | Threshold | How to Measure |
|--------|-----------|----------------|
| Use-case coverage | ≥80% executed | Count of successful Phase 2 runs |
| QA confidence | ≥90% Confident | Self-evaluation in Phase 3 |
| Gotcha density | ≥3 non-trivial | Phase 2 annotations |
| Skill completeness | All sections populated | Template checklist |
| Skill size | ≤800 tokens | Token count of output |

---

## 5. Tool Type Adaptation

The curriculum adapts based on tool type:

| Tool Type | Phase 1 Focus | Phase 2 Execution | Special Considerations |
|-----------|---------------|-------------------|----------------------|
| CLI binary | man page + --help | Bash sandbox | Flag combinations, exit codes |
| Python library | API reference + source | Python REPL | Import patterns, exceptions |
| REST API | OpenAPI spec | curl / requests | Auth, rate limits, pagination |
| Config system | Schema + examples | Config file writing | Validation, env vars, precedence |
| SDK/Framework | Architecture guide | Project scaffold | Lifecycle, hooks, middleware |

---

## 6. Hot-Plug & Export Architecture

### 6.1 The Hot-Plug Path

Claude Code loads skills from `~/.claude/skills/` at the start of each session.
This makes the install/uninstall cycle naturally hot-pluggable:

```
skills/<name>.md    ──t2s install──▶   ~/.claude/skills/<name>.md
                                              │
                                              ▼
                                    Available in next Claude Code session
                                    (no restart of the harness required)

~/.claude/skills/<name>.md  ──t2s uninstall──▶   (deleted)
                                              │
                                              ▼
                                    Removed from next Claude Code session
```

### 6.2 The Export Bundle Format

A `.t2s` file is a ZIP archive containing:

```
<tool_name>.t2s  (ZIP)
├── skill.md          ← clean skill for Claude Code consumption
├── manifest.json     ← machine-readable metadata
├── bundle_meta.json  ← bundle creation timestamp + schema version
└── session_log.md    ← (optional) learning session that produced this skill
```

The bundle is **self-contained**: no external references required to install and use.

### 6.3 Registry

`registry.json` tracks the state of all generated skills:

```json
{
  "schema_version": "1.0",
  "skills": {
    "<tool_name>": {
      "version": "1.0.0",
      "installed": true,
      "install_path": "/home/<user>/.claude/skills/<tool_name>.md",
      "source_path": "skills/<tool_name>.md",
      "installed_at": "<ISO datetime>",
      "mastery_status": "MASTERED",
      "tool_version_tested": "<version>"
    }
  }
}
```

### 6.4 t2s CLI Reference

```
t2s install <name>           Hot-plug into Claude Code (with portability check)
t2s install <name> --force   Skip portability check
t2s uninstall <name>         Remove from Claude Code
t2s list                     Show all skills (available + installed)
t2s list --installed         Show only installed skills
t2s export <name>            Create portable .t2s bundle
t2s export <name> --out DIR  Export to specific directory
t2s import <path>            Install from local .t2s bundle
t2s import <url>             Download + install from URL
t2s validate <name>          Check for portability violations
t2s status                   Full registry dump
t2s new-manifest <name>      Create manifest for existing skill file
```

### 6.5 Portability Guarantees

Before any skill can be exported, it must pass portability validation (`t2s validate`).
See `methodology/portability_rules.md` for the full ruleset. Key constraints:
- No absolute paths
- No hardcoded usernames or machine-specific paths
- No secrets or API keys
- Version requirements as ranges, not exact pins

---

## 7. Meta-Skill Design

The orchestrating skill (`tools2skill.md`) will:
- Accept: `tool_name`, `tool_type`, optional `docs_url`
- Initialize harness context document
- Drive the 4-phase curriculum
- Output: a skill file in `skills/<tool_name>.md`

**Invocation:**
```
/tools2skill <tool_name>
```

---

## 8. Research Questions

1. **Curriculum ordering**: Is the reconnaissance-first order optimal for all tool types?
2. **Mastery threshold**: Is 90% QA confidence a reliable mastery proxy?
3. **Skill decay**: How long does a generated skill remain accurate as tools evolve?
4. **Transfer learning**: Can a skill for Tool A bootstrap mastery of similar Tool B?
5. **Failure modes**: What tool types resist this methodology (e.g., highly stateful systems)?

---

## 9. Roadmap

| Milestone | Description |
|-----------|-------------|
| v0.1 | Spec + templates (current) |
| v0.2 | First pilot session (chosen tool TBD) |
| v0.3 | Meta-skill `tools2skill.md` implemented |
| v0.4 | 5 pilot skills generated and validated |
| v1.0 | Published methodology paper |
