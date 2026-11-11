# Phase 3: PowerShell automation

Three scripts that automate common IT support tasks.

## Scripts

| Script | What it does | Tested |
|---|---|---|
| `Get-SystemInventory.ps1` | Collects computer name, OS, CPU, RAM and disk information and exports a CSV report | ✅ On a real Windows 11 PC |
| `Check-DiskSpace.ps1` | Warns when a disk has less free space than a threshold (default 20%) | ✅ On a real Windows 11 PC |
| `New-UsersFromCsv.ps1` | Creates Active Directory users from a CSV file in the right OU and group | ⚠️ Dry-run only (see note) |

> **Note:** `New-UsersFromCsv.ps1` uses the ActiveDirectory module (`New-ADUser`, `Add-ADGroupMember`). I did not have a live domain controller to run it against, since Phase 2 was done in a simulator. I tested the CSV reading and the logic with `-DryRun`. The AD commands are standard cmdlets, but they are untested on a real domain.

## Usage

```powershell
.\Get-SystemInventory.ps1
.\Check-DiskSpace.ps1 -ThresholdPercent 20
.\New-UsersFromCsv.ps1 -CsvPath .\users.csv -DryRun
```

## Results

**System inventory:**

![Inventory output](screenshots/inventory-output.png)

**Disk space check (OK and WARNING cases):**

![Disk check output](screenshots/disk-check-output.png)

**User creation, dry run:**

![Dry run output](screenshots/dry-run-output.png)
