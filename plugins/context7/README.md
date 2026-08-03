# context7

Context7 MCP 服务器：检索主流开源库/框架的**最新**官方文档并注入上下文，解决模型训练数据过期的问题。

## 安装

```bash
/plugin marketplace add liantian-cn/cc-marketplace
/plugin install context7
```

## 环境变量

在 `~/.claude/settings.json` 的 `env` 字段（或系统环境变量）中配置：

```json
{
  "env": {
    "CONTEXT7_API_KEY": "你的 Key"
  }
}
```

Key 可在 https://context7.com 免费获取。未配置时服务器可能无法通过鉴权。

## 使用

安装后运行 `/mcp` 确认 `context7` 已连接，然后直接提问，例如「搜索 React 最新文档中关于 useEffect 的内容」。

## Hooks

会话启动时（`SessionStart`）检查 `CONTEXT7_API_KEY` 环境变量是否已配置；缺失时向 Claude 注入提示，引导调用 `context7-setup` skill 完成配置。

- 配置：`hooks/hooks.json`，脚本：`hooks/check_env.sh`
- Hook 在会话启动时加载，**修改后需重启 Claude Code 生效**
- 也可用 `/hooks` 命令查看当前会话已加载的 hooks
