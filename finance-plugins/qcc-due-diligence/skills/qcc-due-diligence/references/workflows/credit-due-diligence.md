# Credit Due Diligence Report

## When To Use

Use this workflow when the user needs credit due diligence report through MCP tools. Confirm the subject name, unified social credit code, or person name before calling tools.

## Minimum Calls

- `mcp__plugin_qcc-due-diligence_qcc-company__get_company_registration_info`: company registration info.
- `mcp__plugin_qcc-due-diligence_qcc-company__get_shareholder_info`: shareholder info.
- `mcp__plugin_qcc-due-diligence_qcc-company__get_actual_controller`: actual controller.
- `mcp__plugin_qcc-due-diligence_qcc-company__get_financial_data`: financial data.
- `mcp__plugin_qcc-due-diligence_qcc-risk__get_judicial_documents`: judicial documents.
- `mcp__plugin_qcc-due-diligence_qcc-risk__get_dishonest_info`: dishonest info.

## Escalation Signals

- New enforcement or dishonesty records.
- Controller ownership is opaque or recently changed.
- Financial indicators conflict with annual reports.

## Report Sections

- Subject and identity.
- Ownership and control.
- Operations and financials.
- Legal and negative records.
- Credit recommendation.

## Notes

- Use MCP tools directly.
- Separate confirmed facts, records needing manual review, and risk conclusions.
- 
