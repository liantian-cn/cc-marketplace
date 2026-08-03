# Guarantor Check

## When To Use

Use this workflow when the user needs guarantor check through MCP tools. Confirm the subject name, unified social credit code, or person name before calling tools.

## Minimum Calls

- `mcp__plugin_qcc-due-diligence_qcc-company__get_company_registration_info`: company registration info.
- `mcp__plugin_qcc-due-diligence_qcc-company__get_financial_data`: financial data.
- `mcp__plugin_qcc-due-diligence_qcc-risk__get_guarantee_info`: guarantee info.
- `get_chattel_mortgage_info`: chattel mortgage info.
- `mcp__plugin_qcc-due-diligence_qcc-risk__get_judgment_debtor_info`: judgment debtor info.

## Escalation Signals

- Existing secured obligations are high.
- Guarantor has enforcement pressure.
- Asset pledges weaken recovery value.

## Report Sections

- Guarantor identity.
- Capacity indicators.
- Existing guarantees.
- Asset encumbrance.
- Guarantee reliability.

## Notes

- Use MCP tools directly.
- Separate confirmed facts, records needing manual review, and risk conclusions.
- 
