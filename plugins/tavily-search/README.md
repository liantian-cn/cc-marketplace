# tavily

Tavily MCP 服务器：面向 AI 应用优化的搜索 API，返回高质量网页搜索结果、内容提取与摘要，专为 LLM 设计。

## 安装

```bash
/plugin marketplace add liantian-cn/cc-marketplace
/plugin install tavily
```

## 环境变量

在 `~/.claude/settings.json` 的 `env` 字段（或系统环境变量）中配置：

```json
{
  "env": {
    "TAVILY_API_KEY": "你的 Key"
  }
}
```

Key 可在 https://tavily.com 获取。

## 使用

安装后运行 `/mcp` 确认 `tavily` 已连接，然后提问，例如「搜索 2025 年 AI 行业报告的最新信息」。

> 注：`essentials` 插件已内置 Tavily 搜索技能，安装本插件可独立使用 Tavily MCP 工具。
