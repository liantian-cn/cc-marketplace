#!/usr/bin/env bash
# SessionStart hook: check whether EXA_API_KEY is configured.
# If missing, inject a context message so Claude can offer to run the
# exa-search-setup skill. Exits 0 either way (informational only).

set -euo pipefail

if [ -n "${EXA_API_KEY:-}" ]; then
  exit 0
fi

OUTPUT='{"continue": true, "suppressOutput": false, "systemMessage": "⚠️ EXA_API_KEY 未配置：mcp__plugin_exa-search_* 工具可能无法连接。若用户需要 Exa 语义搜索，请调用 exa-search-setup skill 引导用户配置。"}'

if [ -n "${CLAUDE_HOOK_OUTPUT_FILE:-}" ]; then
  printf '%s' "$OUTPUT" > "$CLAUDE_HOOK_OUTPUT_FILE"
else
  printf '%s' "$OUTPUT"
fi

exit 0
