# QA Generation Template for Phase 3

## Instructions

Generate exactly 25 Q&A pairs covering all 5 categories.
Answer each from the LCD alone — do NOT consult raw docs.
Mark confidence honestly: Confident requires a citable LCD source.

## Category Distribution

| Category | Count | Purpose |
|----------|-------|---------|
| Factual | 5 | API surface recall |
| Procedural | 6 | Pattern synthesis |
| Diagnostic | 6 | Gotcha coverage |
| Comparative | 4 | Conceptual depth |
| Creative | 4 | Transfer ability |

---

## Factual Questions (5)
*Template: "What is/does/returns X?"*

F1. Q: What is the primary command/entry point for <tool>?
    A: 
    Confidence: | Source:

F2. Q: What flag/parameter controls <most-important-option>?
    A: 
    Confidence: | Source:

F3. Q: What does <tool> output by default?
    A: 
    Confidence: | Source:

F4. Q: What is the required argument for <core-operation>?
    A: 
    Confidence: | Source:

F5. Q: What version of <tool> was tested in this session?
    A: 
    Confidence: | Source:

---

## Procedural Questions (6)
*Template: "How do I accomplish X given constraints Y?"*

P1. Q: How do I perform the most basic/common use case?
    A: 
    Confidence: | Source:

P2. Q: How do I handle <common-option-combination>?
    A: 
    Confidence: | Source:

P3. Q: How do I integrate <tool> with <common-adjacent-tool>?
    A: 
    Confidence: | Source:

P4. Q: How do I configure <tool> for production vs. development?
    A: 
    Confidence: | Source:

P5. Q: How do I pass <complex-input-type> to <tool>?
    A: 
    Confidence: | Source:

P6. Q: How do I get <tool> output into a format suitable for <downstream-use>?
    A: 
    Confidence: | Source:

---

## Diagnostic Questions (6)
*Template: "Why does X happen / fail?"*

D1. Q: Why might <tool> silently produce wrong output?
    A: 
    Confidence: | Source:

D2. Q: What causes the most common error message?
    A: 
    Confidence: | Source:

D3. Q: When does <tool> require a specific environment or permission?
    A: 
    Confidence: | Source:

D4. Q: What happens if you skip <initialization-step>?
    A: 
    Confidence: | Source:

D5. Q: Why does <tool> behave differently on <edge-input>?
    A: 
    Confidence: | Source:

D6. Q: What is the most surprising/counterintuitive behavior of <tool>?
    A: 
    Confidence: | Source:

---

## Comparative Questions (4)
*Template: "What is the difference between A and B?"*

C1. Q: What is the difference between <mode-A> and <mode-B>?
    A: 
    Confidence: | Source:

C2. Q: When should I use <tool> vs. <alternative-tool>?
    A: 
    Confidence: | Source:

C3. Q: What is the difference between <flag-A> and <flag-B>?
    A: 
    Confidence: | Source:

C4. Q: How does <tool>'s approach to <concept> differ from the conventional approach?
    A: 
    Confidence: | Source:

---

## Creative Questions (4)
*Template: "How would you / could you...?"*

CR1. Q: How would you use <tool> as part of a larger pipeline with <tool-X> and <tool-Y>?
     A: 
     Confidence: | Source:

CR2. Q: How would you automate <tool> for batch processing?
     A: 
     Confidence: | Source:

CR3. Q: How could you test whether <tool> is working correctly in a CI environment?
     A: 
     Confidence: | Source:

CR4. Q: If <tool> is unavailable, what would be the closest substitute and how would the workflow change?
     A: 
     Confidence: | Source:

---

## Gap Analysis

After completing the QA bank:

**Uncertain answers:**
- [ ] Q<number>: 

**Missing answers:**
- [ ] Q<number>: 

**Open Questions to re-enter Phase 2:**
- [ ] 
