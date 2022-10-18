
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
