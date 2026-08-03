#!/usr/bin/env bash
# SessionStart hook: check whether QCC_API_KEY is configured.
# If missing, inject a context message so Claude can offer to run the
# qcc-mcp-setup skill. Exits 0 either way (informational only).

set -euo pipefail

if [ -n "${QCC_API_KEY:-}" ]; then
  exit 0
fi

OUTPUT='{"continue": true, "suppressOutput": false, "systemMessage": "⚠️ QCC_API_KEY 未配置：mcp__plugin_qcc-due-diligence_* 工具可能无法连接。若用户需要企查查尽调数据，请调用 qcc-mcp-setup skill 引导用户访问 https://agent.qcc.com/ 获取密钥并配置。"}'

if [ -n "${CLAUDE_HOOK_OUTPUT_FILE:-}" ]; then
  printf '%s' "$OUTPUT" > "$CLAUDE_HOOK_OUTPUT_FILE"
else
  printf '%s' "$OUTPUT"
fi

exit 0
