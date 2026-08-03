---
name: ifind-mcp-setup
description: "Use when mcp__plugin_ifind-finance-data_* tools are unavailable or report a missing/invalid API key or validation errors. Guides the user to obtain the iFinD MCP key from https://mcp.51ifind.com/ and configure IFIND_API_KEY."
version: "2026-08-03"
---

# ifind-finance-data 环境配置

## 定位

当会话工具列表中缺少 `mcp__plugin_ifind-finance-data_*` 工具（MCP 连接失败），或调用 iFinD 金融数据工具时返回验证/鉴权报错（如密钥缺失、无效、权限不足）时，引导用户访问同花顺 MCP 官网获取 API Key，并用本技能 `scripts/set_ifind_key.py` 完成配置。

## 工作流

1. **确认故障**：仅检查当前会话的工具列表与调用报错，确认 ifind-finance-data 相关工具不可用或验证失败（不检查任何环境变量）。
2. **获取 API Key**：引导用户访问 https://mcp.51ifind.com/ → 个人中心 → 密钥，创建并复制 API Key（💡 免费版有调用限额，可升级个人版/企业版），等待用户输入；用户拒绝或暂无 key 则尊重其意愿结束。
3. **配置**：运行 `python scripts/set_ifind_key.py <用户提供的 key>`（脚本位于本技能 `scripts/` 目录，先定位再执行）。仅依据脚本返回值判断是否设置成功：返回码 0 表示成功，继续下一步；非 0 则报告脚本错误信息，提示修复后重试。
4. **验证**：告知用户需重启 Claude Code（或 `/mcp` 重新连接）后生效；重启后确认工具列表出现 `mcp__plugin_ifind-finance-data_*` 工具。仍不可用则提示排查网络、key 有效性、官网服务开通状态。

## 输出模板

```
## ✅ ifind-finance-data 环境配置完成
**下一步**：重启 Claude Code（或 /mcp 重新连接）后，工具列表中应出现 mcp__plugin_ifind-finance-data_* 工具
```

## 边界与免责

- 本技能只处理 API Key 缺失/无效导致的 MCP 连接失败或验证报错；网络不通、服务端故障、并发超限等问题仅提示排查方向。
- 不读取、不展示 `~/.claude/settings.json` 的内容，避免敏感凭据泄露。
- API Key 是敏感凭据，提醒用户不要提交到 git 或公开渠道。
