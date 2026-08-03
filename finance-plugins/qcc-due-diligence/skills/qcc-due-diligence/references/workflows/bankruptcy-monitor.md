# Insolvency Monitoring

## When To Use

Use this workflow when the user needs insolvency monitoring through MCP tools. Confirm the subject name, unified social credit code, or person name before calling tools.

## Minimum Calls

- `mcp__plugin_qcc-due-diligence_qcc-risk__get_judgment_debtor_info`: judgment debtor info.
- `mcp__plugin_qcc-due-diligence_qcc-risk__get_dishonest_info`: dishonest info.
- `mcp__plugin_qcc-due-diligence_qcc-risk__get_terminated_cases`: terminated cases.
- `mcp__plugin_qcc-due-diligence_qcc-risk__get_bankruptcy_reorganization`: bankruptcy reorganization.
- `mcp__plugin_qcc-due-diligence_qcc-risk__get_liquidation_info`: liquidation info.

## Escalation Signals

- Terminal execution accumulates.
- Formal insolvency or liquidation appears.
- Management individual risk rises.

## Report Sections

- Early warning indicators.
- Formal procedures.
- Management signals.
- Recovery window.
- Recommended action.

## Notes

- Use MCP tools directly.
- Separate confirmed facts, records needing manual review, and risk conclusions.
- 
