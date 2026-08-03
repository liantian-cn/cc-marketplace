# Trade Finance Compliance

## When To Use

Use this workflow when the user needs trade finance compliance through MCP tools. Confirm the subject name, unified social credit code, or person name before calling tools.

## Minimum Calls

- `mcp__qcc-company__get_company_registration_info`: company registration info.
- `mcp__qcc-operation__get_import_export_credit`: import export credit.
- `mcp__qcc-operation__get_administrative_license`: administrative license.
- `mcp__qcc-operation__get_bidding_info`: bidding info.
- `mcp__qcc-risk__get_tax_violation`: tax violation.

## Escalation Signals

- Trade credit is weak.
- License or qualification is missing.
- Tax or penalty records affect transaction legitimacy.

## Report Sections

- Applicant identity.
- Trade credentials.
- Transaction reality.
- Compliance records.
- Financing control points.

## Notes

- Use MCP tools directly.
- Separate confirmed facts, records needing manual review, and risk conclusions.
- 
