#!/usr/bin/env bash
# SessionStart hook: check whether IFIND_API_KEY is configured.
# If missing, inject a context message so Claude can offer to run the
# ifind-mcp-setup skill. Exits 0 either way (informational only).

set -euo pipefail

if [ -n "${IFIND_API_KEY:-}" ]; then
  exit 0
fi

OUTPUT='{"continue": true, "suppressOutput": false, "systemMessage": "⚠️ IFIND_API_KEY 未配置：mcp__plugin_ifind-finance-data_* 工具可能无法连接。若用户需要同花顺金融数据，请调用 ifind-mcp-setup skill 引导用户访问 https://mcp.51ifind.com/ 获取密钥并配置。"}'

if [ -n "${CLAUDE_HOOK_OUTPUT_FILE:-}" ]; then
  printf '%s' "$OUTPUT" > "$CLAUDE_HOOK_OUTPUT_FILE"
else
  printf '%s' "$OUTPUT"
fi

exit 0
