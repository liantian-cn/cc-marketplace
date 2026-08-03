# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Claude Code plugin marketplace — a curated registry of plugins for enterprise due diligence and compliance risk control (企业尽职调查与合规风控).

**Primary repo**: `https://github.com/liantian-cn/cc-marketplace` (source of truth)  
**Mirror**: `https://gitee.com/liantian-cn/cc-marketplace` (auto-syncs from GitHub; README uses Gitee URLs for faster access in China)  
**Marketplace name**: `liantian-cc-market`

## Commands

There is no build step, test suite, or linter in this repo. It is a pure collection of plugin directories.

**Local validation** (matching CI):
```bash
# Validate marketplace.json structure
python -c "
import json
with open('.claude-plugin/marketplace.json') as f:
    data = json.load(f)
assert 'name' in data and 'owner' in data and 'plugins' in data
print(f'OK: {len(data[\"plugins\"])} plugin(s)')
"

# Check each bundled plugin has plugin.json and count skills
for d in search-plugins/*/ finance-plugins/*/ production-plugins/*/ fusion-plugins/*/; do
  name=$(basename "$d")
  echo "--- $name ---"
  [ -f "$d/.claude-plugin/plugin.json" ] && echo "  plugin.json: OK" || echo "  MISSING plugin.json"
  [ -d "$d/skills" ] && echo "  Skills: $(find "$d/skills" -name 'SKILL.md' | wc -l)"
done
```

**GitHub operations** — use `gh` CLI:
```bash
gh repo view liantian-cn/cc-marketplace   # repo info
gh pr list                                     # open PRs
gh pr create --title "..." --body "..."        # create PR
```

## Architecture

### Marketplace Registration

`.claude-plugin/marketplace.json` is the single source of truth for which plugins are included. To add a new plugin:

1. Create the plugin directory under one of the five taxonomy directories: `plugins/<name>/` (default business/utility plugins), `search-plugins/<name>/` (internet search & retrieval plugins), `finance-plugins/<name>/` (financial data & risk control plugins), `production-plugins/<name>/` (production-grade business tools), or `fusion-plugins/<name>/` (document processing & format conversion plugins)
2. Add a `.claude-plugin/plugin.json` inside it
3. Add an entry to `marketplace.json` → `plugins` array with: `name`, `source` (relative path `./plugins/<name>`, `./search-plugins/<name>`, `./finance-plugins/<name>`, `./production-plugins/<name>`, or `./fusion-plugins/<name>`), `description`, `version`, `author`, `license`, `homepage`, `repository`, `category`

### Plugin Structure

Plugins live in one of five top-level directories: `plugins/` (default business/utility plugins), `search-plugins/` (internet search & retrieval plugins), `finance-plugins/` (financial data & risk control plugins), `production-plugins/` (production-grade business tools, e.g. `advanced-search`), and `fusion-plugins/` (document processing & format conversion plugins, e.g. `office-docs`, `markitdown`, `guizang-ppt`). All follow the same structure:

```
<plugins|search-plugins|finance-plugins|production-plugins|fusion-plugins>/<plugin-name>/
├── .claude-plugin/
│   └── plugin.json       # name, version, description, author, license（不含 keywords）
├── .mcp.json             # MCP servers (optional — only if plugin needs MCP tools)
├── skills/               # skills auto-discovered from SKILL.md files
│   └── <skill-name>/
│       ├── SKILL.md      # YAML frontmatter + markdown body
│       ├── mcp-tools-map.md     # maps MCP tool names → cache file names
│       └── mcp-cache-guide.md   # MCP caching convention
└── README.md
```

> **不要**在 `plugin.json`（或 marketplace 条目）中添加 `keywords` 字段——本市场不需要搜索引擎优化（SEO），插件靠 `description` 自然匹配即可。新建/修改插件时不要写 keywords。

### MCP Configuration Pattern

`.mcp.json` defines MCP servers that plugins depend on. All servers use HTTP transport with `Authorization: Bearer ${QCC_API_KEY}` — the token references a variable from `~/.claude/settings.json` `env` field (NOT an OS environment variable).

### Skill Conventions

Every `SKILL.md` uses YAML frontmatter with these fields:
- `name`, `description` — auto-discovery triggers
- `version` — date-based (`YYYY-MM-DD`)
- `category` — grouping label
- `mcp_servers` — array of required MCP server names
- `tags` — keyword array for matching
- `model` — optional model override (leave unset to use the session default)

Skills follow a consistent body structure: **定位** (purpose), **共享引用** (shared references), **工作流** (workflow), **输出模板** (output template), **参数** (parameters), **边界与免责** (boundaries & disclaimer).

### MCP Caching Pattern

All qcc-due-diligence skills use a consistent caching convention:
- Cache directory: `./[公司全名]MCP查询结果/`
- Before any MCP call, check if the cache file exists; if so, read it and skip the call
- Cache files include query timestamp, data source, and query subject headers
- Same-day cache reuse; delete the cache file to force refresh

### Skill Dependency Graph

`office-docs` (fusion-plugins) is the base document-processing toolset (PDF / Word / PPT / Excel). Web search orchestration is handled by `advanced-search` (production-plugins), which composes the MCP engine plugins under `search-plugins/` (Tavily、百炼、博查、百度等) and degrades gracefully to local scripts when engines are unavailable. Business skills in `qcc-due-diligence` assume the finance and search plugin environments are already set up.

## CI

`.github/workflows/validate.yml` runs on push/PR to `main`:
1. Validates `.claude-plugin/marketplace.json` is valid JSON with required fields
2. Iterates `plugins/*/`, `search-plugins/*/`, and `finance-plugins/*/` directories, checks each has `plugin.json`, counts skills

## Plugins

| Plugin | Directory | Skills | Purpose |
|--------|-----------|--------|---------|
| `office-docs` | `fusion-plugins/` | 4 | Office document processing: PDF / Word(docx) / PowerPoint(pptx) / Excel(xlsx) creation, editing, analysis |
| `guizang-ppt` | `fusion-plugins/` | 1 | Web PPT generation (歸藏 guizang-ppt-skill, single-file horizontal-swipe HTML) |
| `markitdown` | `fusion-plugins/` | 0 | MarkItDown MCP: convert PDF/Word/PPT/Excel/HTML/image → Markdown |
| `advanced-search` | `production-plugins/` | 1 | Eight-engine parallel web search orchestration |
| `qcc-due-diligence` | `finance-plugins/` | 12 | Enterprise due diligence via QCC database (KYB, UBO, credit, litigation, etc.) |
| `ifind-finance-data` | `finance-plugins/` | — | iFinD financial data queries (stocks, funds, macro, industry, news) |
| 8 search plugins | `search-plugins/` | 1 each | Web search / doc retrieval MCP servers: Tavily, Exa, Context7, Firecrawl, GitHub, 百炼, 博查, 百度 |

## Versioning

- Use [Semantic Versioning](https://semver.org/): `MAJOR.MINOR.PATCH`
- **Any modification** (no matter how small — typo fixes, description updates, dependency changes, etc.): increment the **PATCH** version by 1 (the third digit: X.Y.Z → X.Y.Z+1)
- Only update MINOR or MAJOR for breaking changes or significant feature additions, per semver convention
- Update the version in **both** locations:
  1. `plugins/<name>/.claude-plugin/plugin.json` (or `search-plugins/<name>/...`, `finance-plugins/<name>/...` for grouped plugins) — `version` field
  2. `.claude-plugin/marketplace.json` — corresponding plugin entry's `version` field and metadata `version` field

## Repository Operations

When working in this repo, follow these commit conventions:
- Before modifying a file with uncommitted changes, create a backup commit first: `chore: backup before edit [filename]`
- Commit each modified file separately with both title and message
- Use `gh` CLI for all GitHub interactions (PRs, issues, repo queries)
