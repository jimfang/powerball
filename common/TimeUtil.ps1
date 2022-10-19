
# Get a weekmark from any give timeframe
# Define a week: Friday - Thursday
# Return date of Thursday 4
function Get-WeekMarkDay {
    param(
        [Parameter(Mandatory = $true)]
        $TimeFrame,
        [Parameter(Mandatory = $false)]
        $WeekDayValue = 4
    )

    $ToThursday = $WeekDayValue - $TimeFrame.DayOfWeek.value__
    if ($ToThursday -lt 0) {
        $ToThursday += 7
    }

    $WeekMarkTime = $TimeFrame.AddDays($ToThursday)
    Write-Debug $WeekMarkTime
    $WeekMarkDay = $WeekMarkTime.ToString("MM/dd/yyyy")
    return $WeekMarkDay
}


function Convert-TimeFormat {
    param (
        [ValidateNotNullOrEmpty()]
        [Parameter(Mandatory = $true)]
        $Seconds
    )

    $TimeSpan = New-TimeSpan -Seconds $Seconds

    $Hours = $TimeSpan.Hours
    if ($TimeSpan.Days -gt 0) {
        $Hours += 24 * $TimeSpan.Days
    }

    $Minutes = $TimeSpan.Minutes
    $Sec = $TimeSpan.Seconds

    $NewFormat = "{0:d2}" -f $Hours
    $NewFormat += ":{0:d2}" -f $Minutes
    $NewFormat += ":{0:d2}" -f $Sec

    return $NewFormat
}