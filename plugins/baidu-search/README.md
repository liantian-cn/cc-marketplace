# baidu-search

百度智能云千帆 Web 搜索 MCP 服务器：百度生态中文内容（百家号、百度百科等），支持时效筛选（pd/pw/pm/py），每天 50 次免费额度。

## 安装

```bash
/plugin marketplace add liantian-cn/cc-marketplace
/plugin install baidu-search
```

## 环境变量

在 `~/.claude/settings.json` 的 `env` 字段（或系统环境变量）中配置：

```json
{
  "env": {
    "BAIDU_API_KEY": "你的 Key"
  }
}
```

Key 可在 https://console.bce.baidu.com/qianfan 获取。

## 使用

安装后运行 `/mcp` 确认 `baidu_web_search` 已连接，然后让 Claude 使用 `baidu_web_search` 搜索（用中文关键词效果最佳）。

> 注：`advanced-search` 插件编排八引擎搜索（含本引擎），可与其搭配使用。
