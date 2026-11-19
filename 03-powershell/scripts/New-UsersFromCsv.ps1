<#
.SYNOPSIS
    Creates Active Directory users from a CSV file.
.DESCRIPTION
    Reads FirstName, LastName, Username and Department from a CSV file,
    creates each user in the matching OU (Staff, Management, IT) and adds
    them to the group GG_<Department>. Skips existing users and invalid rows.
    Use -DryRun to preview valid actions without changing Active Directory.
.PARAMETER CsvPath
    Path to the CSV file.
.PARAMETER Domain
    DNS name of the domain (default company.local).
.PARAMETER DryRun
    Only prints what would be created.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$CsvPath,

    [ValidatePattern('^[A-Za-z0-9.-]+$')]
    [string]$Domain = "company.local",

    [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$allowedDepartments = @("Staff", "Management", "IT")
$requiredColumns = @("FirstName", "LastName", "Username", "Department")
$domainDN = "DC=" + ($Domain -replace '\.', ',DC=')

if (-not (Test-Path -LiteralPath $CsvPath -PathType Leaf)) {
    throw "CSV file not found: $CsvPath"
}

try {
    $users = @(Import-Csv -LiteralPath $CsvPath -ErrorAction Stop)
}
catch {
    throw "Unable to read CSV file '$CsvPath': $($_.Exception.Message)"
}

if ($users.Count -eq 0) {
    throw "The CSV file is empty or contains no data rows."
}

$actualColumns = @($users[0].PSObject.Properties.Name)
$missingColumns = @($requiredColumns | Where-Object { $_ -notin $actualColumns })
if ($missingColumns.Count -gt 0) {
    throw "CSV is missing required columns: $($missingColumns -join ', ')"
}

if (-not $DryRun) {
    Import-Module ActiveDirectory -ErrorAction Stop
    $password = Read-Host "Temporary password for the new users" -AsSecureString
}

$seenUsernames = @{}

foreach ($user in $users) {
    $firstName = ([string]$user.FirstName).Trim()
    $lastName = ([string]$user.LastName).Trim()
    $username = ([string]$user.Username).Trim()
    $department = ([string]$user.Department).Trim()

    $problems = @()
    if ([string]::IsNullOrWhiteSpace($firstName)) { $problems += "FirstName is empty" }
    if ([string]::IsNullOrWhiteSpace($lastName)) { $problems += "LastName is empty" }
    if ($username -notmatch '^[A-Za-z0-9._-]{1,20}$') {
        $problems += "Username must contain 1-20 letters, numbers, dots, underscores or hyphens"
    }
    if ($department -notin $allowedDepartments) {
        $problems += "Department must be one of: $($allowedDepartments -join ', ')"
    }

    if ($username -and $seenUsernames.ContainsKey($username)) {
        $problems += "Username is duplicated in the CSV"
    }
    elseif ($username) {
        $seenUsernames[$username] = $true
    }

    if ($problems.Count -gt 0) {
        Write-Warning "SKIP row for '$username': $($problems -join '; ')"
        continue
    }

    $display = "$firstName $lastName"
    $upn = "$username@$Domain"
    $ouPath = "OU=$department,$domainDN"
    $group = "GG_$department"

    if ($DryRun) {
        Write-Host "[DRY RUN] Would create $display ($upn) in $ouPath and add to $group" -ForegroundColor Yellow
        continue
    }

    try {
        $existingUser = Get-ADUser -Filter "SamAccountName -eq '$username'" -ErrorAction Stop
        if ($existingUser) {
            Write-Host "SKIP: $username already exists" -ForegroundColor Cyan
            continue
        }
    }
    catch {
        Write-Host "ERROR checking $username`: $($_.Exception.Message)" -ForegroundColor Red
        continue
    }

    try {
        New-ADUser -Name $display -GivenName $firstName -Surname $lastName `
            -SamAccountName $username -UserPrincipalName $upn -Path $ouPath `
            -AccountPassword $password -ChangePasswordAtLogon $true -Enabled $true `
            -ErrorAction Stop
    }
    catch {
        Write-Host "ERROR creating $username`: $($_.Exception.Message)" -ForegroundColor Red
        continue
    }

    try {
        Add-ADGroupMember -Identity $group -Members $username -ErrorAction Stop
        Write-Host "Created and added to $group`: $display" -ForegroundColor Green
    }
    catch {
        Write-Host "PARTIAL: account $username was created, but adding it to $group failed: $($_.Exception.Message)" -ForegroundColor Yellow
    }
}
