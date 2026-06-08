---
name: tavily-extract
description: |
  Extract clean content from web pages via Tavily. Use this skill when the user has one or more URLs and wants their content, says "extract", "grab the content from", "pull the text from", "get the page at", "read this webpage", or needs clean, readable text from web pages. Handles JavaScript-rendered pages and returns AI-friendly markdown. Can process up to 20 URLs in a single call.
---

# Web Page Extraction

Extract clean, readable content from one or more URLs. Handles JavaScript-heavy pages.

## When to use

- You have a specific URL and want its content
- You need text from a JavaScript-rendered page
- Step 2 in the workflow: search → **extract** → map → crawl → research

## How it works

Use the `tavily_extract` MCP tool. Pass one or more URLs — get back clean markdown or text.

### Single URL

```
tavily_extract(urls=["https://example.com/article"])
```

### Multiple URLs

```
tavily_extract(urls=["https://example.com/page1", "https://example.com/page2"])
```

### Advanced extraction (JS-heavy pages)

```
tavily_extract(
  urls=["https://app.example.com"],
  extract_depth="advanced"
)
```

### Query-focused extraction

```
tavily_extract(
  urls=["https://example.com/docs"],
  query="authentication API"
)
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `urls` | array | (required) | List of URLs to extract (max 20) |
| `extract_depth` | string | `basic` | `basic` for simple pages, `advanced` for JS-rendered SPAs and dynamic content |
| `format` | string | `markdown` | Output format: `markdown` or `text` |
| `include_images` | boolean | false | Include image URLs from the page |
| `query` | string | — | Re-rank and prioritize content relevant to this query |

## Extract depth

| Depth | When to use |
|-------|-------------|
| `basic` | Simple pages, fast — try this first |
| `advanced` | JS-rendered SPAs, dynamic content, pages with tables |

## Tips

- **Max 20 URLs per call** — batch larger lists into multiple calls.
- **Try `basic` first**, fall back to `advanced` if content is missing or incomplete.
- **Use `query`** to focus extraction on the most relevant parts of a long page.
- **If search results already include full content** (via `include_raw_content` in tavily-search), you may not need to extract separately.

## See also

- [tavily-search](../tavily-search/SKILL.md) — find pages when you don't have a URL
- [tavily-crawl](../tavily-crawl/SKILL.md) — extract content from many pages on a site
