# Equity Structure Review

## When To Use

Use this workflow when the user needs equity structure review through MCP tools. Confirm the subject name, unified social credit code, or person name before calling tools.

## Minimum Calls

- `mcp__plugin_qcc-due-diligence_qcc-company__get_shareholder_info`: shareholder info.
- `mcp__plugin_qcc-due-diligence_qcc-company__get_actual_controller`: actual controller.
- `mcp__plugin_qcc-due-diligence_qcc-company__get_beneficial_owners`: beneficial owners.
- `mcp__plugin_qcc-due-diligence_qcc-company__get_change_records`: change records.
- `mcp__plugin_qcc-due-diligence_qcc-risk__get_equity_pledge_info`: equity pledge info.

## Escalation Signals

- Frequent shareholder changes.
- Controller differs from expected owner.
- Pledges or freezes affect control.

## Report Sections

- Direct ownership.
- Control path.
- Beneficial owners.
- Historical changes.
- Control risk.

## Notes

- Use MCP tools directly.
- Separate confirmed facts, records needing manual review, and risk conclusions.
- 
