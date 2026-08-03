# Executive Background Check

## When To Use

Use this workflow when the user needs executive background check through MCP tools. Confirm the subject name, unified social credit code, or person name before calling tools.

## Minimum Calls

- `mcp__plugin_qcc-due-diligence_qcc-company__get_key_personnel`: key personnel.
- `mcp__plugin_qcc-due-diligence_qcc-executive__get_executive_positions`: executive positions.
- `mcp__plugin_qcc-due-diligence_qcc-executive__get_executive_dishonest`: executive dishonest.
- `mcp__plugin_qcc-due-diligence_qcc-executive__get_executive_judgment_debtor`: executive judgment debtor.
- `mcp__plugin_qcc-due-diligence_qcc-executive__get_executive_controlled_companies`: executive controlled companies.

## Escalation Signals

- Executive has enforcement or dishonesty records.
- Many controlled or related companies.
- Role history conflicts with user statement.

## Report Sections

- Identity and role.
- Current positions.
- Negative records.
- Controlled entities.
- Governance concern.

## Notes

- Use MCP tools directly.
- Separate confirmed facts, records needing manual review, and risk conclusions.
- 
