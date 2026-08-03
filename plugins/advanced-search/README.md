# advanced-search

八引擎并行网络搜索编排技能：**WebSearch + Tavily + 百炼(Bailian) + 博查(Bocha) + 百度(Baidu) + 搜狗微信(WeChat) + Bing CN + Bing Int**，外加百度无 API 兜底。多引擎并行发起、结果去重合并、优雅降级（任一引擎失败不影响整体）、按意图路由深度研究/站点爬取/URL 提取等复杂任务。

## 安装

```bash
/plugin marketplace add liantian-cn/cc-marketplace
/plugin install advanced-search
```

## 依赖

本插件为纯技能编排，MCP 引擎由独立插件提供，请按需安装并配置对应环境变量：

| 引擎 | 插件 | 环境变量 |
|------|------|---------|
| Tavily | `tavily-search` | `TAVILY_API_KEY` |
| 百炼 Bailian | `aliyuncs-search` | `DASHSCOPE_API_KEY` |
| 博查 Bocha | `bocha-search` | `BOCHA_API_KEY` |
| 百度 Baidu | `baidu-search` | `BAIDU_API_KEY` |

WebSearch（内置）、搜狗微信 / Bing CN / Bing Int / 百度无 API 兜底为本地脚本引擎，无需 API Key；Bing Int 需代理（`BING_PROXY` 环境变量或 `--proxy` 参数）。

## 使用

安装后提问即可，例如「搜索 2025 年 AI 行业报告的最新信息」。技能会自动并行调用可用引擎并合并去重。
