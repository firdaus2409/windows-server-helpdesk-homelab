# Offboard a leaver

**Audience:** IT support (internal knowledge base)

**Trigger:** HR confirms the employee's last day

## Steps

1. In ADUC, right-click the user > Disable Account.
2. Right-click > Reset Password and set a long random password.
3. Properties > Member Of: remove all department groups (Domain Users stays, as it's the primary group).
4. Properties > General > Description: "Disabled [date], left company, [ticket number]".
5. Right-click > Move > `HomeLab\Disabled Users`.

## Verify

A login attempt with the account shows that it is disabled.

## Notes

- Don't delete the account straight away. Keep it disabled for record-keeping and in case files or access need to be checked later.
- In a company using Microsoft 365, offboarding also covers blocking sign-in, revoking active sessions, handling the mailbox (convert to shared or forward), removing licences and collecting company devices.
