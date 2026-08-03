# liantian-cc-market

**liantian-cn 的 Claude Code 插件市场** — 面向企业尽职调查、金融数据、法律检索与网络搜索场景的一站式插件集合，以 **ifind-finance-data（行业与上市公司数据）**、**qcc-due-diligence（企业工商与风险尽调）**、**pku-law（中国法律宝典）**、**advanced-search（超级融合搜索）** 四大核心插件为基础，并提供一组可独立使用的搜索 MCP 插件。

[![Validate Plugins](https://github.com/liantian-cn/cc-marketplace/actions/workflows/validate.yml/badge.svg)](https://github.com/liantian-cn/cc-marketplace/actions/workflows/validate.yml)

## 快速开始

```bash
# 1. 添加本市场
claude plugin marketplace add liantian-cn/cc-marketplace

# 2. 查看已添加的市场
claude plugin marketplace list

# 3. 安装核心插件（可按需安装任意一个）
claude plugin install ifind-finance-data
claude plugin install qcc-due-diligence
claude plugin install pku-law
claude plugin install advanced-search
```

> 也可以在 Claude Code 会话中通过斜杠命令完成同样操作：`/plugin marketplace add liantian-cn/cc-marketplace`、`/plugin install <插件名>`。

---

## 核心插件

### 1. ifind-finance-data — 行业与上市公司金融数据

通过同花顺 iFinD MCP API 提供覆盖中国金融市场的全方位数据查询能力（股票 / 基金 / 宏观 / 行业 / 新闻 / 债券 / 港美股 / 指数板块 7 大服务）。

- **行业信息**：宏观与行业经济指标（GDP、CPI、PPI）、行业产品产销量与进出口、大宗商品量价与库存（EDB）
- **上市公司信息**：智能选股、公司基本信息与行业分类、财务数据与财务指标、日频行情与技术指标、股东与股本结构、ESG 评级、定量风险指标、重大事件与公告
- **更多数据**：基金（资料/行情/持仓/持有人/公司）、债券（行情/财报/信用/可转债）、港美股、指数板块、财经新闻

**安装与密钥配置**

```bash
claude plugin install ifind-finance-data
```

在 `~/.claude/settings.json` 的 `env` 字段配置密钥：

```json
{
  "env": {
    "IFIND_API_KEY": "您的API密钥"
  }
}
```

密钥获取：https://mcp.51ifind.com/ → 个人中心 → 密钥。未配置时启动会话会提示调用 `ifind-mcp-setup` 技能完成配置。

### 2. qcc-due-diligence — 企业工商、法务、上下游与风险尽调

基于企查查（QCC）商业数据库的企业尽职调查工具包，提供覆盖企业全生命周期风控的 **12 项业务工作流**：

- **企业工商信息**：企业身份核验（KYB）、股权结构审查、最终受益所有人筛查（UBO）、工商登记/变更/年报、对外投资
- **法务信息**：诉讼分析、裁判文书与开庭公告、被执行、失信、限制高消费/出境、行政处罚、知识产权
- **上下游/交易对手**：交易对手风险审查（客户、供应商、合作方）、担保方审查、对外投资与关联企业
- **风险监控**：信用尽职调查、信用持续监控（贷后）、破产风险监控、企业经营健康扫描、高管背景调查、贸易融资合规审查

**安装与密钥配置**

```bash
claude plugin install qcc-due-diligence
```

```json
{
  "env": {
    "QCC_API_KEY": "您的API密钥"
  }
}
```

密钥获取：https://agent.qcc.com/ → 注册登录后创建 QCC API Key。未配置时启动会话会提示调用 `qcc-mcp-setup` 技能完成配置。

### 3. pku-law — 中国法律宝典

北大法宝（PKU Law）MCP 服务器与法律技能集合，面向中国法律场景提供权威数据服务：

- **法规检索**：法律法规语义/关键词检索、法条定位与条文原文、引用真实性校验、法规时效性核验
- **案例检索**：案例语义/关键词检索、案号自动识别与标准化、裁判文书引用校验
- **文档关联**：为文本自动添加法规超链接，方便快速查阅与引用
- **技能**：`legal-chinese` 法律中文技能集合（法律推理、文书生成、案例检索等）

**安装与密钥配置**

```bash
claude plugin install pku-law
```

```json
{
  "env": {
    "PKU_LAW_API": "您的Key"
  }
}
```

密钥获取：https://mcp.pkulaw.com/console 。未配置时启动会话会提示调用 `pkulaw-mcp-setup` 技能完成配置。

### 4. advanced-search — 超级融合搜索

八引擎并行网络搜索编排技能：**WebSearch + Tavily + 百炼(Bailian) + 博查(Bocha) + 百度(Baidu) + 搜狗微信(WeChat) + Bing CN + Bing Int**，外加百度无 API 兜底。

- 多引擎并行发起、结果去重合并、**优雅降级**（任一引擎失败不影响整体）
- 按意图路由：深度研究、站点爬取、URL 提取等复杂任务
- 引擎由独立插件提供，按需安装并配置对应密钥：

| 引擎 | 依赖插件 | 环境变量 |
|------|---------|---------|
| Tavily | `tavily-search` | `TAVILY_API_KEY` |
| 百炼 Bailian | `aliyuncs-search` | `DASHSCOPE_API_KEY` |
| 博查 Bocha | `bocha-search` | `BOCHA_API_KEY` |
| 百度 Baidu | `baidu-search` | `BAIDU_API_KEY` |

WebSearch（内置）、搜狗微信 / Bing CN / Bing Int / 百度无 API 兜底为本地脚本引擎，无需 API Key；Bing Int 需代理（`BING_PROXY` 环境变量或 `--proxy` 参数）。

```bash
claude plugin install advanced-search
```

---

## 搜索 MCP 集合（search-plugins）

八个独立的搜索 / 检索 MCP 插件，可单独安装使用，也可作为 `advanced-search` 的底层引擎：

| 插件 | 能力 | 所需密钥 |
|------|------|---------|
| `context7` | 主流开源库/框架的最新官方文档与代码示例检索（5000+ 库） | `CONTEXT7_API_KEY` |
| `github-search` | 基于 grep.app 的 GitHub 代码搜索（函数定义、用法示例） | 无需密钥 |
| `firecrawl` | 网页抓取与爬取，网页/PDF/动态渲染页 → 干净 Markdown | `FIRECRAWL_API_KEY` |
| `tavily-search` | 面向 AI 优化的搜索 API，高质量结果 + 内容提取摘要 | `TAVILY_API_KEY` |
| `exa-search` | 面向 AI 的语义搜索，相似内容查找与网页内容提取 | `EXA_API_KEY` |
| `aliyuncs-search` | 阿里云百炼 WebSearch（通义千问生态联网搜索） | `DASHSCOPE_API_KEY` |
| `bocha-search` | 博查 AI Web 搜索：语义理解、时效筛选、富元数据 | `BOCHA_API_KEY` |
| `baidu-search` | 百度智能云千帆 Web 搜索（百家号、百度百科等中文内容） | `BAIDU_API_KEY` |

```bash
claude plugin install context7      # 示例：安装某个搜索插件
```

---

## 密钥配置汇总

所有插件密钥统一在 `~/.claude/settings.json` 的 `env` 字段中配置（部分插件也支持系统环境变量）：

```json
{
  "env": {
    "IFIND_API_KEY": "您的密钥",
    "QCC_API_KEY": "您的密钥",
    "PKU_LAW_API": "您的密钥",
    "TAVILY_API_KEY": "您的密钥",
    "CONTEXT7_API_KEY": "您的密钥",
    "EXA_API_KEY": "您的密钥",
    "FIRECRAWL_API_KEY": "您的密钥",
    "DASHSCOPE_API_KEY": "您的密钥",
    "BOCHA_API_KEY": "您的密钥",
    "BAIDU_API_KEY": "您的密钥"
  }
}
```

安装并配置密钥后，运行 `/mcp` 确认 MCP 服务器已连接，即可直接提问使用。

## 许可证

本仓库结构采用 MIT License。各插件使用各自的许可证。

---

**维护者：** [liantian-cn](https://github.com/liantian-cn)
