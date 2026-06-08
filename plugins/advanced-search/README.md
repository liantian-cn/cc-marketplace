# Advanced Search

五合一搜索引擎编排器 — 同时调用 WebSearch、Tavily、Bailian（百炼）、Bocha（博查）、Baidu（百度）五大搜索引擎，自动去重合并，覆盖全球中英文内容。根据查询意图自动路由到搜索、深度研究、站点探索、内容抓取、网页提取等专用能力。

> Adapted from [tavily-ai/skills](https://github.com/tavily-ai/skills) (MIT License). Modified to use Tavily MCP instead of the Tavily CLI. Extended with Bailian, Bocha, and Baidu search engines for comprehensive Chinese content coverage.

## Setup

此插件包含预配置的 `.mcp.json`，连接五个搜索引擎。你需要配置相应的 API Key：

| 引擎 | API Key 变量 | 获取地址 | 说明 |
|------|-------------|---------|------|
| **Tavily** | `TAVILY_API_KEY` | [tavily.com](https://tavily.com) | AI 优化搜索，英文深度研究 |
| **Bailian（百炼）** | `DASHSCOPE_API_KEY` | [dashscope.aliyun.com](https://dashscope.aliyun.com) | 阿里云百炼平台，中文互联网生态 |
| **Bocha（博查）** | `BOCHA_API_KEY` | [bochaai.com](https://bochaai.com) | 语义搜索，精确日期过滤（付费） |
| **Baidu（百度）** | `BAIDU_API_KEY` | [qianfan.baidubce.com](https://qianfan.baidubce.com) | 百度千帆平台，国内非技术信息（50次/天免费） |

**至少配置 Tavily API Key 即可使用。** 未配置的引擎会自动跳过（优雅降级），配置越多引擎，搜索结果越全面。所有 API Key 在 Claude Code 的 `settings.json` 中设置。

## Available Skills

| Skill | What it does |
|-------|-------------|
| **[advanced-search](skills/advanced-search/SKILL.md)** | 五合一搜索引擎编排器。自动识别查询意图（快速查找/新闻事件/深度研究/站点探索/批量抓取/页面提取/通用搜索），并行调用五个搜索引擎，去重合并结果。 |

## 五大搜索引擎对比

| 引擎 | 优势 | 最佳场景 |
|------|------|----------|
| **WebSearch** | 全球广覆盖 | 通用查询、快速查找 |
| **Tavily** | AI 优化、内容提取、深度研究 | 英文内容、结构化数据、研究报告 |
| **Bailian（百炼）** | 中文互联网生态（CSDN/知乎/腾讯云等） | 中文技术类查询、中国话题 |
| **Bocha（博查）** | 语义理解、精确日期过滤、发布日期 | 模糊查询、时效性搜索 |
| **Baidu（百度）** | 百度生态（百家号/百度百科/搜狐等） | 国内非技术信息、社会/娱乐/政策 |

## How it works

`advanced-search` 技能自动将查询意图分为 7 类，并为每类选择最佳的工具组合：

1. **Quick lookup** — 简单事实 → 五引擎并行快速搜索
2. **News & recent events** — 时效性强 → 启用各引擎的时间过滤
3. **Deep research** — 综合分析 → Tavily 深度研究 + 四引擎广覆盖
4. **Site exploration** — URL 发现 → Tavily 站点地图 + 多引擎补充
5. **Bulk extraction** — 批量抓取 → Tavily 爬虫 + 多引擎表面扫描
6. **Page reading** — 指定 URL → Tavily 提取 + 多引擎关联搜索
7. **General search** — 默认模式 → 五引擎并行搜索

所有五个引擎同时并行调用，结果去重合并，标注来源引擎。任一引擎不可用时自动跳过，不影响整体搜索。
