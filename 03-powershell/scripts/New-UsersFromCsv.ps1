<#
.SYNOPSIS
    Creates Active Directory users from a CSV file.
.DESCRIPTION
    Reads FirstName, LastName, Username and Department from a CSV file,
    creates each user in the matching OU (Staff, Management, IT) and adds
    them to the group GG_<Department>. Skips users that already exist.
    Use -DryRun to preview the actions without touching Active Directory.
.PARAMETER CsvPath
    Path to the CSV file.
.PARAMETER Domain
    DNS name of the domain (default company.local).
.PARAMETER DryRun
    Only prints what would be created.
#>
param(
    [Parameter(Mandatory)][string]$CsvPath,
    [string]$Domain = "company.local",
    [switch]$DryRun
)

$domainDN = "DC=" + ($Domain -replace '\.', ',DC=')
$users = Import-Csv -Path $CsvPath

if (-not $DryRun) {
    Import-Module ActiveDirectory -ErrorAction Stop
    $password = Read-Host "Temporary password for the new users" -AsSecureString
}

foreach ($u in $users) {
    $display = "$($u.FirstName) $($u.LastName)"
    $upn     = "$($u.Username)@$Domain"
    $ouPath  = "OU=$($u.Department),$domainDN"
    $group   = "GG_$($u.Department)"

    if ($DryRun) {
        Write-Host "[DRY RUN] Would create $display ($upn) in $ouPath and add to $group" -ForegroundColor Yellow
        continue
    }

    if (Get-ADUser -Filter "SamAccountName -eq '$($u.Username)'" -ErrorAction SilentlyContinue) {
        Write-Host "SKIP: $($u.Username) already exists" -ForegroundColor Cyan
        continue
    }

    try {
        New-ADUser -Name $display -GivenName $u.FirstName -Surname $u.LastName `
            -SamAccountName $u.Username -UserPrincipalName $upn -Path $ouPath `
            -AccountPassword $password -ChangePasswordAtLogon $true -Enabled $true
        Add-ADGroupMember -Identity $group -Members $u.Username
        Write-Host "Created: $display in $($u.Department)" -ForegroundColor Green
    }
    catch {
        Write-Host "ERROR for $($u.Username): $($_.Exception.Message)" -ForegroundColor Red
    }
}
