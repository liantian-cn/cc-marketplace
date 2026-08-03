# Counterparty Risk Review

## When To Use

Use this workflow when the user needs counterparty risk review through MCP tools. Confirm the subject name, unified social credit code, or person name before calling tools.

## Minimum Calls

- `mcp__qcc-company__get_company_registration_info`: company registration info.
- `mcp__qcc-company__get_company_profile`: company profile.
- `mcp__qcc-operation__get_import_export_credit`: import export credit.
- `mcp__qcc-risk__get_judicial_documents`: judicial documents.
- `mcp__qcc-risk__get_dishonest_info`: dishonest info.

## Escalation Signals

- Weak trade credit.
- Material disputes or enforcement.
- Legal representative has negative personal records.

## Report Sections

- Counterparty identity.
- Trade and operating capacity.
- Risk records.
- People-linked concerns.
- Exposure limit suggestion.

## Notes

- Use MCP tools directly.
- Separate confirmed facts, records needing manual review, and risk conclusions.
- 
