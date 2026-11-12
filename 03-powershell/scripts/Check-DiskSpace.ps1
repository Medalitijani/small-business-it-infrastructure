<#
.SYNOPSIS
    Warns when a disk has less free space than a chosen percentage.
.PARAMETER ThresholdPercent
    Minimum free space in percent (default 20).
#>
param([int]$ThresholdPercent = 20)

Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" | ForEach-Object {
    $freePercent = [math]::Round(($_.FreeSpace / $_.Size) * 100, 1)
    $freeGB = [math]::Round($_.FreeSpace / 1GB, 1)

    if ($freePercent -lt $ThresholdPercent) {
        Write-Host "WARNING: drive $($_.DeviceID) has only $freePercent% free ($freeGB GB)" -ForegroundColor Red
    }
    else {
        Write-Host "OK: drive $($_.DeviceID) has $freePercent% free ($freeGB GB)" -ForegroundColor Green
    }
}
