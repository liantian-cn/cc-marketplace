# Credit Monitoring

## When To Use

Use this workflow when the user needs credit monitoring through MCP tools. Confirm the subject name, unified social credit code, or person name before calling tools.

## Minimum Calls

- `mcp__qcc-company__get_company_registration_info`: company registration info.
- `mcp__qcc-company__get_change_records`: change records.
- `mcp__qcc-company__get_financial_data`: financial data.
- `mcp__qcc-risk__get_judgment_debtor_info`: judgment debtor info.
- `mcp__qcc-risk__get_business_exception`: business exception.

## Escalation Signals

- New court enforcement.
- Abnormal-operation entry.
- Penalty or tax arrears added since last review.

## Report Sections

- Monitoring period.
- Baseline comparison.
- New adverse events.
- Trend interpretation.
- Action recommendation.

## Notes

- Use MCP tools directly.
- Separate confirmed facts, records needing manual review, and risk conclusions.
- 
