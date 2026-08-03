---
name: legal-chinese
description: |
  中国法律（中文法律）任务的统一入口技能。当用户提出任何与中国法律相关的请求——包括但不限于涉及法律、法条、法规、司法解释、合同、协议、诉讼、起诉、应诉、答辩、判决、裁定、仲裁、法院、法官、庭审、证据、质证、上诉、再审、执行、律师、辩护、代理、侵权、违约、刑法、民法、行政法、公司法、劳动法、知识产权、合规、风控、尽调、法律风险、司法、判例、裁判、法律意见、法律意见书、法律文书、起诉状、答辩状、判决书等词汇——或请求解读/起草/审查任何法律文本时，都必须触发本技能。即使请求没有直接说出"法律"二字，只要实质内容属于法律事务（如"帮我看看这份合同""这份判决书什么意思""这个行为违法吗"），也应触发。本技能是入口/路由技能：先识别具体法律子任务，再从 references/ 分组索引中选择并读取匹配的参考文档执行，具体方法论在对应 reference 中。
version: "2026-08-03"
category: "法律"
mcp_servers: []
tags:
  - 法律
  - 中国法
  - 法条
  - 合同
  - 诉讼
  - 判决
  - 证据
  - 检索
  - 合规
  - 法律文书
---

# 中国法律智能助手（legal-chinese）

## 一、定位

本技能是**中国法律任务的统一入口（路由）技能**：任何与中国法律相关的请求，都先落到本技能，再由本技能路由到 `references/` 下的专项参考文档。

- 本文件不承载具体方法论——38 个专项方法论以渐进式披露方式存放在 `references/` 中，按任务需要读取，**不要一次性读入全部 reference**。
- 每个 reference 是一份自包含的完整方法论（含概述、工作流、输出模板、验证规则），读取后按其中工作流执行。
- 技能描述中的触发面很宽：凡是法律事务相关词汇或实质内容，都应触发；拿不准时宁可触发（触发只是读取索引做路由，成本低）。

## 二、工作原理：先路由，再读取

处理任何法律请求，按以下三步执行：

1. **识别子任务**：判断请求属于下表 7 组中的哪一组（可能同时命中多组）。
2. **选取 reference**：从对应分组的「文档」列中选出 1 个或多个匹配的 reference 文件。多组命中时按「常用组合链」确定顺序。
3. **读取并执行**：用 Read 读取选中文件，严格按其工作流、输出模板执行。

> 路由表是唯一权威入口。请勿凭印象直接作答——法律任务的正确做法是读取对应 reference 后按其方法论执行；reference 中要求的检索、核验步骤（如法条效力核验）不可跳过。

## 三、路由门

- **意图明确**（能高置信映射到某组某项）：直接执行，不再追问。
- **意图模糊**（无法高置信映射，或多种解释且用户未指明范围）：用下面 7 组分组提示用户选择："请问您需要的是以下哪一类？①信息检索 ②事实与要素处理 ③法律解释 ④法律推理 ⑤论证组织与评估 ⑥风险评估与价值判断 ⑦文书与事务管理"。
- 请求涉及多个分组时按用户指定的顺序依次执行；执行顺序确实影响结果而用户未指定时，才询问优先级。
- 用户提供的是**任务材料**（合同、判决书、案情描述等）而非明确指令时，先按材料类型匹配分组并简述将执行的分析路径，确认后执行。

## 四、References 索引（7 组 × 38 项）

| 编号 | 分组 | 触发场景 / 用户意图 | 文档 |
| --- | --- | --- | --- |
| 01 | 信息检索 | 检索类似案例、法条、立法背景、监管信息；核验法条效力；理解法律概念 | `references/case-retrieval.md` · `references/legal-article-retrieval.md` · `references/other-legal-retrieval.md` · `references/legal-norm-validity-check.md` · `references/legal-concept-comprehension.md` |
| 02 | 事实与要素处理 | 从非结构化文本提取法律事实/要素；争议焦点识别；证据三性与证明力评估 | `references/legal-element-extraction.md` · `references/structured-element-extraction.md` · `references/dispute-issue-identification.md` · `references/evidence-evaluation.md` |
| 03 | 法律解释 | 法条文义模糊、歧义、存在多种理解或适用争议时进行解释论证（文义/体系/目的/规范意义） | `references/legal-interpretation-argument.md` · `references/systematic-interpretation.md` · `references/teleological-interpretation.md` · `references/normative-meaning-argumentation.md` |
| 04 | 法律推理 | 演绎/归纳/类比/溯因/反事实推理；由构成要件推导具体法律后果；解决法条竞合、证据矛盾、法源冲突 | `references/deductive-reasoning.md` · `references/inductive-reasoning.md` · `references/analogical-reasoning.md` · `references/legal-abductive-reasoning.md` · `references/counterfactual-reasoning.md` · `references/formal-legal-consequence.md` · `references/conflict-resolution.md` |
| 05 | 论证组织与评估 | 构建论证链条/反驳对方观点；评估论证强度与置信度；证据-主张对应映射；多个风险点的优先级排序 | `references/argument-chain-construction.md` · `references/argument-strength-evaluation.md` · `references/evidence-argument-chain.md` · `references/strategic-risk-prioritization.md` |
| 06 | 风险评估与价值判断 | 合同纠纷/违约风险审查；企业内部合规体系审查；监管处罚风险评估；司法/行政价值判断与利益衡量；预测判决结果与量刑 | `references/dispute-and-performance-risk.md` · `references/internal-compliance-risk-identification.md` · `references/legal-risk-assessment.md` · `references/judicial-value-judgment.md` · `references/administrative-value-judgment.md` · `references/legal-judgment-prediction.md` ✦ |
| 07 | 文书与事务管理 | 起草判决书/裁判文书；法律文书结构化摘要；多文档综合概览；法律术语规范化；案件全周期规划；法定期限跟踪；工时与诉讼预算 | `references/legal-document-formatting.md` · `references/judgment-document-generation.md` ✦ · `references/legal-document-summarization.md` · `references/multi-document-summarization.md` · `references/legal-terminology.md` · `references/case-lifecycle-planning.md` · `references/trial-scheduling-and-deadline-monitoring.md` · `references/billing-and-litigation-budget.md` |

> ✦ = 合成类技能：自身会编排多个原子能力（如要素提取、推理、后果推导），是复杂任务的终点入口。

## 五、常用组合链

单个 reference 往往不足以完成任务，按以下链条组合（也可按需增删环节）：

- **判决书起草 / 判决书生成**：`legal-element-extraction`（提取事实要素）→ `legal-concept-comprehension`（构成要件理解）→ `evidence-evaluation`（证据评估）→ `deductive-reasoning`（演绎推理）→ `formal-legal-consequence`（推导法律后果）→ `legal-document-formatting` 或 `judgment-document-generation` ✦（产出文书）。
- **合同审查**：`dispute-and-performance-risk`（识别纠纷/违约风险）→ `strategic-risk-prioritization`（风险排序定优先级）→ `legal-norm-validity-check`（核验所涉条款依据的效力）→ `legal-terminology`（规范术语表达）。
- **诉讼应对 / 诉讼方案**：`legal-element-extraction` → `dispute-issue-identification`（确定争议焦点）→ `case-retrieval` + `legal-article-retrieval`（类案与法条支撑）→ `formal-legal-consequence`（预期法律后果）→ `evidence-argument-chain`（证据-主张挂钩）→ `argument-chain-construction`（组织论证）。
- **风险评估**：`legal-risk-assessment` / `internal-compliance-risk-identification`（识别风险）→ `strategic-risk-prioritization`（按概率与影响排序）→ 必要时 `judicial-value-judgment` / `administrative-value-judgment`（价值衡量说理）。
- **法条引用前置校验**：任何请求中要**引用法条作为依据**的，先执行 `legal-norm-validity-check` 确认条文现行有效、层级正确；检索类任务优先走 01 组，无法检索到真实资料时按「边界与免责」标注，绝不编造。

## 六、输出模板

所有输出遵循通用规则：

- 使用简体中文，结构化呈现（分节/表格/清单），先结论后论证；
- 每个结论标注**置信度**（确定/高/中/低）与依据来源（法条/判例/通说）；
- 存在不确定、争议或资料缺口的，明确列出而非含糊带过；
- 引用法条给出具体条文号（如《民法典》第 585 条），引用案例给出案号与法院。

检索类输出（案例、法条、监管信息）额外要求：

```
来源：数据库/MCP 工具名称
检索式/关键词：[使用的检索式]
结果：每项附案号/条文号、法院/制定机关、效力层级与时效性标注
未检索到/无数据：[待检索] 标注
```

## 七、边界与免责

- 本技能的全部输出均为**供执业法律专业人员审阅的草稿，不构成法律意见**；涉及重大权益的结论应由执业律师审核确认。
- **宁缺毋滥，绝不编造**：没有真实数据支撑时标注 `[待检索]`，绝不凭模型记忆编造案号、当事人、裁判要旨或法条内容。
- 检索类 reference（01 组的案例/法条/其他检索）依赖插件 `.mcp.json` 中配置的北大法宝（pkulaw）MCP 服务；服务不可用时按 `[待检索]` 处理，而不是用记忆替代。
- 法律存在时效性：结论应基于现行有效法律法规，注意法律修订带来的变化。
