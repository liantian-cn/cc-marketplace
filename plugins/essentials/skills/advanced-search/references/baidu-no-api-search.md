# Baidu 无 API 搜索 — 参数参考

百度无 API 搜索通过 www.baidu.com 网页抓取获取搜索结果。**这是 Baidu MCP (`baidu_web_search`) 不可用时的兜底方案**，不应在 Baidu MCP 正常工作时使用。

## 触发条件

Baidu no-API 仅在以下情况触发：
- Baidu MCP 子代理返回认证错误（`BAIDU_API_KEY` 未配置或无效）
- Baidu MCP 工具 (`baidu_web_search`) 不可用（工具未找到、服务不可用）
- Baidu MCP 返回错误响应

**正常情况始终优先使用 Baidu MCP** — 它有 `freshness` 时间过滤、更快的响应速度、更稳定的结果格式。

## 调用方式

Baidu no-API 没有 MCP 服务，通过 **直接 Bash 命令** 执行：

```bash
python plugins/essentials/skills/advanced-search/scripts/baidu_no_api.py "关键词" -n 数量
```

**仅在 Baidu MCP 子代理失败后**才执行此命令。不要与 Baidu MCP 并行运行。

## 参数

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `query` | string | (必填) | 搜索关键词。**建议使用中文关键词** — 百度对中文查询的返回质量最高 |
| `-n, --num` | integer | 10 | 返回结果数量，范围 1–50 |
| `-o, --output` | string | (可选) | 输出 JSON 文件路径 |

**无 `freshness`、`search_depth`、`site:` 等高级过滤参数。** 这是基础的网页抓取搜索工具。

## 响应结构

```json
{
  "query": "搜索关键词",
  "total": 10,
  "results": [
    {
      "title": "结果标题",
      "url": "https://...",
      "summary": "页面摘要/片段"
    }
  ]
}
```

**错误响应：**
```json
{
  "query": "关键词",
  "total": 0,
  "results": [],
  "error": "错误描述"
}
```

## 特点与优势

| 维度 | 评价 |
|------|------|
| **中文内容覆盖** | ★★★★★ — 百度百家号、百度百科、CSDN、知乎、搜狐等全覆盖 |
| **国际内容** | ★★☆☆☆ — 可返回 GitHub 等国际站点，但覆盖面有限 |
| **速度** | ★★★☆☆ — 网页抓取比 API 慢，通常 2–5 秒 |
| **结果丰富度** | ★★★☆☆ — 返回标题、URL、摘要，无发布日期 |
| **高级过滤** | ☆☆☆☆☆ — 不支持任何过滤参数 |
| **API Key** | 🆓 — 完全免费，无需任何配置 |
| **每日限额** | 🆓 — 无限制（但需注意反爬虫） |

## 与 Baidu MCP 的对比

| 维度 | Baidu MCP | Baidu no-API (本工具) |
|------|-----------|----------------------|
| 调用方式 | MCP 工具 `baidu_web_search` | Bash 命令 `python baidu_no_api.py` |
| API Key | ✅ 需要 `BAIDU_API_KEY` | ❌ 不需要 |
| 每日限额 | 50 次/天 | 无限制 |
| 时间过滤 | ✅ `freshness` (pd/pw/pm/py) | ❌ 不支持 |
| 响应速度 | ★★★★★ (API) | ★★★☆☆ (网页抓取) |
| 结果格式 | 稳定的 JSON API | HTML 解析，可能受页面结构变化影响 |
| 稳定性 | ★★★★★ | ★★★☆☆ (反爬虫风险) |
| 发布日期 | ⚠️ 部分隐含 | ❌ 不返回 |

## 使用策略

1. **优先使用 Baidu MCP** — 速度快、结果稳定、支持时间过滤
2. **Baidu MCP 失败时** → 自动切换到 Baidu no-API 作为兜底
3. **兜底时标注** — 结果标记为 `[Baidu no-API]` 以区别于正常的 `[Baidu]` 标签
4. **同一次搜索中不重复运行** — 如果 Baidu MCP 成功，不运行 Baidu no-API

## 局限与风险

- **网页抓取不稳定** — 百度页面结构可能随时调整，导致解析失效
- **无时间过滤** — 无法按时间范围筛选
- **无全文提取** — 仅返回标题和摘要
- **反爬虫风险** — 百度有严格的反爬虫机制，频繁请求可能导致 IP 被封
- **无发布日期** — 不返回 `published_date`，无法判断内容时效性
- **URL 可能为跳转链接** — 百度搜索结果中的 URL 可能经过百度跳转包装
