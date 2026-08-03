# firecrawl

Firecrawl MCP 服务器：网页抓取与爬取（scrape / crawl / search），支持将网页、PDF、动态渲染页面转换为干净的 Markdown 数据。

## 安装

```bash
/plugin marketplace add liantian-cn/cc-marketplace
/plugin install firecrawl
```

## 环境变量

在 `~/.claude/settings.json` 的 `env` 字段（或系统环境变量）中配置：

```json
{
  "env": {
    "FIRECRAWL_API_KEY": "你的 Key"
  }
}
```

Key 可在 https://firecrawl.dev 获取。

## 使用

安装后运行 `/mcp` 确认 `firecrawl` 已连接，然后提问，例如「抓取 https://example.com 的正文内容并转成 Markdown」。
