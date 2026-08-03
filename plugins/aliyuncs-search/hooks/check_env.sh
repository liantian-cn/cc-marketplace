#!/usr/bin/env bash
# SessionStart hook: check whether DASHSCOPE_API_KEY is configured.
# If missing, inject a context message so Claude can offer to run the
# aliyuncs-search-setup skill. Exits 0 either way (informational only).

set -euo pipefail

if [ -n "${DASHSCOPE_API_KEY:-}" ]; then
  exit 0
fi

OUTPUT='{"continue": true, "suppressOutput": false, "systemMessage": "⚠️ DASHSCOPE_API_KEY 未配置：mcp__plugin_aliyuncs-search_* 工具可能无法连接。若用户需要阿里云百炼搜索，请调用 aliyuncs-search-setup skill 引导用户配置。"}'

if [ -n "${CLAUDE_HOOK_OUTPUT_FILE:-}" ]; then
  printf '%s' "$OUTPUT" > "$CLAUDE_HOOK_OUTPUT_FILE"
else
  printf '%s' "$OUTPUT"
fi

exit 0
