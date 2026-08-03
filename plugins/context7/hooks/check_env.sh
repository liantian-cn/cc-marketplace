#!/usr/bin/env bash
# SessionStart hook: check whether CONTEXT7_API_KEY is configured.
# If missing, inject a context message so Claude can offer to run the
# context7-setup skill. Exits 0 either way (informational only).

set -euo pipefail

if [ -n "${CONTEXT7_API_KEY:-}" ]; then
  exit 0
fi

OUTPUT='{"continue": true, "suppressOutput": false, "systemMessage": "⚠️ CONTEXT7_API_KEY 未配置：mcp__plugin_context7_* 工具可能无法连接。若用户需要 Context7 文档检索，请调用 context7-setup skill 引导用户配置。"}'

if [ -n "${CLAUDE_HOOK_OUTPUT_FILE:-}" ]; then
  printf '%s' "$OUTPUT" > "$CLAUDE_HOOK_OUTPUT_FILE"
else
  printf '%s' "$OUTPUT"
fi

exit 0
