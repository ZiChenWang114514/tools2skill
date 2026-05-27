# Conversation Log — tools2skill Genesis

**Date:** 2026-05-26
**Participants:** 王子宸 (PKU AAIS CLS PhD), Claude Code (Sonnet 4.6)

---

## Session Summary

This document records the founding conversation in which the `tools2skill` methodology was conceived and the project structure was designed.

---

## 1. Initial Concept Proposal

**User (王子宸):**

> 我现在想要设计一个tools2skill的有关context engineering的方法论，也就是说给你（coding agent）一个完全新的陌生的tool，请你深度学习，通过deep research，case study，学习试错，simple QA等等等等各种方式，从360°深度学习这个方法论，以一个harness的规范的context框架下，为我展开可控连续而有探索性有经验性的深度的学习，然后将这个tool包装为一整个从头到尾的skill或多个skills，请问我的想法可行吗，以最前沿的ai算法研究，这样是否是一个新颖而又创造性的方向？

**Translation of core idea:**
Design a methodology called "tools2skill" for context engineering: given a coding agent a completely new, unfamiliar tool, have it deeply learn through deep research, case studies, trial-and-error, QA, etc., operating within a standardized harness context framework in a controllable, continuous, exploratory, and experiential manner, then package this knowledge into one or more complete skills.

---

## 2. Feasibility & Novelty Assessment

**Claude's Assessment:**

**Feasible: Yes.** All components have technical support:
- Deep research → WebFetch / context7 / WebSearch
- Case study → GitHub search for real usage
- Trial & error → Bash/Python sandbox execution
- QA → Self-generated + self-evaluated
- Skill packaging → Claude Code skill system

**Novelty: Moderate to High.** Comparison with existing work:

| Existing Work | What It Does | What tools2skill Adds |
|--------------|-------------|----------------------|
| ToolFormer (2023) | Trains LLMs to use APIs via self-supervised learning | No gradient training needed; inference-time only |
| Voyager (2023) | Minecraft agent builds skill library | Domain-general, any tool type |
| ToolBench/ToolLLM | Static datasets for tool-use fine-tuning | Real-time autonomous learning |
| ReAct / Reflexion | Reasoning + acting patterns | Produces durable skill artifact, not just task completion |

**The genuine novelty:** Treating the context window as *pedagogy* (a structured classroom) rather than *memory* (a notepad), combined with packaging the result into a portable skill artifact.

**Key insight:** "Context is not just memory — it is pedagogy."

**Potentially publishable angles:**
1. Context Engineering as a learning framework
2. Autonomous tool mastery without fine-tuning
3. Skill compression and transfer between related tools

---

## 3. Architecture Discussion

The conversation established the core architecture:

```
Unknown Tool
    ↓
[ Phase 1: Reconnaissance ]     ← Fetch docs, find examples, build concept map
    ↓
[ Phase 2: Curriculum Execution ] ← Structured trial, failure classification, annotation
    ↓
[ Phase 3: QA Validation ]      ← Self-generated Q&A, gap analysis, re-learning
    ↓
[ Phase 4: Skill Synthesis ]    ← Compression, packaging, template filling
    ↓
Reusable Skill Artifact (.md)
```

Central innovation: the **Living Context Document (LCD)** — a schema-governed working memory that accumulates knowledge in typed sections throughout the session, then gets distilled into the final skill.

---

## 4. Key Design Decisions Made in This Conversation

| Decision | Rationale |
|----------|-----------|
| 4-phase curriculum (not 3 or 5) | Reconnaissance / Execution / Validation / Synthesis maps cleanly to: know / do / test / teach |
| Write protocols per phase | Prevents contamination of raw observations by later synthesis logic |
| 2-retry cap on failures | Prevents rabbit holes; forces explicit classification |
| 90% QA confidence threshold | Allows ≤2-3 uncertain answers in 25-question bank |
| ≤800 token skill target | Skills are loaded in every triggered conversation; context budget matters |
| 5 QA categories (Factual/Procedural/Diagnostic/Comparative/Creative) | Covers recall, synthesis, failure modes, depth, and transfer |

---

## 5. Project Creation Decision

User requested: create a GitHub repo and project folder under `/data2/zcwang/tools2skill/`.

**Repo:** `ZiChenWang114514/tools2skill` (public)
**Local path:** `/data2/zcwang/tools2skill/`

---

## 6. Open Questions for Future Work

1. What is the optimal curriculum ordering for different tool types?
2. How do we measure mastery objectively without external ground truth?
3. How long does a generated skill remain accurate as tools evolve?
4. Can a skill for Tool A bootstrap learning of similar Tool B?
5. What tool types resist this methodology (e.g., highly stateful, GUI-based)?
6. Can we publish this as a methodology paper? What venue?

---

*Log maintained by Claude Code. Last updated: 2026-05-26.*
