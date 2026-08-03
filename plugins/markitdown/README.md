# markitdown

微软 MarkItDown MCP 服务器：将 PDF、Word、PPT、Excel、HTML、图片（OCR）等文件转换为 Markdown 格式，供 LLM 进一步处理。

## 安装

```bash
/plugin marketplace add liantian-cn/cc-marketplace
/plugin install markitdown
```

## 使用

无需环境变量（需要本机安装 `uvx`，来自 [uv](https://docs.astral.sh/uv/)）。安装后运行 `/mcp` 确认 `markitdown` 已连接，然后让 Claude 将本地文件转换为 Markdown 即可。
