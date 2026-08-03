#!/usr/bin/env bash
# SessionStart hook: check whether PKU-LAW-API is configured.
# If missing, inject a context message so Claude can offer to run the
# pkulaw-mcp-setup skill. Exits 0 either way (informational only).

set -euo pipefail

# PKU-LAW-API contains a dash, so it cannot be referenced as ${PKU-LAW-API}
# (not a valid shell identifier) — read it via printenv instead.
if [ -n "$(printenv 'PKU-LAW-API' 2>/dev/null || true)" ]; then
  exit 0
fi

OUTPUT='{"continue": true, "suppressOutput": false, "systemMessage": "⚠️ PKU-LAW-API 未配置：mcp__plugin_pku-law_* 工具可能无法连接。若用户需要北大法宝法律检索，请调用 pkulaw-mcp-setup skill 引导用户访问 https://mcp.pkulaw.com/console 获取密钥并配置。"}'

if [ -n "${CLAUDE_HOOK_OUTPUT_FILE:-}" ]; then
  printf '%s' "$OUTPUT" > "$CLAUDE_HOOK_OUTPUT_FILE"
else
  printf '%s' "$OUTPUT"
fi

exit 0
