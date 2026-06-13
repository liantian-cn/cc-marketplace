---
name: ifinD-finance-data
description: "同花顺金融数据一站式查询技能。当用户需要查询 A股/港美股股票数据、公募基金数据、宏观经济与行业经济指标（EDB）、财经新闻、上市公司公告、债券行情估值、指数板块行情时自动触发。覆盖智能选股、财务指标查询、风险分析、ESG 评级、基金持仓分析、可转债转股条款、IPO 事件等场景。如果你的任务是查询任何中国或全球金融市场数据、经济指标、或金融资讯，优先激活本技能——即使只需要一个具体数字（如\"茅台最新PE\"），也通过本技能获取。"
version: "2026-06-13"
category: "金融数据"
compatibility: "requires: node >= 18 or python >= 3.12 （仅脚本兜底时需要）"
mcp_servers:
  - hexin-ifind-ds-stock-mcp
  - hexin-ifind-ds-fund-mcp
  - hexin-ifind-ds-edb-mcp
  - hexin-ifind-ds-news-mcp
  - hexin-ifind-ds-bond-mcp
  - hexin-ifind-ds-global-stock-mcp
  - hexin-ifind-ds-index-mcp
tags:
  - 同花顺
  - 金融数据
  - 股票
  - 基金
  - 宏观经济
  - 行业经济
  - 新闻公告
  - 债券
  - 港美股
  - 指数板块
  - 智能选股
  - EDB
  - 上市公司
  - IPO
  - ESG
model: deepseek-v4-pro
---

# iFinD 金融数据查询
## SKILL 定位
本技能提供同花顺 iFinD 金融数据库的一站式查询能力，覆盖 A 股、港美股、公募基金、债券、指数板块、宏观经济与行业经济指标(EDB)、财经新闻与上市公司公告等 **7 大金融数据域**。

核心逻辑是 **"MCP 直连 + 自然语言查询"**——用户用自然语言描述想查的数据，技能直接调用对应 MCP 工具获取结果，无需用户了解 API 细节。当 MCP 不可用或个别工具未在 MCP 端暴露时，降级使用 `call.py` / `call-node.js` 脚本兜底。

**何时触发本技能**：
- 用户提到任何金融数据查询：股票行情、财务指标、估值、基金净值、债券久期、宏观经济指标、行业产销量
- 用户想"搜一下"某类符合条件的股票/基金/债券
- 用户想了解上市公司新闻、公告、IPO 事件、ESG 评级
- 用户查询指数涨跌、板块走势
- 即使用户只问一个具体数字（如"茅台 PE 现在多少"），也触发本技能

**不适用场景**：
- 深度企业尽职调查（使用 qcc-due-diligence 系列技能）
- 量化策略回测、复杂金融建模（本技能只提供原始数据）

## 共享引用
- MCP 工具映射表：参见本目录下的 `mcp-tools-map.md`（MCP 工具 → 缓存文件名 → 脚本兜底对照）
- MCP 缓存约定：参见本目录下的 `mcp-cache-guide.md`（数据缓存策略）
> **核心原则**：优先调用 MCP 工具（`mcp__plugin_ifind_hexin-ifind-ds-{domain}-mcp__{tool_name}`），MCP 不可用或工具未覆盖时使用脚本兜底（`call("server_type", "tool_name", params)`）。

## MCP 依赖

| 服务器 | 作用 | 可用性 |
|---|---|---|
| `hexin-ifind-ds-stock-mcp` | A股全方位数据（10 工具） | ✅ 完整 |
| `hexin-ifind-ds-fund-mcp` | 公募基金数据（7 工具） | ⚠️ 缺 search_funds |
| `hexin-ifind-ds-edb-mcp` | 宏观经济与行业指标（1 工具） | ⚠️ 缺 search_edb |
| `hexin-ifind-ds-news-mcp` | 财经新闻与公告（2 工具） | ⚠️ 缺 search_trending_news |
| `hexin-ifind-ds-bond-mcp` | 债券市场数据（5 工具） | ✅ 完整 |
| `hexin-ifind-ds-global-stock-mcp` | 港美股数据（4 工具） | ⚠️ 缺 search_global_stocks |
| `hexin-ifind-ds-index-mcp` | 指数与板块数据（3 工具） | ✅ 完整 |

> **并发限制**：免费版 2 qps / 个人版 5 qps / 企业版 10 qps，7 个服务共享速率限制池。

## 通用执行原则

1. **MCP 优先，脚本兜底** — 优先调用 `mcp__plugin_ifind_...` 工具；仅当 MCP 工具不可用或返回错误，或工具未在 MCP 端暴露（见上方 ⚠️ 标记）时，使用脚本 `call()` 降级
2. **先搜再查** — 当用户描述模糊、或指标/实体名不确定时，先用搜索类工具定位目标，再查询具体数据。搜索类工具有：`search_stocks`（MCP）、`search_news`（MCP）、`search_notice`（MCP）、以及仅脚本可用的 `search_edb`、`search_funds`、`search_global_stocks`
3. **查询合并** — 单个工具调用支持多主体、多指标，但主体数和指标数各控制在 **5 个以内**，避免单次调用过重超时
4. **并发友好** — 对不同数据域的查询可并行调用（它们走到不同 MCP 服务器），同域内注意速率限制
5. **板块作主体** — 支持以行业板块作为查询主体（如"医疗设备板块的成分股涨幅"），但板块范围不宜过大
6. **时效性优先** — 新闻/公告查询注重时效，参数不宜过于严格；无结果时尝试放宽时间范围或减少关键词

## 工作流

每个维度独立运作，用户通常只命中一个维度。当用户查询涉及跨域数据时（如"茅台和沪深300的走势对比"），并行查询多个维度然后汇总。

### 维度一：A股股票数据

涵盖沪深北交易所 A 股的全方位数据：行情、基本面、财务、估值、股东、风险、事件、ESG。

**MCP 工具链**：

| MCP 工具 | 功能 | 典型参数 |
|---|---|---|
| `mcp__plugin_ifind_hexin-ifind-ds-stock-mcp__search_stocks` | 智能选股 | `{query: "汽车零部件行业市值大于1000亿的股票"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-stock-mcp__get_stock_summary` | 股票信息摘要 | `{query: "同花顺和恒生电子最新估值水平"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-stock-mcp__get_stock_info` | 基本资料/行业分类 | `{query: "格力电器的上市时间与所属申万行业"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-stock-mcp__get_stock_performance` | 行情/技术指标/形态 | `{query: "三花智控最近5日的涨跌幅与换手率"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-stock-mcp__get_stock_financials` | 财务/估值指标 | `{query: "科大讯飞在2025-12-31的ROE、净利润率"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-stock-mcp__get_stock_shareholders` | 股本结构/股东 | `{query: "光明乳业的流通股占比、前5大股东持股占比"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-stock-mcp__get_risk_indicators` | 定量风险指标 | `{query: "航天电子过去1年的beta(沪深300基准)"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-stock-mcp__get_stock_events` | 重大事件 | `{query: "摩尔线程IPO首次发行新股数量"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-stock-mcp__get_esg_data` | ESG 评级 | `{query: "诚意药业的中诚信ESG评级"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-stock-mcp__stock_highfreq_quotes` | 日内高频行情 | `{symbols:"300033.SZ,贵州茅台", indicators:"最新价,涨跌幅", data_mode:"real_time"}` |

> ⚠️ `stock_highfreq_quotes` 仅支持交易日日内数据，不支持历史数据查询。

### 维度二：公募基金数据

涵盖中国公募基金的基本资料、行情业绩、份额持有人、投资组合、财务数据、基金公司信息及高频行情。

**MCP 工具链**：

| MCP 工具 | 功能 | 典型参数 |
|---|---|---|
| `mcp__plugin_ifind_hexin-ifind-ds-fund-mcp__get_fund_profile` | 基金基本资料 | `{query: "工银双盈债券A(010068)的发行日期与发行费率"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-fund-mcp__get_fund_market_performance` | 行情/业绩/绩效评价 | `{query: "方正富邦策略精选A(010072)在近一周和近一月收益率"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-fund-mcp__get_fund_ownership` | 份额/持有人结构 | `{query: "湘财长弘灵活配置混合A(010076)在2025-06-30的申购总份额和赎回总份额"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-fund-mcp__get_fund_portfolio` | 资产配置/持仓 | `{query: "工银优质成长混合A(010088)在2025-06-30的股票投资占比"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-fund-mcp__get_fund_financials` | 基金财报/分红 | `{query: "泰康浩泽混合A(010081)在2025-06-30的利润"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-fund-mcp__get_fund_company_info` | 基金公司/经理 | `{query: "蜂巢丰瑞债券A(010084)所属基金公司的基金经理数量和平均从业年限"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-fund-mcp__fund_highfreq_quotes` | 日内高频行情 | `{symbols:"000307.OF,易方达蓝筹精选混合", indicators:"最新价,折价", data_mode:"real_time"}` |

> ⚠️ **MCP 暂未覆盖**：`search_funds`（基金搜索）仅在脚本端可用。使用 `call("fund", "search_funds", {"query": "南方基金的新能源ETF"})` 兜底。

### 维度三：宏观经济与行业经济数据（EDB）

涵盖全球经济指标、中国宏观指标、行业经济指标、大宗商品数据。

**MCP 工具链**：

| MCP 工具 | 功能 | 典型参数 |
|---|---|---|
| `mcp__plugin_ifind_hexin-ifind-ds-edb-mcp__get_edb_data` | 宏观/行业经济指标查询 | `{query: "新能源汽车产量当月值（202301-202506）"}` |

> ⚠️ **MCP 暂未覆盖**：`search_edb`（指标搜索）仅在脚本端可用。EDB 指标名称体系庞大，建议先用 `call("edb", "search_edb", {"query": "光伏电池产量相关指标"})` 搜索确认指标名，再用 MCP 的 `get_edb_data` 获取数据。

### 维度四：新闻与公告

涵盖财经新闻语义搜索、上市公司公告全文搜索。

**MCP 工具链**：

| MCP 工具 | 功能 | 典型参数 |
|---|---|---|
| `mcp__plugin_ifind_hexin-ifind-ds-news-mcp__search_news` | 财经新闻语义搜索 | `{query: "脑机接口技术最新进展", time_start: "2025-01-01", time_end: "2026-01-01", size: 5}` |
| `mcp__plugin_ifind_hexin-ifind-ds-news-mcp__search_notice` | 上市公司公告语义搜索 | `{query: "光迅科技2024年度报告 光模块技术", time_start: "2025-01-01", time_end: "2026-01-01", size: 5}` |

> ⚠️ **MCP 暂未覆盖**：`search_trending_news`（热点事件搜索）仅在脚本端可用。使用 `call("news", "search_trending_news", {"keyword": "智能体", "industry_name": "计算机", "time_scope": "24小时", "size": 5})` 兜底。

### 维度五：债券市场数据

涵盖交易所债券的基本信息、行情估值、发行体财务、特殊指标（信用评级、回购、可转债转股）。

**MCP 工具链**：

| MCP 工具 | 功能 | 典型参数 |
|---|---|---|
| `mcp__plugin_ifind_hexin-ifind-ds-bond-mcp__bond_basic_info` | 债券及发行主体信息 | `{query: "23广东11、19黑龙江债01的发行期限与发行总额"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-bond-mcp__bond_market_data` | 行情/估值/风险收益 | `{query: "26国债01近五日收盘价、涨跌幅与最新久期、凸性"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-bond-mcp__bond_financial_data` | 发行体财务指标 | `{query: "24辽港01、24皮城01在20251231的资产负债率和ROE"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-bond-mcp__bond_special_data` | 信用评级/可转债/回购 | `{query: "华海转债、南航转债的最新转股价格及转换比例"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-bond-mcp__bond_highfreq_quotes` | 日内高频行情 | `{symbols:"240025.IB,24附息国债25", indicators:"最新价,涨跌幅", data_mode:"real_time"}` |

> ⚠️ 债券 MCP 工具仅支持交易所债券数据，不支持银行间市场数据。

### 维度六：港美股数据

涵盖港股和美股的基本资料、行情、财务、事件（IPO、回购、分红、ESG）。

**MCP 工具链**：

| MCP 工具 | 功能 | 典型参数 |
|---|---|---|
| `mcp__plugin_ifind_hexin-ifind-ds-global-stock-mcp__global_stock_profile` | 基本资料/行业/上市信息 | `{query: "智谱、minimax的所属行业、上市日期与发行价"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-global-stock-mcp__global_stock_quotes` | 行情/技术指标 | `{query: "苹果和特斯拉近10个交易日的涨跌幅、换手率"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-global-stock-mcp__global_stock_financial` | 财务/估值/盈利预测 | `{query: "Google和Meta在最新报告期的ROE、ROA、利润增速"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-global-stock-mcp__global_stock_events` | 事件数据 | `{query: "minimax的IPO日期、数量、价格及保荐人"}` |

> ⚠️ **MCP 暂未覆盖**：`search_global_stocks`（港美股选股）仅在脚本端可用。使用 `call("global_stock", "search_global_stocks", {"query": "汽车行业且市盈率低于50", "market": "港股"})` 兜底。

### 维度七：指数与板块数据

涵盖股票指数（如沪深300、创业板指）、行业板块（如医疗设备、新能源车）、概念板块的行情与成分股数据。

**MCP 工具链**：

| MCP 工具 | 功能 | 典型参数 |
|---|---|---|
| `mcp__plugin_ifind_hexin-ifind-ds-index-mcp__index_data` | 指数行情/估值/成分 | `{query: "沪深300、中证2000过去10个交易日的涨跌幅和收盘点数"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-index-mcp__sector_data` | 板块行情/成分股 | `{query: "医疗设备板块(中证行业)的成分股个数及过去5个交易日的成分股平均涨跌幅"}` |
| `mcp__plugin_ifind_hexin-ifind-ds-index-mcp__index_highfreq_quotes` | 指数高频行情 | `{symbols:"000001.SH,创业板指", indicators:"最新价,涨跌幅,上涨家数", data_mode:"real_time"}` |

> ⚠️ 板块命名可能相似，查询时尽量提供板块所属分类（如"中证行业"、"申万行业"）以精确定位。

## 脚本兜底

当 MCP 工具不可用（网络异常、未配置、或工具未在 MCP 端暴露）时，使用同目录下的脚本直接发起 HTTP 调用。

**Python**：`from call import call, list_tools`
**Node.js**：`const { call, listTools } = require('./call-node.js')`

```python
# 示例：脚本兜底调用 search_edb（MCP 暂未覆盖）
from call import call
result = call("edb", "search_edb", {"query": "光伏电池产量相关指标"})
if result["ok"]:
    for item in result["data"]:
        print(item)
```

**API Key**：需在 `~/.claude/settings.json` 的 `env` 字段中配置 `IFIND_API_KEY`。所有脚本通过该变量获取鉴权 Token，无需手动构造请求头。

**注意事项**：
- `call()` 返回 `{ok, status_code, data, error, raw}`，务必先检查 `ok` 字段
- 日期格式统一使用 `YYYY-MM-DD`
- 财务类查询的日期为报告期格式（如 `2025-06-30`）
- 查询完成后清理临时脚本

## 输出模板

每次查询结果按以下结构呈现：

```
## [查询标题]

**查询时间**：YYYY-MM-DD HH:MM
**数据来源**：iFinD MCP / [服务器名]
**查询工具**：[MCP 工具完整名]

### 查询结果

[结构化的数据呈现，优先使用表格]

### 数据说明

- 数据时点：[数据对应的时间]
- 数据边界：[如"仅交易所债券"、"不含银行间市场"]
- 免责：[如"数据仅供参考，不构成投资建议"]
```

## 参数

本技能通过自然语言驱动，无需显式传递参数。以下为引导性参数说明：

| 参数 | 说明 | 可选值 |
|---|---|---|
| 数据域 | 指定查询归属域 | `stock` / `fund` / `edb` / `news` / `bond` / `global_stock` / `index` |
| 调用模式 | 强制 MCP 或脚本模式 | MCP 优先（默认）、脚本兜底（MCP 异常时自动降级） |
| 并发级别 | 仅影响速率限制提示 | `free`（2 qps）/ `personal`（5 qps）/ `enterprise`（10 qps） |

## 边界与免责

1. **数据源**：所有数据来自同花顺 iFinD MCP API（`api-mcp.51ifind.com`），数据版权归同花顺所有
2. **时效性**：除 `*_highfreq_quotes` 工具外，其余数据均为日频或更低频率。行情数据有约 15 分钟延迟（实时快照工具除外）
3. **覆盖范围**：债券数据仅覆盖交易所市场，不含银行间市场；港美股数据覆盖主流交易所，部分小盘股可能无数据
4. **非投资建议**：本技能提供原始数据查询，不包含分析、评级或投资建议功能。用户需自行判断数据适用性
5. **速率限制**：免费版 2 qps / 个人版 5 qps / 企业版 10 qps，超限请求会被拒绝。跨服务器调用共享同一速率限制池
6. **API Key 要求**：使用前必须配置 `IFIND_API_KEY`
7. **环境依赖**：脚本兜底需要 Node.js ≥ 18（内置 http/https）或 Python ≥ 3.12 + requests 库
