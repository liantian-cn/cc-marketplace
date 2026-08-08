# liantian-cc-market

**liantian-cn 的 Claude Code 插件市场** — 企业尽调、金融数据、法律检索与网络搜索插件合集。

[![Validate Plugins](https://github.com/liantian-cn/cc-marketplace/actions/workflows/validate.yml/badge.svg)](https://github.com/liantian-cn/cc-marketplace/actions/workflows/validate.yml)

```bash
claude plugin marketplace add liantian-cn/cc-marketplace
```

## 插件列表

| 插件名字（中文） | 简介 | 安装命令 |
|------|------|---------|
| 同花顺金融数据 | 股票、基金、宏观、行业、债券、港美股等金融数据查询 | `claude plugin install ifind-finance-data@liantian-cc-market` |
| 企业尽调（企查查） | 企业工商核验、股权穿透、法务诉讼、贷后监控、破产预警等尽调工作流 | `claude plugin install qcc-due-diligence@liantian-cc-market` |
| 中国法律宝典（北大法宝） | 法规/案例检索、法条定位、引用校验等法律数据服务 | `claude plugin install pku-law@liantian-cc-market` |
| 超级融合搜索 | 八引擎并行网络搜索编排（Tavily/百炼/博查/百度等），去重合并与优雅降级 | `claude plugin install advanced-search@liantian-cc-market` |
| 办公文档处理 | PDF、Word、PPT、Excel 的创建、编辑与分析 | `claude plugin install office-docs@liantian-cc-market` |
| 文件转 Markdown | 微软 MarkItDown：PDF/Word/PPT/Excel/HTML/图片 → Markdown | `claude plugin install markitdown@liantian-cc-market` |
| 网页 PPT 生成 | 生成单文件 HTML 横向翻页演示（歸藏），支持两种设计风格 | `claude plugin install guizang-ppt@liantian-cc-market` |
| 代码开发工作流 | 黑客帝国主题开发插件：plan→code→audit→commit 全流程编排 | `claude plugin install code-neo@liantian-cc-market` |
| 中文去 AI 味 | 去除中文文本的 AI 生成痕迹，改写而非删除 | `claude plugin install humanizer-zh-next@liantian-cc-market` |
| Tavily 搜索 | 面向 AI 优化的搜索 API，高质量结果与内容提取 | `claude plugin install tavily-search@liantian-cc-market` |
| Exa 语义搜索 | 面向 AI 的语义搜索、相似内容查找与网页内容提取 | `claude plugin install exa-search@liantian-cc-market` |
| 文档检索（Context7） | 5000+ 开源库/框架的最新官方文档与代码示例检索 | `claude plugin install context7@liantian-cc-market` |
| GitHub 代码搜索 | 基于 grep.app 的 GitHub 代码搜索，无需密钥 | `claude plugin install github-search@liantian-cc-market` |
| 网页抓取（Firecrawl） | 网页/PDF/动态页面抓取与爬取，转换为干净 Markdown | `claude plugin install firecrawl@liantian-cc-market` |
| 阿里云百炼搜索 | 通义千问生态联网搜索（DashScope API） | `claude plugin install aliyuncs-search@liantian-cc-market` |
| 博查搜索 | 语义理解、时效筛选与富元数据的 Web 搜索 | `claude plugin install bocha-search@liantian-cc-market` |
| 百度搜索 | 百度生态中文内容搜索（百家号、百度百科），每天 50 次免费额度 | `claude plugin install baidu-search@liantian-cc-market` |

> 部分插件需要 API 密钥，统一在 `~/.claude/settings.json` 的 `env` 字段配置。安装后可运行 `/mcp` 确认 MCP 服务器连接状态。

## 许可证

本仓库结构采用 MIT License。各插件使用各自的许可证。

---

**维护者：** [liantian-cn](https://github.com/liantian-cn)
