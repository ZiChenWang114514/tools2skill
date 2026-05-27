# Mastery Metrics

## The Core Problem: What Does "Learned" Mean?

For human learners, mastery assessment is straightforward: give a test, grade it against a known answer key.

For an autonomous agent learning a tool, we have no external ground truth. The agent must:
1. Generate its own test (QA bank)
2. Take its own test (answer without raw docs)
3. Grade itself (confidence assessment)

This introduces an obvious vulnerability: the agent could overestimate its own confidence. The metrics below are designed to counteract this.

---

## Primary Metrics

### M1: Use-Case Coverage Rate (Phase 2)

```
coverage = (successfully_executed_use_cases) / (total_canonical_use_cases)
threshold = 0.80
```

**Why 80% and not 100%?**
Some use cases require environment-specific setup (databases, cloud credentials) that may not be available in sandbox. 80% allows for ≤2 blocked use cases in a 10-case curriculum without declaring failure.

**Failure condition:** If coverage < 0.50, the tool may require specialized env setup. Flag and pause for human input.

---

### M2: QA Confidence Rate (Phase 3)

```
confidence_rate = (Confident answers) / (total QA pairs)
threshold = 0.90
```

**Calibration heuristic:** An answer is Confident only if the agent can cite the specific section of the LCD that supports it. "I think so" does not qualify.

**Failure condition:** If confidence_rate < 0.70 after one re-learning cycle (Phase 2 revisit for OPEN QUESTIONS), escalate to human for doc quality assessment.

---

### M3: Gotcha Density (Phase 2)

```
gotcha_density = count(GOTCHAS with Severity >= MEDIUM)
threshold = 3
```

**Why this matters:** A session with 0 gotchas almost certainly means the agent avoided hard cases. Real tools have gotchas. If none were found, the curriculum was too shallow.

**Failure condition:** gotcha_density < 3 → Phase 2 must explicitly revisit Level 4-5 use cases.

---

### M4: Skill Completeness (Phase 4)

All sections of the skill output template must be populated with non-empty, non-placeholder content:
- [ ] What This Tool Does
- [ ] Setup & Prerequisites
- [ ] Core Patterns (≥5)
- [ ] Gotchas & Common Failures (≥3)
- [ ] QA Cheatsheet (≥10)
- [ ] Sequencing Notes

**Failure condition:** Any section empty → skill is incomplete, Phase 4 must continue.

---

### M5: Skill Size (Phase 4)

```
skill_size = token_count(output_skill)
target = ≤ 800 tokens
hard_cap = 1200 tokens
```

**Why enforce size?** Skills are loaded into every conversation where they're triggered. A 3000-token skill is a context budget problem. The compression discipline is part of the methodology.

**If skill > 1200 tokens:** Split into `<tool>-basics.md` and `<tool>-advanced.md` with separate trigger conditions.

---

## Secondary Metrics (for future research)

### M6: Distillation Ratio
```
distillation_ratio = lcd_token_count / skill_token_count
ideal_range = [2.0, 4.0]
```
Too low (<2.0): skill is too verbose, not compressed enough.
Too high (>4.0): skill may be missing critical content.

### M7: Time-to-Mastery
Track wall-clock time per phase to identify bottlenecks in the curriculum.
Expected distribution: Phase 1 (20%) / Phase 2 (50%) / Phase 3 (20%) / Phase 4 (10%)

### M8: Skill Accuracy (longitudinal)
After using the skill in real tasks, track: how often does the skill's advice lead to correct tool use on first attempt? Target: ≥85%.

---

## Mastery Declaration

A session is declared **MASTERED** when ALL of the following hold:
- M1 ≥ 0.80
- M2 ≥ 0.90
- M3 ≥ 3
- M4 = all sections populated
- M5 ≤ 1200 tokens

If any metric fails after one remediation loop, the session is declared **PARTIAL MASTERY** and the skill is tagged `[beta]` with explicit coverage gaps documented.
