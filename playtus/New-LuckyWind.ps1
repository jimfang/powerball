
$ScriptRoot = $PSScriptRoot
. "$ScriptRoot\..\common\TimeUtil.ps1"
. "$ScriptRoot\..\common\RandomUtil.ps1"


# Show Current Date
$TimeZone = (Get-TimeZone).DisplayName
Write-Host "`n`n--Time Zone--"
Write-Host "$TimeZone"

$CurrentTime = Get-Date
Write-Host "Lucky Winding: $CurrentTime"

$WeekDay = Get-WeekMarkDay -TimeFrame $CurrentTime
Write-Host "Target on $WeekDay Draw"

# History Date
$Last10PowerBall = @(2, 10, 4, 8, 15)

# Initial Pool
# 1 - 20
$WinNumberPool = @()
$PowerballPool = @()

foreach ( $WinNumber in 1..35 ) {
    $WinNumberPool += New-Object -TypeName PSCustomObject -Property @{"WinNumber" = $WinNumber; "Position" = 0 } 
}
$WinNumberPool | Format-Table

foreach ( $PowerballNumber in 1..20 ) {
    if($Last10PowerBall -contains $PowerballNumber) {
        continue
    }

    $PowerballPool += New-Object -TypeName PSCustomObject -Property @{"PowerballNumber" = $PowerballNumber; "Position" = 0 } 
}
$PowerballPool | Format-Table

# Draw the first winning number
$DrawTimeUnit = 314
$DrawTimes = Get-Random -Minimum $DrawTimeUnit*6 -Maximum $DrawTimeUnit*7

$DrawStats = 1..$DrawTimes | ForEach-Object {
    1..35 | Get-Random
} | Group-Object | Select-Object Name,Count | Sort-Object Count

$DrawStats | Format-Table
