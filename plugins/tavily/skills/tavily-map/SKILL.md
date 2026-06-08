---
name: tavily-map
description: |
  Discover and list all URLs on a website without extracting content, via Tavily. Use this skill when the user wants to find a specific page on a large site, list all URLs, see site structure, find where something is on a domain, or says "map the site", "find the URL for", "what pages are on", "list all pages", or "site structure". Faster than crawling — returns URLs only. Combine with extract for targeted content retrieval.
---

# Site URL Discovery

Discover URLs on a website without extracting content. Faster than crawling when you only need to know what pages exist.

## When to use

- You need to find a specific subpage on a large site
- You want a list of all URLs before deciding what to extract or crawl
- Step 3 in the workflow: search → extract → **map** → crawl → research

## How it works

Use the `tavily_map` MCP tool. Give it a URL — it returns the URLs it finds.

### Basic mapping

```
tavily_map(url="https://docs.example.com")
```

### With natural language filtering

```
tavily_map(
  url="https://docs.example.com",
  instructions="Find API docs and guides"
)
```

### Filter by path pattern

```
tavily_map(
  url="https://example.com",
  select_paths=["/blog/.*"],
  limit=500
)
```

### Deep mapping

```
tavily_map(
  url="https://example.com",
  max_depth=3,
  limit=200
)
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `url` | string | (required) | The starting URL to map |
| `max_depth` | integer | 1 | How many levels deep to discover (1-5) |
| `max_breadth` | integer | 20 | Max links to follow per page |
| `limit` | integer | 50 | Max URLs to discover |
| `instructions` | string | — | Natural language guidance for which URLs to prioritize |
| `select_paths` | array | — | Only return URLs matching these regex patterns |
| `select_domains` | array | — | Only return URLs on these domains |
| `allow_external` | boolean | true | Whether to include links to external sites |

## Map + Extract pattern

Use `tavily_map` to find the right page, then `tavily_extract` to get its content. This is often more efficient than crawling an entire site:

1. **Map**: `tavily_map(url="https://docs.example.com", instructions="authentication")` — discovers relevant URLs
2. **Extract**: `tavily_extract(urls=["https://docs.example.com/api/authentication"])` — pulls the content

## Tips

- **Map is URL discovery only** — no content is extracted. Use `tavily_extract` or `tavily_crawl` for content.
- **Map + Extract beats Crawl** when you only need a few specific pages from a large site.
- **Use `instructions`** for semantic filtering when path patterns alone aren't enough.
- **Start shallow** — `max_depth=1` is enough for most sites.

## See also

- [tavily-extract](../tavily-extract/SKILL.md) — extract content from URLs you discover
- [tavily-crawl](../tavily-crawl/SKILL.md) — bulk extract when you need many pages
