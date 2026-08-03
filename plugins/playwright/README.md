# playwright

微软 Playwright MCP 服务器：浏览器自动化与端到端测试。让 Claude 可以操作网页——点击元素、填写表单、截图、执行 JS 等。

## 安装

```bash
/plugin marketplace add liantian-cn/cc-marketplace
/plugin install playwright
```

## 配置

本插件已预置以下环境变量（可通过 `~/.claude/settings.json` 的 `env` 字段覆盖）：

| 变量 | 值 | 说明 |
|------|-----|------|
| `PLAYWRIGHT_MCP_PROXY_SERVER` | `socks5://127.0.0.1:7897` | 走本地代理（Clash 等），按需修改 |
| `PLAYWRIGHT_MCP_BROWSER` | `msedge` | 使用本机 Edge 浏览器，可改为 `chrome` |
| `PLAYWRIGHT_MCP_IGNORE_HTTPS_ERRORS` | `1` | 忽略 HTTPS 证书错误 |

## 使用

安装后运行 `/mcp` 确认 `playwright` 已连接，然后让 Claude 执行浏览器任务，例如「打开 example.com，截图并总结页面内容」。
