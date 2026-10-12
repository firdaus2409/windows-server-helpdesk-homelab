# Unlock an account and reset a password

**Audience:** IT support (internal knowledge base)

**Tool:** Active Directory Users and Computers (ADUC) on DC01

## Steps

1. Verify the user's identity before making any change.
2. In ADUC, right-click `homelab.internal` > Find, type the user's name, and click Find Now.
3. Open the user's Properties > Account tab. If the Unlock account box says "This account is currently locked out on this Active Directory Domain Controller", the account is locked out.
4. Close Properties. Right-click the user > Reset Password.
5. Enter a temporary password and tick:
   - User must change password at next logon
   - Unlock the user's account
6. Give the temporary password to the user separately (in person or by phone). Never write it in the ticket.

## Verify

The user logs in and is prompted to set a new password.

## Notes

- Domain lockout policy: 5 invalid attempts, 15-minute lockout, counter resets after 15 minutes.
- If the same user keeps getting locked out, look for an old password saved somewhere, such as a phone email app or a remembered network drive.
