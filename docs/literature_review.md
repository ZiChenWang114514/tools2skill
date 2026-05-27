# tools2skill — 相关工作文献综述

> 检索时间：2026-05-26
> 覆盖范围：2023-2026年，arXiv + GitHub + 会议论文

---

## 概述

2025-2026年，"LLM agent 自主构建/管理可复用 skill" 已成为独立研究热点，
出现了大量 Skill* 命名的论文群。tools2skill 定位于这一趋势的**工程实践侧**：
以 context engineering 为理论框架，以 coding agent 为执行主体，
以热插拔 skill 文件为输出产物。

---

## 一、Skill Library / Skill Generation 核心论文

### 1. Voyager ⭐ 最重要先驱
- **标题：** Voyager: An Open-Ended Embodied Agent with Large Language Models
- **链接：** [arXiv:2305.16291](https://arxiv.org/abs/2305.16291) | [GitHub](https://github.com/minedojo/voyager)
- **会议：** NeurIPS 2023
- **核心：** Minecraft 中的 lifelong learning agent，三大组件：自动课程 + 可生长技能库 + 迭代提示机制。技能以 JS 代码存储，按语义检索复用。
- **与 t2s 相似：** 技能库思路、执行-失败-重试循环、技能可检索复用
- **与 t2s 差异：** 领域专用（Minecraft）；无导出/热插拔机制；无结构化课程（Phase 1-4）；无可移植性规则

### 2. SkillMaster ⭐ 最接近
- **标题：** SkillMaster: Toward Autonomous Skill Mastery in LLM Agents
- **链接：** [arXiv:2605.08693](https://arxiv.org/abs/2605.08693)
- **时间：** 2026-05（Shandong U + Tsinghua）
- **核心：** 训练框架，让 agent 学会创建、精炼、选择技能。通过 trajectory-informed skill review 实现内化而非外部调用。
- **与 t2s 相似：** 技能自主创建、精炼、选择全流程
- **与 t2s 差异：** 需要训练（gradient updates）；面向任务解决，不面向工具学习；无热插拔/导出

### 3. AutoSkill ⭐ 高度相关
- **标题：** AutoSkill: Experience-Driven Lifelong Learning via Skill Self-Evolution
- **链接：** [arXiv:2603.01145](https://arxiv.org/abs/2603.01145) | [GitHub](https://github.com/ECNU-ICALK/AutoSkill)
- **时间：** 2026-03（ECNU + Shanghai AI Lab）
- **核心：** 从对话/交互 trace 中自动提炼技能，持续自我演化，动态注入未来请求。Model-agnostic 插件层，支持跨 agent/用户/任务的技能共享。
- **与 t2s 相似：** model-agnostic；技能跨用户共享；无需重新训练
- **与 t2s 差异：** 从对话 trace 提炼（被动），t2s 是主动探索；无结构化课程；无工具类型适配

### 4. SkillFoundry ⭐ 高度相关（用户指出）
- **标题：** SkillFoundry: Building Self-Evolving Agent Skill Libraries from Heterogeneous Scientific Resources
- **链接：** [arXiv:2604.03964](https://arxiv.org/abs/2604.03964)
- **时间：** 2026-04
- **核心：** 将科学领域资源（文档、代码库）转化为经过验证的 skill package（含 task scope、I/O、执行步骤、环境假设、provenance、测试）。以 domain knowledge tree 组织，通过闭环验证迭代扩展/修剪。
- **与 t2s 相似：** 从异构资源提炼 skill；闭环验证；skill package 含元数据（≈ manifest）
- **与 t2s 差异：** 面向科学领域任务；无四阶段课程论；无 CLI 管理/热插拔

### 5. Skills on the Fly
- **标题：** Skills on the Fly: Test-Time Adaptive Skill Synthesis for LLM Agents
- **链接：** [arXiv:2605.16986](https://arxiv.org/abs/2605.16986)
- **时间：** 2026-05
- **核心：** SkillTTA，测试时从相关 training trajectories 合成任务特定临时技能。上下文注入而非参数更新。在 SpreadsheetBench / ALFWorld / BigCodeBench 上验证。
- **与 t2s 相似：** context injection；无参数更新；技能合成
- **与 t2s 差异：** 技能是临时（task-specific）而非持久；无完整工具学习课程

### 6. SkillCraft（用户指出）
- **标题：** SkillCraft: Can LLM Agents Learn to Use Tools Skillfully?
- **链接：** [arXiv:2603.00718](https://arxiv.org/abs/2603.00718)
- **时间：** 2026-03
- **核心：** 构建专门测试 agent 组合/复用高阶工具技能的 benchmark；轻量评估协议让 agent 自动将原子工具合成可执行 skill 并缓存跨任务复用。Token 使用减少 80%。
- **与 t2s 相似：** 原子工具→高阶 skill 组合；持久技能库；效率量化
- **与 t2s 差异：** 侧重 benchmark 而非方法论；无 Phase 1-4 课程

### 7. EXIF — Automated Skill Discovery
- **标题：** Automated Skill Discovery for Language Agents through Exploration and Iterative Feedback
- **链接：** [arXiv:2506.04287](https://arxiv.org/abs/2506.04287)
- **时间：** 2025-06（KAIST AI）
- **核心：** Alice（探索 agent）+ Bob（目标 agent）双 agent 框架，Alice 自动发现有价值技能并训练 Bob。无需人工干预，支持自我演化系统。
- **与 t2s 相似：** 探索优先策略（≈ Phase 1 侦察）；迭代反馈
- **与 t2s 差异：** 需要训练；双 agent 框架而非单 agent 课程

### 8. Automating Skill Acquisition via Mining
- **标题：** Automating Skill Acquisition through Large-Scale Mining of Open-Source Agentic Repositories
- **链接：** [arXiv:2603.11808](https://arxiv.org/abs/2603.11808)
- **时间：** 2026-03
- **核心：** 从 GitHub 开源仓库自动挖掘 agent 技能，转化为标准化 SKILL.md 格式。包含仓库结构分析、语义技能识别（dense retrieval）、格式转换。
- **与 t2s 相似：** 输出 SKILL.md；自动化提取；标准化格式
- **与 t2s 差异：** 被动挖掘（已有代码），t2s 是主动学习；无执行验证

---

## 二、Tool Learning 核心论文

### 9. LLMs in the Imaginarium (STE)
- **标题：** LLMs in the Imaginarium: Tool Learning through Simulated Trial and Error
- **链接：** [arXiv:2403.04746](https://arxiv.org/abs/2403.04746) | [GitHub](https://github.com/microsoft/simulated-trial-and-error) | [ACL 2024](https://aclanthology.org/2024.acl-long.570/)
- **机构：** Microsoft Research
- **核心：** 生物启发的 STE 方法：trial-and-error + imagination + memory。将 Mistral-7B 工具使用准确率从 30% 提升至 76.8%。
- **与 t2s 最接近的工作：** t2s Phase 2（执行→失败分类→重试→记忆）几乎是 STE 的 context-engineering 实现版本
- **可借鉴：** 失败分类法（类型化错误）；想象机制（在执行前模拟）

### 10. ToolLLM / ToolBench
- **标题：** ToolLLM: Facilitating Large Language Models to Master 16000+ Real-world APIs
- **链接：** [arXiv:2307.16789](https://arxiv.org/pdf/2307.16789) | [GitHub](https://github.com/OpenBMB/ToolBench) | [ICLR'24 Spotlight](https://proceedings.iclr.cc/paper_files/paper/2024/file/28e50ee5b72e90b50e7196fde8ea260e-Paper-Conference.pdf)
- **核心：** 16464 个真实 REST API 的大规模工具使用 SFT 数据集 + 训练框架。DFSDT 搜索算法改善多步工具推理。
- **与 t2s 差异：** 需要 fine-tuning；静态数据集；不产出 skill 文件

### 11. CREATOR
- **标题：** CREATOR: Tool Creation for Disentangling Abstract and Concrete Reasoning of Large Language Models
- **链接：** [arXiv:2305.14318](https://arxiv.org/abs/2305.14318)
- **核心：** LLM 自己创建工具（Python 脚本）而非调用现有工具。解耦抽象推理与具体执行。
- **与 t2s 可借鉴：** 工具创建 vs 工具学习的边界定义

---

## 三、Benchmark 论文

### 12. SkillGenBench
- **标题：** SkillGenBench: Benchmarking Skill Generation Pipelines for LLM Agents
- **链接：** [arXiv:2605.18693](https://arxiv.org/abs/2605.18693)
- **时间：** 2026-05
- **核心：** 评估 skill generation pipeline 的 benchmark。两种制度（任务条件/任务无关）× 两类数据源（代码库/文档）。确定性执行检查协议。
- **对 t2s 的价值：** 提供了评估 tools2skill 生成 skill 质量的标准化框架

### 13. SkillLearnBench
- **标题：** SkillLearnBench: Benchmarking Continual Learning Methods for Agent Skill Generation on Real-World Tasks
- **链接：** [arXiv:2604.20087](https://arxiv.org/abs/2604.20087)
- **时间：** 2026-04

### 14. How Well Do Agentic Skills Work in the Wild
- **链接：** [arXiv:2604.04323](https://arxiv.org/abs/2604.04323v1)
- **时间：** 2026-04

---

## 四、Survey / Framework 论文

### 15. 综合 Survey：Agent Skills
- **标题：** A Comprehensive Survey on Agent Skills: Taxonomy, Techniques, and Applications
- **链接：** [arXiv:2605.07358](https://arxiv.org/html/2605.07358v1)
- **时间：** 2026-05
- **价值：** tools2skill 的定位参考；taxonomy 可直接引用

### 16. Agent Skills for Large Language Models（架构综述）
- **链接：** [arXiv:2602.12430](https://arxiv.org/html/2602.12430v3)
- **时间：** 2026-02

### 17. SkillFlow：Scalable Skill Retrieval
- **链接：** [arXiv:2504.06188](https://arxiv.org/pdf/2504.06188)
- **时间：** 2025-04

---

## 五、GitHub 工程项目

| 项目 | Stars | 核心功能 | 链接 |
|------|-------|---------|------|
| **MineDojo/Voyager** | ~5k | Minecraft lifelong learning，技能库原型 | [GitHub](https://github.com/minedojo/voyager) |
| **OpenBMB/ToolBench** | ~5k | 16000+ API工具学习平台 | [GitHub](https://github.com/OpenBMB/ToolBench) |
| **ECNU-ICALK/AutoSkill** | — | 从对话 trace 自动提炼 skill | [GitHub](https://github.com/ECNU-ICALK/AutoSkill) |
| **microsoft/simulated-trial-and-error** | — | STE 工具学习实现 | [GitHub](https://github.com/microsoft/simulated-trial-and-error) |
| **muratcankoylan/Agent-Skills-for-Context-Engineering** | ~2.3k（1周） | Context engineering 的 Claude Code skill 集合 | [GitHub](https://github.com/muratcankoylan/agent-skills-for-context-engineering) |

---

## 六、工具2skill 差异化分析

### tools2skill 的真正独特性

经过系统调研，tools2skill 在以下几点上没有被现有工作覆盖：

| 维度 | 现有最接近工作 | tools2skill 的差异 |
|------|--------------|------------------|
| **课程结构化（4 Phase）** | Voyager 有课程，但无显式 Phase | 4阶段写入协议 + 退出标准，完全显式 |
| **Context as pedagogy** | 所有工作把 context 当 memory | t2s 把 context 当结构化教学媒介 |
| **Living Context Document** | 无 | 带写入协议隔离的 LCD schema |
| **工具类型适配课程** | 无 | 5种工具类型各有 curriculum variant |
| **可移植性规则 + 自动验证** | 无 | 7条规则 + `t2s validate` 自动扫描 |
| **热插拔 CLI（t2s install）** | 无 | 直接对接 Claude Code `~/.claude/skills/` |
| **导出格式（.t2s bundle）** | 无 | ZIP bundle（skill.md + manifest + session_log）|
| **量化掌握度（M1-M5）** | SkillMaster 有但训练时计算 | 推理时自我评估，无需 GPU |

### 最接近 tools2skill 的工作

1. **SkillFoundry** (2604.03964)：最接近在资源→skill 转化路径上，但面向科学领域文档而非通用工具执行
2. **LLMs in the Imaginarium / STE** (2403.04746)：Phase 2 执行循环的理论基础
3. **AutoSkill** (2603.01145)：model-agnostic + 跨用户共享的工程目标相同
4. **muratcankoylan/Agent-Skills-for-Context-Engineering**：Claude Code skill 生态的直接竞品，但手工编写非自动生成

---

## 七、可借鉴的具体设计

| 来源 | 可借鉴点 | 应用到 t2s 哪里 |
|------|---------|----------------|
| **STE / Imaginarium** | 3种失败类型分类（execution / documentation / edge case） | Phase 2 失败分类法 |
| **Voyager** | 技能按语义 embedding 检索（不只是名字匹配） | `t2s list` 未来版本加语义搜索 |
| **SkillFoundry** | domain knowledge tree 组织技能库 | `registry.json` 升级为层级树结构 |
| **AutoSkill** | standardized skill representation for sharing | manifest.json 格式参考 |
| **SkillGenBench** | 确定性执行检查协议 | Phase 3 QA 验证可引入执行检查 |
| **EXIF** | Alice-Bob 双 agent 探索框架 | Phase 1 侦察可用 sub-agent 并行 |
| **muratcankoylan** | SKILL.md 格式规范（已被社区采用） | skill_output_template.md 兼容此格式 |

---

## 八、结论

tools2skill 出现在 agent skill 研究的**爆发期**（2025-2026年几十篇论文集中涌现），
但其核心定位——**coding agent 主动学习陌生工具 + context engineering 课程 + 热插拔导出**
——在现有工作中尚无完整覆盖。

最需要关注的竞争工作是 **SkillFoundry** 和 **SkillMaster**；
最值得引用的基础工作是 **Voyager** 和 **STE/Imaginarium**；
最值得跟踪的 benchmark 是 **SkillGenBench**（可用于评估 t2s 生成的 skill 质量）。
