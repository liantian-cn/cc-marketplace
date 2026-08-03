---
name: aliyuncs-search-setup
description: "当 aliyuncs-search 插件已启用、MCP 服务器已配置，但当前会话的工具列表中看不到 aliyuncs-search 相关工具（MCP 连接失败，通常因 ~/.claude/settings.json 的 env 中缺少 DASHSCOPE_API_KEY）时触发本技能，引导用户获取并配置 DASHSCOPE_API_KEY。用户说「aliyuncs-search 不可用」「阿里云百炼搜索连不上」「配置 DASHSCOPE_API_KEY」「设置 DASHSCOPE_API_KEY」「获取 DASHSCOPE_API_KEY」「DASHSCOPE_API_KEY 未配置」等时也触发。"
version: "2026-08-03"
category: "环境配置"
mcp_servers:
  - aliyuncs-search
tags:
  - aliyuncs-search
  - DASHSCOPE_API_KEY
  - 阿里云百炼
  - DashScope
  - API Key
  - 环境变量
  - 环境配置
  - WebSearch
  - MCP 故障排查
---

# aliyuncs-search 环境配置

## SKILL 定位

本技能解决一类特定故障：**aliyuncs-search 插件已启用、`.mcp.json` 已配置，但当前会话的工具列表中没有 `mcp__plugin_aliyuncs-search_*` 工具**。这种"配置了但连不上"的状态，最常见的原因是 `~/.claude/settings.json` 的 `env` 字段中缺少 `DASHSCOPE_API_KEY`，导致 MCP 服务器的 `Authorization: Bearer ${DASHSCOPE_API_KEY}` 请求头无法构造、认证失败。

**何时触发本技能**：
- 当前可用工具中看不到 aliyuncs-search 的任何工具（MCP 连接失败）
- 用户提出配置、设置或获取 `DASHSCOPE_API_KEY` 的需求
- 用户反馈「阿里云百炼搜索不可用」「aliyuncs-search 连不上」

**不适用场景**：
- aliyuncs-search 工具已正常可见（无需任何配置）
- 故障原因是网络不通、服务端故障等（非凭据问题）——本技能只处理 API Key 缺失/错误的情况，其他原因仅提示排查方向

## 共享引用

- **获取指引**：仓库根目录 `INSTALLER.md` 的「1.2 DASHSCOPE_API_KEY（阿里云百炼搜索 API）」小节，及附录「阿里云 DashScope API Key」——包含完整获取步骤、网址与格式要求
- **配置脚本**：本目录 `scripts/set_dashscope_key.py`——把 `DASHSCOPE_API_KEY` 写入 `~/.claude/settings.json` 的 `env` 字段

## 工作流

按顺序执行，每步完成等待用户确认后再进入下一步。

### 步骤 1：确认故障模式

1. 确认插件已启用：`claude plugin list` 中 `aliyuncs-search@liantian-cc-market` 存在且 enabled
2. 确认 MCP 已配置：插件目录 `.mcp.json` 中存在 `aliyuncs-search` 条目（type: http，url: `https://dashscope.aliyuncs.com/api/v1/mcps/WebSearch/mcp`）
3. 确认当前会话工具列表中没有 `mcp__plugin_aliyuncs-search_*` 工具
4. 读取 `~/.claude/settings.json`，检查 `env` 字段中是否已有 `DASHSCOPE_API_KEY`

- **已有 key →** 说明故障不是凭据缺失，提示用户其他排查方向（网络能否访问 `dashscope.aliyuncs.com`、key 是否失效、服务是否开通），结束本技能
- **无 key →** 进入步骤 2

### 步骤 2：引导用户获取 API Key（Part 1）

向用户展示获取指引（内容取自 `INSTALLER.md` 1.2 小节，无需让用户自行阅读）：

> **获取 DASHSCOPE_API_KEY：**
>
> 1. 访问 https://bailian.console.aliyun.com/cn-beijing?tab=app#/mcp-market/detail/WebSearch
> 2. 使用支付宝扫码登录
> 3. 点击「立即开通」开通百炼服务
> 4. 访问 https://bailian.console.aliyun.com/cn-beijing?tab=app#/api-key
> 5. 创建 API Key 并复制
> 6. 💡 每月有免费额度
>
> **请输入你的 DASHSCOPE_API_KEY（应以 `sk-` 开头）：**

等待用户输入。若用户暂无 key 或表示跳过，尊重用户意愿，不强制继续。

### 步骤 3：配置 API Key（Part 2）

用脚本写入，脚本只接受一个参数——API Key 的值：

```bash
python set_dashscope_key.py <用户输入的值>
```

（脚本位于本技能 `scripts/` 目录，先定位到其路径再执行）

- **成功 →** 报告 "✅ DASHSCOPE_API_KEY 已写入 ~/.claude/settings.json"，进入步骤 4
- **失败 →** 报告错误信息（如 settings.json 不是合法 JSON），提示用户修复后重试

验证格式：确认用户输入以 `sk-` 开头，否则警告 "⚠️ DASHSCOPE_API_KEY 通常以 `sk-` 开头，你输入的值可能不正确。是否继续？" 等待用户确认。

### 步骤 4：验证生效

1. 告知用户：环境变量在会话启动时读取，**需重启 Claude Code**（或运行 `/mcp` 重新连接）后生效，当前会话无法热加载
2. 重启后确认：可用工具中出现 `mcp__plugin_aliyuncs-search_*` 工具
3. 若重启后仍不可用，按步骤 1 的排查方向继续（网络、key 有效性、服务开通状态）

## 输出模板

配置完成后按以下结构确认：

```
## ✅ aliyuncs-search 环境配置完成

**配置项**：DASHSCOPE_API_KEY（阿里云百炼搜索）
**写入位置**：~/.claude/settings.json → env
**下一步**：重启 Claude Code（或 /mcp 重新连接）后，工具列表中应出现 mcp__plugin_aliyuncs-search_* 工具
```

## 参数

| 参数 | 说明 | 可选值 |
|---|---|---|
| API Key 值 | 用户提供的 DASHSCOPE_API_KEY | 以 `sk-` 开头的字符串；用户可拒绝提供（跳过） |

## 边界与免责

1. **脚本行为**：仅修改 `~/.claude/settings.json` 的 `env` 字段，保留文件其他内容；文件或字段缺失时自动补齐；不打印 key 值
2. **生效时机**：env 变更在下次会话启动时生效，当前会话的 MCP 连接无法热加载
3. **故障范围**：本技能只处理 DASHSCOPE_API_KEY 缺失导致的 MCP 连接失败；网络不通、服务端故障、key 失效等问题仅提示排查方向
4. **凭据安全**：DASHSCOPE_API_KEY 是敏感凭据，提醒用户不要将其提交到 git、粘贴到公开渠道或日志
