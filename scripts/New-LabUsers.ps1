<#
.SYNOPSIS
  Bulk-creates domain users from a CSV file, places each in their
  department OU, and adds them to the matching security group.
.EXAMPLE
  .\New-LabUsers.ps1 -CsvPath C:\Scripts\users.csv
#>
param(
    [string]$CsvPath = "C:\Scripts\users.csv"
)

Import-Module ActiveDirectory

$domain       = Get-ADDomain
$domainDN     = $domain.DistinguishedName
$upnSuffix    = $domain.DNSRoot
$tempPassword = Read-Host "Temporary password for all new users" -AsSecureString

$created = 0
foreach ($u in Import-Csv -Path $CsvPath) {
    $fullName = "$($u.FirstName) $($u.LastName)"
    $ou       = "OU=$($u.Department),OU=Staff,OU=HomeLab,$domainDN"
    $group    = "SG-$($u.Department)"

    # Skip users that already exist, so the script is safe to re-run
    if (Get-ADUser -Filter "SamAccountName -eq '$($u.Username)'") {
        Write-Warning "$($u.Username) already exists, skipping."
        continue
    }

    try {
        New-ADUser -Name $fullName -DisplayName $fullName `
            -GivenName $u.FirstName -Surname $u.LastName `
            -SamAccountName $u.Username `
            -UserPrincipalName "$($u.Username)@$upnSuffix" `
            -Title $u.Title -Department $u.Department `
            -Path $ou `
            -AccountPassword $tempPassword `
            -ChangePasswordAtLogon $true `
            -Enabled $true -ErrorAction Stop

        Add-ADGroupMember -Identity $group -Members $u.Username -ErrorAction Stop
        Write-Host "Created $($u.Username) ($($u.Department))" -ForegroundColor Green
        $created++
    }
    catch {
        Write-Warning "Failed on $($u.Username): $($_.Exception.Message)"
    }
}

Write-Host "`nDone. $created user(s) created." -ForegroundColor Cyan
