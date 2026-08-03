---
name: baidu-search-setup
description: "Use when mcp__plugin_baidu-search_* tools are unavailable or report a missing/invalid API key. Guides the user to obtain and configure the Baidu Qianfan API key."
version: "2026-08-03"
---

# baidu-search 环境配置

## 定位

当会话工具列表中缺少 `mcp__plugin_baidu-search_*` 工具（MCP 连接失败）时，引导用户获取百度智能云千帆 API Key，并用本技能 `scripts/set_baidu_key.py` 完成配置。

## 工作流

1. **确认故障**：仅检查当前会话的工具列表，确认没有 baidu-search 相关工具（不检查任何环境变量）。
2. **获取 API Key**：引导用户访问 https://console.bce.baidu.com/qianfan 创建并复制 API Key（💡 每天 50 次免费额度），等待用户输入；用户拒绝或暂无 key 则尊重其意愿结束。
3. **配置**：运行 `python scripts/set_baidu_key.py <用户提供的 key>`（脚本位于本技能 `scripts/` 目录，先定位再执行）。仅依据脚本返回值判断是否设置成功：返回码 0 表示成功，继续下一步；非 0 则报告脚本错误信息，提示修复后重试。
4. **验证**：告知用户需重启 Claude Code（或 `/mcp` 重新连接）后生效；重启后确认工具列表出现 `mcp__plugin_baidu-search_*` 工具。仍不可用则提示排查网络、key 有效性。

## 输出模板

```
## ✅ baidu-search 环境配置完成
**下一步**：重启 Claude Code（或 /mcp 重新连接）后，工具列表中应出现 mcp__plugin_baidu-search_* 工具
```

## 边界与免责

- 本技能只处理 API Key 缺失导致的 MCP 连接失败；网络不通、服务端故障、key 失效等问题仅提示排查方向。
- 不读取、不展示 `~/.claude/settings.json` 的内容，避免敏感凭据泄露。
- API Key 是敏感凭据，提醒用户不要提交到 git 或公开渠道。
