---
name: neo
description: |
  在非简单编码任务上运行 plan→code→audit→commit 全流程。当用户要求"完整做一个功能"、"重构/跨文件改动"、"先规划再实现"、"按规格/按 plan 开发"、"走一遍完整流程"、"认真做这个改动"等时自动加载，或通过 /neo <任务描述> 显式调用。不适用于简单任务：明确指令的单文件修改、明显的 shell/bash/powershell 脚本开发——这些直接处理即可，不要加载本技能。
argument-hint: <任务描述>
version: 2026-08-06
category: 程序开发
tags: [programming, plan, code, audit, commit, workflow]
---

# Neo — plan→code→audit→commit 工作流

## 定位

Neo 是 code-neo 插件的日常入口，把非简单编码任务跑成一条可追溯、可审计的流水线：两轮需求分析 → 冻结 plan → 实现 → 三次审计 → 修复 → 验证 → 三段提交。保留 `.prompt/`、`.plan/`、`.mean/` 三份留痕协议。

## 运行模式

本技能可能在两种上下文中执行，必须先判断当前是哪一种：

- **交互模式（主线程）**：可以使用 `AskUserQuestion` 向用户提问。所有用户决定都用 `AskUserQuestion` 提供选项，一次一个问题。
- **自主模式（Neo subagent，无交互能力）**：不得调用 `AskUserQuestion`。遇到必须由用户决定的事项，停下并将候选决策（问题 + 推荐答案 + 仓库证据）回报给主线程，由主线程转问用户后再继续。

## 工作流顺序

1. 使用任务工具（TaskCreate / TaskUpdate / TaskList）展示工作流，每步完成都更新。
2. 派生 **The Architect** 进行第一轮需求分析，写 `.prompt/YYYY-MM-DD-title.md` 与 `.plan/YYYY-MM-DD-title.md` 草稿。
3. 派生 **The Architect** 进行第二轮需求分析，只检查未决、高风险、矛盾、遗漏或依赖未闭合的分支，完成后更新 plan 草稿与 prompt 文件。
4. 派生 **The Architect**（或 **The Oracle** 提供证据）进行历史意图审查，完成后只更新 plan 草稿。
5. 使用一个最终选项问题确认共同理解并请求实施授权。
6. 确认后冻结并独立提交 plan，再创建未提交的同名 mean 草稿。
7. 派生 **Zion**（SONNET）按冻结 plan 进行代码开发和验证。
8. 分别执行业务符合性、代码逻辑与克制性、代码风格与业务可读性三次审计（大型变更派生三个 Sentinel）。
9. 修复已接受的 finding，并对 finding、修复和直接回归进行定向复审。
10. 完成最终验证和提交。

## 决策与提问协议

- 用户决定需求、范围、用户可见行为、验收标准、不可逆操作和风险接受。能够由仓库事实、冻结 plan、现有惯例或唯一正确性答案确定的实现细节，由当前流程处理。
- 事实通过探索仓库可得就必须自行查询，不询问用户；需要用户取舍的决定逐项交给用户。
- 交互模式：每次恰好提出一个问题并等待回答，不合并多个问题。推荐选项放第一位并在标签中标注"推荐"；只有一个合理方案时，仍提供真实的拒绝、继续讨论或取消选项，不得制造虚假替代方案。
- 自主模式：每次回报一个候选决策，附推荐答案与仓库证据。
- 最终确认共同理解之前，可以创建和更新 plan 草稿，但不得修改代码、测试、配置或业务文档，也不得执行实施步骤。
- 用户授权实施时，默认同时授权本工作流规定的提交操作。

## 组件清单

| 组件 | 何时派生 | 模型 |
|------|---------|------|
| **The Architect** | 规划阶段：两轮需求分析、历史意图审查、plan/prompt 草稿 | 会话默认 |
| **The Oracle** | 需要外部证据或历史意图证据时（只读） | 会话默认 |
| **The Construct** | 需要多模态 / 图像分析时（只读） | HAIKU |
| **Zion** | plan 冻结后按 plan/spec/mean 实现代码 | SONNET |
| **Sentinel-Compliance** | 业务符合性审计（只读） | 会话默认 |
| **Sentinel-Logic** | 代码逻辑与克制性审计（只读） | 会话默认 |
| **Sentinel-Style** | 代码风格与业务可读性审计（只读） | 会话默认 |

## 简单任务判定（不要触发本技能）

以下任务直接处理，不加载本技能、不派生子代理：

- 简单且明确指令修改单文件。
- 明显的 shell / bash / powershell 脚本开发。

## plan / mean / prompt 协议

- plan 固定章节：`Goal`、`Scope`、`Decisions`、`Implementation Steps`、`Acceptance Criteria`、`Verification`、`Review Notes`、`Completion`；英文，只记录仓库事实与已确认决定。
- 创建前检查目标路径；同名 plan/mean 已存在时用选项问题让用户决定。
- 冻结后不得自行修改 `Goal`/`Scope`/`Decisions`/`Implementation Steps`/`Acceptance Criteria`；`Verification`/`Review Notes`/`Completion` 可追加。
- 冻结后需求变化：暂停，定向重审、重新确认、再次冻结，以独立 plan-only 提交记录，再恢复实施。
- mean 位于 `.mean/`，frontmatter 含 `plan` 与 `related_paths`；正文为 `Intent`、`Constraints`、`Rejected Alternatives` 三章节（无内容写 None）；与实施文件同原子提交。
- prompt 位于 `.prompt/`，章节 `Primary`（用户原话）与 `Question`（问题与答案）；仅留存证据。

完整协议见 **`references/plan-mean-prompt.md`**。

## 审计协议

- 中小型变更由当前流程直接审计；跨模块/接口、迁移、安全边界、不可逆副作用或多个独立业务流程任一时视为大型变更，必须派生只读 Sentinel 完成专项审计。
- 审计以冻结 plan、本次实现 diff 与直接依赖为强制边界，不报告无关既有问题。
- finding 等级：**Blocker**（当前 plan 下无法正确交付）、**Major**（违反核心需求/正确性/强制验收）、**Minor**（局部具体风险）、**Suggestion**（可选改进）。
- Blocker/Major 阻塞；Minor 优先最小修复，若不修复等于接受残余风险则交用户决定；Suggestion 只记录。
- 修复后只定向复审已接受的 finding、修复与直接回归；同一 finding 连续两次未解决或修复往返即流程停滞，用选项问题让用户决定。

## 验证与提交

- 验证与风险相称，记录命令、退出码、覆盖范围、限制、未运行检查及原因。
- 关键验证无法执行时不得标 `success`，必须报告缺失证据并用选项问题让用户决定。
- 成功流程三段提交：
  1. 冻结 plan 独立提交。
  2. 全部实施文件与 mean 原子提交。
  3. 在 plan 的 `Review Notes`/`Verification`/`Completion` 追加审计与验证元数据，plan-only 提交。
- 每次提交前检查 status、完整 diff、近期 log、staged diff 与 `git diff --cached --check`。
- 只暂存本任务相关路径；提交信息用中文，标题正文均非空；除非用户明确要求否则不推送。

## 输出模板

最终报告实际存在的 plan、mean、变更文件、审计与修复轮次、验证命令和退出码、残余风险或限制，以及实际产生的提交哈希。结果明确标记为 `success`、`no-op`、`cancelled-before-freeze` 或 `cancelled-after-freeze`。

## 参考文件

- **`references/plan-mean-prompt.md`** — plan/mean/prompt 三份协议全文、审计规模与闭环、验证与提交细则、代码风格与强制充分注释。
