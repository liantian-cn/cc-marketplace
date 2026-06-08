---
name: tavily-research
description: |
  Conduct comprehensive AI-powered research with multiple sources via Tavily. Use this skill when the user wants deep research, a detailed report, a comparison, market analysis, or says "research", "investigate", "analyze in depth", "compare X vs Y", "what does the market look like for", or needs multi-source synthesis. Returns a structured report grounded in web sources. Takes 30-120 seconds. For quick fact-finding, use tavily-search instead.
---

# Deep Research

AI-powered research that gathers multiple sources, analyzes them, and produces a comprehensive report. Takes 30-120 seconds to complete.

## When to use

- You need comprehensive, multi-source analysis
- The user wants a comparison, market report, or in-depth review
- Quick searches aren't enough — you need synthesis across multiple sources
- Step 5 in the workflow: search → extract → map → crawl → **research**

## How it works

Use the `tavily_research` MCP tool. It's the simplest of all the tools — just describe what you need to research.

### Basic research

```
tavily_research(input="competitive landscape of AI code assistants")
```

### Pro model for comprehensive analysis

```
tavily_research(
  input="electric vehicle market trends and major players in 2025",
  model="pro"
)
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `input` | string | (required) | A comprehensive description of what to research |
| `model` | string | `auto` | Research depth: `mini`, `pro`, or `auto` |

## Model selection

| Model | Use for | Typical time |
|-------|---------|-------------|
| `mini` | Single-topic, focused research | ~30s |
| `pro` | Comprehensive multi-angle analysis, comparisons | ~60-120s |
| `auto` | Let the API decide based on complexity | Varies |

**Rule of thumb:**
- "What does X do?" or "Tell me about Y" → `mini` is usually enough
- "Compare X vs Y vs Z" or "Analyze the market for..." → `pro` for thorough coverage
- When unsure → `auto` (the API chooses)

## Tips

- **Research takes time** — 30 seconds at minimum, up to 2 minutes for complex topics. This is expected.
- **Be specific in your input** — the more context you provide, the better the research. Include what angles matter, what kind of information you need, and how you plan to use it.
- **Use `model=pro`** for complex comparisons or multi-faceted topics where thoroughness matters.
- **For quick facts**, use `tavily_search` instead — research is for deep synthesis, not quick lookups.

## See also

- [tavily-search](../tavily-search/SKILL.md) — quick web search for simple lookups
- [tavily-crawl](../tavily-crawl/SKILL.md) — bulk extract from a site for your own analysis
