---
name: tavily-crawl
description: |
  Crawl websites and extract content from multiple pages via Tavily. Use this skill when the user wants to crawl a site, extract content from a docs section, bulk-download pages, or says "crawl", "get all the pages from", "extract everything under /docs", "bulk extract", or needs content from many pages on the same domain. Supports depth/breadth control, path filtering, and semantic instructions for focused crawling.
---

# Website Crawling

Crawl a website and extract content from multiple pages. Ideal for bulk content extraction from a site or documentation section.

## When to use

- You need content from many pages on a site (e.g., all pages under `/docs/`)
- You want to gather documentation or reference material
- Step 4 in the workflow: search → extract → map → **crawl** → research

## How it works

Use the `tavily_crawl` MCP tool. It starts from a URL and follows links, extracting content along the way.

### Basic crawl

```
tavily_crawl(url="https://docs.example.com")
```

### Deeper crawl with limits

```
tavily_crawl(
  url="https://docs.example.com",
  max_depth=2,
  limit=50
)
```

### Filter by path

```
tavily_crawl(
  url="https://example.com",
  select_paths=["/api/.*", "/guides/.*"]
)
```

### Semantic focus (with instructions)

```
tavily_crawl(
  url="https://docs.example.com",
  instructions="Find authentication and API key documentation"
)
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `url` | string | (required) | The starting URL for the crawl |
| `max_depth` | integer | 1 | How many levels deep to crawl (1-5) |
| `max_breadth` | integer | 20 | Max links to follow per page |
| `limit` | integer | 50 | Total pages to process before stopping |
| `instructions` | string | — | Natural language guidance for what content to focus on |
| `select_paths` | array | — | Only crawl URLs matching these regex patterns |
| `select_domains` | array | — | Only crawl URLs on these domains |
| `allow_external` | boolean | true | Whether to follow external links |
| `extract_depth` | string | `basic` | `basic` or `advanced` (for JS-heavy pages) |
| `format` | string | `markdown` | Output format: `markdown` or `text` |

## Crawl for context vs. full content

**For answering questions** (feeding results to an LLM):

Use `instructions` to focus on what matters. This returns relevant chunks instead of full pages — keeps context manageable.

```
tavily_crawl(
  url="https://docs.example.com",
  instructions="API authentication setup"
)
```

**For comprehensive extraction** (getting everything):

Omit `instructions` to get full page content. Combine with path filtering for precision.

```
tavily_crawl(
  url="https://docs.example.com",
  max_depth=2,
  select_paths=["/docs/.*"]
)
```

## Tips

- **Start conservative** — `max_depth=1`, `limit=20` — and scale up if needed.
- **Use `select_paths`** to focus on the section you actually need.
- **Use `tavily_map` first** to understand site structure before a full crawl.
- **Always set `limit`** to prevent unexpectedly large crawls.

## See also

- [tavily-map](../tavily-map/SKILL.md) — discover URLs before deciding to crawl
- [tavily-extract](../tavily-extract/SKILL.md) — extract individual pages you already know about
- [tavily-search](../tavily-search/SKILL.md) — find pages when you don't have a URL
