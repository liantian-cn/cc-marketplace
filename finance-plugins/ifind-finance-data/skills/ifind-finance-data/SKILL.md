---
name: "ifind-finance-data"
description: "Use when querying 同花顺 iFinD 金融数据, including A股、基金、债券、港美股、指数板块、宏观行业指标、新闻公告、实时行情"
homepage: https://www.51ifind.com
version: 3.0.0
author: iFinD
---

# 同花顺金融数据查询

本技能通过 hexin-ifind 系列 MCP 工具调用同花顺 iFinD 金融数据服务。

## 使用前提

- 需要配置 hexin-ifind 系列 MCP 服务器
- 面向用户的回答、报告、摘要和分析必须使用简体中文输出

## MCP 工具列表

### A股数据 (stock)

| MCP 工具 | 功能说明 | 典型参数 |
| --- | --- | --- |
| `mcp__hexin-ifind-ds-stock-mcp__search_stocks` | 智能选股 | `{"query":"电子行业市值大于100亿"}` |
| `mcp__hexin-ifind-ds-stock-mcp__get_stock_summary` | 股票信息摘要 | `{"query":"茅台财务状况"}` |
| `mcp__hexin-ifind-ds-stock-mcp__get_stock_info` | 股票基本资料 | `{"query":"格力电器上市时间"}` |
| `mcp__hexin-ifind-ds-stock-mcp__get_stock_performance` | 股票日频行情与技术指标 | `{"query":"三花智控近5日涨跌幅"}` |
| `mcp__hexin-ifind-ds-stock-mcp__get_stock_shareholders` | 股本结构与股东数据 | `{"query":"光明乳业流通股占比"}` |
| `mcp__hexin-ifind-ds-stock-mcp__get_stock_financials` | 财务数据与指标 | `{"query":"科大讯飞2025年三季度的ROE"}` |
| `mcp__hexin-ifind-ds-stock-mcp__get_risk_indicators` | 风险定量指标 | `{"query":"航天电子在2026-03-19的夏普比率"}` |
| `mcp__hexin-ifind-ds-stock-mcp__get_stock_events` | 上市公司重大事件类指标 | `{"query":"摩尔线程IPO首发股本数量"}` |
| `mcp__hexin-ifind-ds-stock-mcp__get_esg_data` | ESG评级数据 | `{"query":"诚意药业中诚信ESG评级"}` |
| `mcp__hexin-ifind-ds-stock-mcp__stock_highfreq_quotes` | A股实时快照与高频序列 | `{"symbols":"300033.SZ,300059,贵州茅台","indicators":"开盘价,最高价,最低价,收盘价,涨跌幅,成交量","data_mode":"highfreq","interval":1}` |

### 基金数据 (fund)

| MCP 工具 | 功能说明 | 典型参数 |
| --- | --- | --- |
| `mcp__hexin-ifind-ds-fund-mcp__get_fund_profile` | 基金基本资料 | `{"query":"工银双盈债券A(010068)的发行日期与发行费率"}` |
| `mcp__hexin-ifind-ds-fund-mcp__get_fund_market_performance` | 基金行情与业绩 | `{"query":"方正富邦策略精选A(010072)在近一月收益率"}` |
| `mcp__hexin-ifind-ds-fund-mcp__get_fund_ownership` | 基金份额与持有人 | `{"query":"湘财长弘灵活配置混合A(010076)在2025-06-30的申购总份额和赎回总份额"}` |
| `mcp__hexin-ifind-ds-fund-mcp__get_fund_portfolio` | 基金持仓明细 | `{"query":"工银优质成长混合A(010088)在2025-06-30披露报告中的股票投资占比"}` |
| `mcp__hexin-ifind-ds-fund-mcp__get_fund_financials` | 基金财务指标 | `{"query":"泰康浩泽混合A(010081)在2025-06-30的利润"}` |
| `mcp__hexin-ifind-ds-fund-mcp__get_fund_company_info` | 基金公司信息 | `{"query":"蜂巢丰瑞的所属基金公司基金经理数量"}` |
| `mcp__hexin-ifind-ds-fund-mcp__fund_highfreq_quotes` | 基金实时快照与高频序列 | `{"symbols":"000307.OF,516850,易方达蓝筹精选混合","indicators":"最新价,IOPV净值估值,振幅,折价","data_mode":"real_time"}` |

### 债券数据 (bond)

| MCP 工具 | 功能说明 | 典型参数 |
| --- | --- | --- |
| `mcp__hexin-ifind-ds-bond-mcp__bond_basic_info` | 债券基本信息与发债主体资料 | `{"query":"23广东11的发行期限与发行总额"}` |
| `mcp__hexin-ifind-ds-bond-mcp__bond_market_data` | 债券行情数据与估值分析 | `{"query":"26国债01近五日收盘价、涨跌幅与最新久期、凸性"}` |
| `mcp__hexin-ifind-ds-bond-mcp__bond_financial_data` | 发债主体财务数据与指标 | `{"query":"24辽港01、24皮城01在20251231的资产负债率和ROE"}` |
| `mcp__hexin-ifind-ds-bond-mcp__bond_special_data` | 信用债、回购、可转债等特殊指标 | `{"query":"华海转债、南航转债的最新转股价格及转换比例"}` |
| `mcp__hexin-ifind-ds-bond-mcp__bond_highfreq_quotes` | 债券实时快照与高频序列 | `{"symbols":"240025.IB,199222,大连2521","indicators":"开盘价,最高价,最低价,收盘价,成交量","data_mode":"highfreq","interval":1}` |

### 港美股数据 (global-stock)

| MCP 工具 | 功能说明 | 典型参数 |
| --- | --- | --- |
| `mcp__hexin-ifind-ds-global-stock-mcp__global_stock_profile` | 港美股基本资料与股本结构 | `{"query":"智谱、minimax的所属行业、上市日期与发行价"}` |
| `mcp__hexin-ifind-ds-global-stock-mcp__global_stock_quotes` | 港美股行情数据与技术指标 | `{"query":"苹果和特斯拉近10个交易日的涨跌幅、换手率"}` |
| `mcp__hexin-ifind-ds-global-stock-mcp__global_stock_financial` | 港美股财务数据与估值指标 | `{"query":"Google和Meta在最新报告期的ROE、ROA、利润增速"}` |
| `mcp__hexin-ifind-ds-global-stock-mcp__global_stock_events` | 港美股公告事件 | `{"query":"minimax的IPO日期、数量、价格及保荐人"}` |

### 指数板块数据 (index)

| MCP 工具 | 功能说明 | 典型参数 |
| --- | --- | --- |
| `mcp__hexin-ifind-ds-index-mcp__index_data` | 指数行情、技术指标与估值指标 | `{"query":"沪深300、中证2000过去10个交易日的涨跌幅和收盘点数"}` |
| `mcp__hexin-ifind-ds-index-mcp__sector_data` | 板块行情、财务分析与成分股指标 | `{"query":"医疗设备板块(中证行业)的成分股个数及过去5个交易日的成分股平均涨跌幅"}` |
| `mcp__hexin-ifind-ds-index-mcp__index_highfreq_quotes` | 指数实时快照与高频序列 | `{"symbols":"000001.SH,000941,创业板指","indicators":"最高价,最新价,涨跌幅,上涨家数","data_mode":"real_time"}` |

### 宏观经济指标 (edb)

| MCP 工具 | 功能说明 | 典型参数 |
| --- | --- | --- |
| `mcp__hexin-ifind-ds-edb-mcp__get_edb_data` | 指标数据查询 | `{"query":"光伏电池产量202301-202506"}` |

### 新闻公告 (news)

| MCP 工具 | 功能说明 | 典型参数 |
| --- | --- | --- |
| `mcp__hexin-ifind-ds-news-mcp__search_news` | 新闻资讯语义检索 | `{"query":"脑机接口技术最新进展","time_start":"2025-01-01","time_end":"2026-01-01","size":5}` |
| `mcp__hexin-ifind-ds-news-mcp__search_notice` | 公告语义检索 | `{"query":"光迅科技2024年度报告 光模块技术","time_start":"2025-01-01","time_end":"2026-01-01","size":5}` |

## 使用技巧

1. 用户需求不确定时，先加载对应参考文档，再选择工具。
2. 宏观和行业经济指标使用 `get_edb_data` 查询；指标不确定时在 `query` 中描述指标、地区和时间范围。
3. 股票和基金查询通常支持多主体、多指标，但单次主体和指标数量建议控制在 5 个以内。
4. 日内高频或实时行情需求统一参考 `references/quotes.md`，再选择对应的高频行情工具。
5. 所有 MCP 工具使用统一的参数格式，直接传入 JSON 对象即可。

## 注意事项

- 不要在结果中暴露任何 API 密钥。
- 控制请求并发；不确认用户权益时按免费用户较低并发处理。
- Windows PowerShell 处理中文查询时，确保终端输入输出编码支持 UTF-8。
