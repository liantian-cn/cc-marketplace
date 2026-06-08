---
name: tavily-search
description: |
  Search the web with AI-optimized results via Tavily. Use this skill when the user wants to search the web, find articles, look up information, get recent news, discover sources, or says "search for", "find me", "look up", "what's the latest on", "find articles about", or needs current information from the internet. Returns relevant results with content snippets and scores — optimized for AI consumption. Supports domain filtering, time ranges, and multiple search depths.
---

# Web Search

Search the web and get AI-optimized results with content snippets and relevance scores.

## When to use

- You need to find information on any topic
- You don't have a specific URL yet
- First step in the workflow: **search** → extract → map → crawl → research

## How it works

Use the `tavily_search` MCP tool. The only required parameter is `query` — everything else is optional for fine-tuning.

### Basic search

```
tavily_search(query="your search query")
```

### With options

```
tavily_search(
  query="quantum computing breakthroughs",
  max_results=10,
  search_depth="advanced",
  time_range="month"
)
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `query` | string | (required) | Your search query — keep it concise (under 400 characters) |
| `max_results` | integer | 5 | Number of results to return (0-20) |
| `search_depth` | string | `basic` | Depth: `ultra-fast`, `fast`, `basic`, `advanced` |
| `topic` | string | `general` | Always `general` |
| `time_range` | string | — | Limit to `day`, `week`, `month`, or `year` |
| `start_date` | string | — | Only results after this date (YYYY-MM-DD) |
| `end_date` | string | — | Only results before this date (YYYY-MM-DD) |
| `include_domains` | array | — | Only include these domains (e.g., `["sec.gov", "reuters.com"]`) |
| `exclude_domains` | array | — | Exclude these domains |
| `country` | string | — | Boost results from a country (full name, e.g., "United States") |
| `include_raw_content` | boolean | false | Include the full page content in results |
| `include_images` | boolean | false | Include image results |
| `include_image_descriptions` | boolean | false | Include AI descriptions of images |

## Search depth

| Depth | Speed | Relevance | Best for |
|-------|-------|-----------|----------|
| `ultra-fast` | Fastest | Lower | Quick lookups, real-time chat |
| `fast` | Fast | Good | When you need speed but also decent relevance |
| `basic` | Medium | High | General-purpose searches (default) |
| `advanced` | Slower | Highest | Precision queries, specific facts, thorough research |

## Tips

- **Keep queries concise** — think search keywords, not full sentences. The API works best with focused queries.
- **Break complex questions into sub-queries** — search for each aspect separately for better coverage.
- **Use `include_raw_content`** when you need the full page text instead of just a snippet (saves a separate extract call).
- **Use `include_domains`** to focus on trusted or specific sources.
- **Use `time_range`** when you need recent information — especially for news, events, or time-sensitive facts.
- **Use `search_depth=advanced`** when you need the most thorough results for complex or precise questions.

## See also

- [tavily-extract](../tavily-extract/SKILL.md) — extract content from specific URLs
- [tavily-research](../tavily-research/SKILL.md) — comprehensive multi-source research
