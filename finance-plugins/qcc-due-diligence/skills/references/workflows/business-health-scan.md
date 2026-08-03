# Business Health Scan

## When To Use

Use this workflow when the user needs business health scan through MCP tools. Confirm the subject name, unified social credit code, or person name before calling tools.

## Minimum Calls

- `mcp__plugin_qcc-due-diligence_qcc-operation__get_recruitment_info`: recruitment info.
- `mcp__plugin_qcc-due-diligence_qcc-operation__get_bidding_info`: bidding info.
- `mcp__plugin_qcc-due-diligence_qcc-company__get_financial_data`: financial data.
- `mcp__plugin_qcc-due-diligence_qcc-operation__get_news_sentiment`: news sentiment.
- `mcp__plugin_qcc-due-diligence_qcc-risk__get_business_exception`: business exception.

## Escalation Signals

- Hiring or tender activity drops.
- Negative news appears.
- Tax or abnormal-operation records emerge.

## Report Sections

- Operating activity.
- Financial baseline.
- Public sentiment.
- Regulatory issues.
- Health rating.

## Notes

- Use MCP tools directly.
- Separate confirmed facts, records needing manual review, and risk conclusions.
- 
