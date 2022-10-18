
$ScriptRoot = $PSScriptRoot
. "$ScriptRoot\..\common\TimeUtil.ps1"
. "$ScriptRoot\..\common\RandomUtil.ps1"


# Show Current Date
$TimeZone = (Get-TimeZone).DisplayName
Write-Host "`n--Time Zone--"
Write-Host "$TimeZone"

$CurrentTime = Get-Date
Write-Host "Lucky Winding: $CurrentTime"

$WeekDay = Get-WeekMarkDay -TimeFrame $CurrentTime
Write-Host "Target on $WeekDay Draw"

Write-Host "`n`n=============="

# Config
$DrawTimeUnit = 314

# History Date
$Last10PowerBall = @(2, 10, 4, 8, 15)

# Final Result
$WinningNumbers = @()
$PowerballWonNumber = @()


# Initial Pool
# 1 - 20
$WinNumberPool = @()
$PowerballPool = @()



foreach ( $PowerballNumber in 1..20 ) {
    if($Last10PowerBall -contains $PowerballNumber) {
        continue
    }

    $PowerballPool += New-Object -TypeName PSCustomObject -Property @{"PowerballNumber" = $PowerballNumber; "Position" = 0 } 
}
# $PowerballPool | Format-Table

# Draw for power ball
$DrawSequence = 10
$MinDrawTimes = ($DrawSequence) * $DrawTimeUnit
$MaxDrawTimes = ($DrawSequence + 1) * $DrawTimeUnit
$DrawTimes = Get-Random -Minimum $MinDrawTimes -Maximum $MaxDrawTimes

$NumberPoolForDraw = $PowerballPool.PowerballNumber
# Write-Host "$DrawSequence draw: numbers in pool: $NumberPoolForDraw"
$DrawStats = 1..$DrawTimes | ForEach-Object {
    $NumberPoolForDraw | Get-Random
} | Group-Object | Select-Object Name,Count | Sort-Object -Property Count -Descending

# $DrawStats | Format-Table

$PowerballWin = $DrawStats[0].Name
$PowerballWonNumber += $PowerballWin


# Draw winning number
foreach ( $WinNumber in 1..35 ) {
    if($PowerballWonNumber -contains $WinNumber) {
        continue
    }

    $WinNumberPool += New-Object -TypeName PSCustomObject -Property @{"WinNumber" = $WinNumber; "Position" = 0 } 
}
# $WinNumberPool | Format-Table

$WinNumberPoolNew = $WinNumberPool

foreach ($DrawSequence in 1..7) {
    $MinDrawTimes = (7-$DrawSequence) * $DrawTimeUnit
    $MaxDrawTimes = (8-$DrawSequence) * $DrawTimeUnit
    $DrawTimes = Get-Random -Minimum $MinDrawTimes -Maximum $MaxDrawTimes
    
    $NumberPoolForDraw = $WinNumberPoolNew.WinNumber
    # Write-Host "$DrawSequence draw: numbers in pool: $NumberPoolForDraw"
    $DrawStats = 1..$DrawTimes | ForEach-Object {
        $NumberPoolForDraw | Get-Random
    } | Group-Object | Select-Object Name,Count | Sort-Object -Property Count -Descending
    
    # $DrawStats | Format-Table

    $DrawWin = $DrawStats[0].Name
    $WinningNumbers += $DrawWin
    Write-Host "$DrawSequence draw: $WinningNumbers "
    
    $WinNumberPoolNew = $WinNumberPoolNew | Where-Object {$_.WinNumber -ne $DrawWin}
    # $WinNumberPoolNew | Format-Table
}



Write-Host "===============`n`n"
Write-Warning "Final Draw Result: $WinningNumbers | $PowerballWonNumber `n"