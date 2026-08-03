# exa-search

Exa MCP 服务器：面向 AI 的语义搜索与网页检索，支持向量语义搜索、相似内容查找与网页内容提取。

## 安装

```bash
/plugin marketplace add liantian-cn/cc-marketplace
/plugin install exa-search
```

## 环境变量

在 `~/.claude/settings.json` 的 `env` 字段（或系统环境变量）中配置：

```json
{
  "env": {
    "EXA_API_KEY": "你的 Key"
  }
}
```

Key 可在 https://exa.ai 获取。

## 使用

安装后运行 `/mcp` 确认 `exa-search` 已连接，然后提问，例如「搜索与‘向量数据库’语义最接近的技术文章」。
