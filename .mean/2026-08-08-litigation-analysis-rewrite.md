---
plan: .plan/2026-08-08-litigation-analysis-rewrite.md
related_paths:
  - finance-plugins/qcc-due-diligence/skills/qcc-due-diligence/references/workflows/litigation-analysis.md
  - finance-plugins/qcc-due-diligence/.claude-plugin/plugin.json
  - .claude-plugin/marketplace.json
---

# Intent

按在线企查查 SKILL（https://agent.qcc.com/skill/v1/banking/litigation-analysis-qcc/SKILL.md）的最佳实践，将本地 `litigation-analysis.md` workflow 引用文件从 34 行英文精简版改写为中文完整版。业务逻辑（六维度工作流、先扫后钻、year 留空、ABCD+F 评级与阈值、报告严格填空骨架、参数、边界与免责、报告输出纪律）100% 逐字保留；仅做环境适配：MCP 工具名改写为 session 约定前缀 `mcp__plugin_qcc-due-diligence_<server>__<tool>`，删除版本信息与在线注释区块。版本号（plugin.json / marketplace.json）由并行发布周期处理（用户决定跳过），本任务仅提交 workflow 文件与 mean。

# Constraints

- 冻结 plan 的 Goal / Scope / Decisions / Implementation Steps / Acceptance Criteria 不可修改。
- 删除项（用户指令）：QCC_ONLINE_EXPERIENCE_PLAN 注释块、版本 banner（改写为本地头部结构，剥离版本措辞）、**SKILL 版本** 块、正文 V2.0 / 旧版 / 增强版 字样、A 层铁律具体注解与日期戳、死链（QCC-MCP-TERMINOLOGY.md / docs/MCP_CONFIGURATION.md）。
- 工具名统一 `mcp__plugin_qcc-due-diligence_<server>__<tool>`；qcc-history 当前未配置属正常，引用保留并加注；`get_judicial_document_detail` 的 section 枚举用 session 实际值（核心裁判 / 诉辩主张 / 审理与执行经过），不照抄 core/claims/process。
- 工具计数更新为平台口径 qcc-risk 38 / qcc-history 34 / qcc-executive 44。
- 报告输出纪律第 1 条工具名模式同步改写，第 2-6 条逐字保留；L478 条款原样。
- 提交范围（用户两次决定）：仅 litigation-analysis.md + .mean/ 原子提交；plugin.json 与 marketplace.json 的版本由并行发布周期处理，本任务零改动；不推送；`.claude/settings.json` 与并行进程改动不碰。

# Rejected Alternatives

- 整块删除顶部 banner：文件结构将偏离全部三个先例（equity-structure / ubo-screening / executive-background），用户选择改写为本地头部结构。
- 保留在线 section 枚举 core/claims/process：与当前 session 工具 schema 不符。
- 用 qcc-company get_change_records 替代 qcc-history 历史诉讼工具：诉讼历史维度无直接替代品，且用户明确 qcc-history 不可用属正常、保留其命名格式。
- 保留在线工具计数 34/34/42：与兄弟文档（executive-background）不一致，用户选择平台总数 38/34/44。
