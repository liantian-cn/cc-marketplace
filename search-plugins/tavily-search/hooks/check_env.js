#!/usr/bin/env node
// check_env.js — SessionStart hook: check whether TAVILY_API_KEY is configured.
// If missing, inject a context message so Claude can offer to run the
// tavily-search-setup skill. Exits 0 either way (informational only).

if (process.env.TAVILY_API_KEY) {
  process.exit(0);
}

const output = {
  continue: true,
  suppressOutput: false,
  systemMessage:
    "⚠️ TAVILY_API_KEY 未配置：mcp__plugin_tavily-search_* 工具可能无法连接。若用户需要 Tavily 搜索，请调用 tavily-search-setup skill 引导用户配置。",
};

if (process.env.CLAUDE_HOOK_OUTPUT_FILE) {
  require("fs").writeFileSync(
    process.env.CLAUDE_HOOK_OUTPUT_FILE,
    JSON.stringify(output)
  );
} else {
  process.stdout.write(JSON.stringify(output));
}

process.exit(0);
