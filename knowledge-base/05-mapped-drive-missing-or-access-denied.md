# Mapped network drive missing or access denied

**Audience:** IT support (internal knowledge base)

**Applies to:** Department drives mapped by Group Policy, for example F: Finance, which the "Map Finance Drive" GPO maps for members of SG-Finance

## Steps

1. Ask which drive is affected and what the user sees: drive missing, red X, or "access denied".
2. On the user's PC, run `gpresult /r` while logged in as that user.
   - Under Applied Group Policy Objects, check that "Map Finance Drive" is listed.
   - Under the user's security groups, check for SG-Finance.
3. If SG-Finance is missing:
   - In ADUC, check the user's Member Of tab.
   - If they should have access (for example a Finance team member), add them to SG-Finance.
   - If they're not in Finance, access needs approval from the Finance Manager first.
4. Ask the user to sign out and back in. Group changes only apply at a new login.
5. If the group is correct but the drive still doesn't appear, run `gpupdate /force`, then sign out and back in.
6. If the drive path won't open at all, check DNS: `nslookup homelab.internal` should return 10.10.10.10. If it fails, check the PC's DNS settings (they should be set automatically by DHCP).

## Verify

The drive appears in This PC and the user can open their files.
