# Tavily Web Search

Search, extract, crawl, and research the web — powered by Tavily MCP. AI-optimized results for any information-gathering task.

> Adapted from [tavily-ai/skills](https://github.com/tavily-ai/skills) (MIT License). Modified to use Tavily MCP instead of the Tavily CLI.

## Setup

This plugin includes a pre-configured `.mcp.json`. All you need is a Tavily API key:

1. Get an API key at [tavily.com](https://tavily.com)
2. Set it in your Claude Code settings as `TAVILY_API_KEY`

The MCP server connects automatically — no installation, no CLI, no login commands.

## Available Skills

| Skill | What it does |
|-------|-------------|
| **[tavily-search](skills/tavily-search/SKILL.md)** | Search the web — find articles, news, and information on any topic. |
| **[tavily-extract](skills/tavily-extract/SKILL.md)** | Read a web page — extract clean, readable content from any URL. |
| **[tavily-crawl](skills/tavily-crawl/SKILL.md)** | Crawl a site — bulk extract content from multiple pages (e.g., all docs). |
| **[tavily-map](skills/tavily-map/SKILL.md)** | Discover URLs — list all pages on a site without extracting content. |
| **[tavily-research](skills/tavily-research/SKILL.md)** | Deep research — multi-source analysis with comprehensive reports. |

## Workflow

Start simple, escalate when needed:

1. **Search** — Find pages on a topic → `tavily_search`
2. **Extract** — Read a specific page you found → `tavily_extract`
3. **Map** — Discover URLs on a large site → `tavily_map`
4. **Crawl** — Bulk extract a site section → `tavily_crawl`
5. **Research** — Multi-source deep analysis → `tavily_research`
