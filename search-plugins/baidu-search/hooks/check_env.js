#!/usr/bin/env node
// check_env.js — SessionStart hook: check whether BAIDU_API_KEY is configured.
// If missing, inject a context message so Claude can offer to run the
// baidu-search-setup skill. Exits 0 either way (informational only).

if (process.env.BAIDU_API_KEY) {
  process.exit(0);
}

const output = {
  continue: true,
  suppressOutput: false,
  systemMessage:
    "⚠️ BAIDU_API_KEY 未配置：mcp__plugin_baidu-search_* 工具可能无法连接。若用户需要百度搜索，请调用 baidu-search-setup skill 引导用户配置。",
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
