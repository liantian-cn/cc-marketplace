# tavily-search

Tavily MCP 服务器：面向 AI 应用优化的搜索 API，返回高质量网页搜索结果、内容提取与摘要，专为 LLM 设计。

## 安装

```bash
/plugin marketplace add liantian-cn/cc-marketplace
/plugin install tavily-search
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

安装后运行 `/mcp` 确认 `tavily-search` 已连接，然后提问，例如「搜索 2025 年 AI 行业报告的最新信息」。

> 注：`advanced-search` 插件编排八引擎搜索（含本引擎），可与其搭配使用。

## Hooks

会话启动时（`SessionStart`）检查 `TAVILY_API_KEY` 环境变量是否已配置；缺失时向 Claude 注入提示，引导调用 `tavily-search-setup` skill 完成配置。

- 配置：`hooks/hooks.json`，脚本：`hooks/check_env.sh`
- Hook 在会话启动时加载，**修改后需重启 Claude Code 生效**
- 也可用 `/hooks` 命令查看当前会话已加载的 hooks
