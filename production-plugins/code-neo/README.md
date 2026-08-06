# code-neo

个人风格程序开发插件，黑客帝国主题。Neo 作为日常入口，把非简单编码任务跑成一条可追溯、可审计的流水线：**plan → code → audit → commit**。源自个人常用的 opencode `coder` 工作流，保留了 `.prompt/`、`.plan/`、`.mean/` 三份留痕协议、两轮需求分析、历史意图审查、三次定向审计与三段式提交。

## 安装

```bash
/plugin marketplace add liantian-cn/cc-marketplace
/plugin install code-neo
```

## 使用

- **技能入口**：`/neo <任务描述>`，或直接提出一个非简单编码任务（跨文件改动、重构、需要规划的功能）。
- **自动入口**：Neo agent 会在复杂编码任务到达时被自动触发，自主编排全流程；需要用户决定的点会停下回报，由主线程逐个转问。

### 什么算"非简单"（本插件只处理这类）

- 跨文件改动、重构、需要先规划再实现的功能
- 按规格 / plan / mean 开发

### 什么算"简单"（直接处理，不触发本插件）

- 简单且明确指令的单文件修改
- 明显的 shell / bash / powershell 脚本开发

## 组件

| 组件 | 角色 | 模型 | 工具 |
|------|------|------|------|
| **`/neo` 技能** | 主线程交互式工作流驱动，向用户提问并编排各 agent | 会话默认 | 全量 |
| **Neo**（agent） | 自主编排入口；遇到用户决策则停下回报 | 会话默认 | 读写 + 派生 |
| **The Architect** | 两轮需求分析、历史意图审查、plan/prompt 草稿 | 会话默认 | 只读 |
| **The Oracle** | 证据收集（仓库 + Web + git 历史） | 会话默认 | 只读 + Web |
| **The Construct** | 多模态 / 图像分析 | **HAIKU** | 只读 |
| **Zion** | 按冻结 plan/spec/mean 实现代码 | **SONNET** | 读写 |
| **Sentinel-Compliance** | 业务符合性审计 | 会话默认 | 只读 |
| **Sentinel-Logic** | 代码逻辑与克制性审计 | 会话默认 | 只读 |
| **Sentinel-Style** | 代码风格与业务可读性审计 | 会话默认 | 只读 |

无 MCP、无 hook。

## 工作流

1. 两轮需求分析（The Architect）+ 历史意图审查（git / mean / plan / 设计文档）
2. 逐项向用户确认待决决定，确认共同理解并请求实施授权
3. 冻结并独立提交 plan，创建未提交的 mean 草稿
4. Zion 按冻结 plan 实现并验证
5. 三次审计（业务符合性 / 逻辑与克制性 / 风格与可读性）
6. 修复已接受的 finding 并定向复审
7. 三段式提交：plan 独立提交 → 实施文件 + mean 原子提交 → plan-only 审计元数据提交

## 目录结构

```
production-plugins/code-neo/
├── .claude-plugin/
│   └── plugin.json
├── agents/
│   ├── neo.md
│   ├── the-architect.md
│   ├── the-oracle.md
│   ├── the-construct.md
│   ├── zion.md
│   ├── sentinel-compliance.md
│   ├── sentinel-logic.md
│   └── sentinel-style.md
├── skills/
│   └── neo/
│       ├── SKILL.md
│       └── references/
│           └── plan-mean-prompt.md
└── README.md
```

## 协议要点

- **plan**：`.plan/`，英文，固定章节 `Goal / Scope / Decisions / Implementation Steps / Acceptance Criteria / Verification / Review Notes / Completion`；冻结后四节不可自行修改。
- **mean**：`.mean/`，frontmatter 含 `plan` 与 `related_paths`，正文 `Intent / Constraints / Rejected Alternatives`，与实施文件同原子提交。
- **prompt**：`.prompt/`，记录用户原话与问答，仅留存证据。
- **审计等级**：Blocker / Major / Minor / Suggestion；Blocker 与 Major 阻塞。
- **提交**：中文提交信息，三段式，除非要求否则不推送。

完整协议见 `skills/neo/references/plan-mean-prompt.md`。
