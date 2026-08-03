# KYB Verification

## When To Use

Use this workflow when the user needs kyb verification through MCP tools. Confirm the subject name, unified social credit code, or person name before calling tools.

## Minimum Calls

- `mcp__plugin_qcc-due-diligence_qcc-company__get_company_registration_info`: company registration info.
- `mcp__plugin_qcc-due-diligence_qcc-company__verify_company_accuracy`: verify company accuracy.
- `mcp__plugin_qcc-due-diligence_qcc-company__get_contact_info`: contact info.
- `mcp__plugin_qcc-due-diligence_qcc-company__get_shareholder_info`: shareholder info.
- `mcp__plugin_qcc-due-diligence_qcc-risk__get_business_exception`: business exception.

## Escalation Signals

- Name and credit code do not match.
- Ownership cannot be verified.
- Baseline risk records exist.

## Report Sections

- Entity identity.
- Two-factor verification.
- Ownership and control.
- Contact and tax data.
- Onboarding decision.

## Notes

- Use MCP tools directly.
- Separate confirmed facts, records needing manual review, and risk conclusions.
