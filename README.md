# tools2skill

**Context-Engineering Driven Tool Mastery → Skill Packaging**

A methodology and harness for autonomously learning an unfamiliar tool through structured multi-modal curriculum, then packaging the acquired knowledge into reusable Claude Code skills.

## Core Idea

```
Unknown Tool
    ↓
[ Structured Learning Harness ]
    ├── Phase 1: Reconnaissance (docs + examples)
    ├── Phase 2: Curriculum Execution (trial + error + annotation)
    ├── Phase 3: QA Validation (gap analysis + re-learning)
    └── Phase 4: Skill Synthesis (compression + packaging)
    ↓
Reusable Skill Artifact
```

## Philosophy

> Context is not just memory — it is *pedagogy*.

Most tool-learning approaches treat the context window as a notepad.
`tools2skill` treats it as a **structured classroom**: every piece of information is placed intentionally, every interaction is a lesson, every failure is annotated and folded back.

## Project Structure

```
tools2skill/
├── SPEC.md                  # Full system specification
├── methodology/             # Core framework design docs
│   ├── context_framework.md # The harness context schema
│   ├── curriculum_design.md # Phase-by-phase curriculum theory
│   └── mastery_metrics.md   # How we measure "learned enough"
├── templates/               # Reusable templates per phase
│   ├── session_template.md
│   ├── qa_template.md
│   └── skill_output_template.md
├── sessions/                # Per-tool learning session logs
│   └── YYYY-MM-DD_<toolname>/
│       ├── phase1_recon.md
│       ├── phase2_learning.md
│       ├── phase3_qa.md
│       └── phase4_skill.md
├── skills/                  # Output: generated skill files
└── docs/                    # Conversation logs and design notes
    └── conversation_log.md
```

## Status

- [x] Initial spec design (2026-05-26)
- [ ] Phase templates finalized
- [ ] First pilot: test on a real unfamiliar tool
- [ ] Meta-skill (`tools2skill.md`) published to Claude Code

## Origin

Conceived 2026-05-26 in a conversation about context engineering methodology for AI coding agents.
See `docs/conversation_log.md` for the original design discussion.
