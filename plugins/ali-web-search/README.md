# ali-web-search

阿里云百炼 WebSearch MCP 服务器：通义千问生态的联网搜索服务，通过 DashScope API 提供实时网页搜索能力。

## 安装

```bash
/plugin marketplace add liantian-cn/cc-marketplace
/plugin install ali-web-search
```

## 环境变量

在 `~/.claude/settings.json` 的 `env` 字段（或系统环境变量）中配置：

```json
{
  "env": {
    "DASHSCOPE_API_KEY": "sk-..."
  }
}
```

Key 可在 https://bailian.console.aliyun.com 获取。

## 使用

安装后运行 `/mcp` 确认 `ali_web_search` 已连接，然后提问，例如「用阿里百炼搜索今天的科技新闻」。

> 注：`essentials` 插件已内置百炼搜索技能，安装本插件可独立使用该 MCP 工具。
