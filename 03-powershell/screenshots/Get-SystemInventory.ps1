<#
.SYNOPSIS
    Collects a basic system inventory and exports it to a CSV file.
.DESCRIPTION
    Reads computer name, OS, hardware and disk information with CIM,
    prints a summary on screen and saves it to inventory-report.csv.
#>

$os   = Get-CimInstance Win32_OperatingSystem
$cs   = Get-CimInstance Win32_ComputerSystem
$cpu  = Get-CimInstance Win32_Processor | Select-Object -First 1
$disks = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3"

$diskInfo = ($disks | ForEach-Object {
    "{0} {1} GB free of {2} GB" -f $_.DeviceID,
        [math]::Round($_.FreeSpace / 1GB, 1),
        [math]::Round($_.Size / 1GB, 1)
}) -join " | "

$report = [PSCustomObject]@{
    ComputerName = $env:COMPUTERNAME
    OS           = $os.Caption
    OSVersion    = $os.Version
    Manufacturer = $cs.Manufacturer
    Model        = $cs.Model
    CPU          = $cpu.Name
    RAM_GB       = [math]::Round($cs.TotalPhysicalMemory / 1GB, 1)
    Disks        = $diskInfo
    LastBoot     = $os.LastBootUpTime
    ReportDate   = Get-Date -Format "yyyy-MM-dd HH:mm"
}

$report | Format-List
$report | Export-Csv -Path "$PSScriptRoot\inventory-report.csv" -NoTypeInformation -Encoding UTF8
Write-Host "Report saved to $PSScriptRoot\inventory-report.csv" -ForegroundColor Green
