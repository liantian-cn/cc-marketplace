# UBO Screening

## When To Use

Use this workflow when the user needs ubo screening through MCP tools. Confirm the subject name, unified social credit code, or person name before calling tools.

## Minimum Calls

- `mcp__qcc-company__get_beneficial_owners`: beneficial owners.
- `mcp__qcc-company__get_actual_controller`: actual controller.
- `mcp__qcc-company__get_shareholder_info`: shareholder info.
- `mcp__qcc-executive__get_executive_positions`: executive positions.
- `mcp__qcc-executive__get_executive_dishonest`: executive dishonest.

## Escalation Signals

- Beneficial owner cannot be reconciled.
- Natural person has negative records.
- Related companies create hidden exposure.

## Report Sections

- UBO candidates.
- Control rationale.
- Individual background.
- Related entities.
- Clearance decision.

## Notes

- Use MCP tools directly.
- Separate confirmed facts, records needing manual review, and risk conclusions.
- 
