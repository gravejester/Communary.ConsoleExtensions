function Show-Calendar {
    <#
        .SYNOPSIS
            Show calendar.
        .DESCRIPTION
            This function is a PowerShell version of the *NIX cal command and will show a
            calendar of the chosen month(s). The current day will be marked with a '*'.
            For best results, use together with the FormatPx module by Kirk Munro.
        .EXAMPLE
            Show-Calendar
            Will show a calendar view of the current month.
        .EXAMPLE
            Show-Calendar -InvariantCulture
            Will show a calendar view of the current month, using the Invariant Culture
        .EXAMPLE
            Show-Calendar -Culture 'de-DE'
            Will show a calendar view of the current month, using the de-DE (German) culture.
        .EXAMPLE
            Show-Calendar 1 2015 -m 3
            Will show a calendar view of the first three months in 2015.
        .EXAMPLE
            Show-Calendar 12 -MarkDay 25 -Abbreviated
            Will show a calendar view of december and mark December 25, with abbreviated day names.
        .EXAMPLE
            Show-Calendar 1 2015 -m 12 -MarkDate (Get-Date -Year 2015 -Month 2 -Day 14)
            Will show a calendar view of 2015 and mark 14th of February.
        .LINK
            https://github.com/KirkMunro/FormatPx
        .NOTES
            Author: Øyvind Kallstad
            Date: 21.12.2014
            Version: 1.1
                22.12.2014
                    Added Alignment parameter
                    Made the entire function culture aware
                    Added support for abbreviated day names
    #>
    [CmdletBinding(DefaultParameterSetName = 'Culture')]
    param (
        # The starting month number. Default is current month.
        [Parameter(Position = 0)]
        [Alias('Month')]
        [ValidateRange(1,12)]
        [int] $StartMonth = [DateTime]::Now.Month,

        # The starting year. Default is current year.
        [Parameter(Position = 1)]
        [Alias('Year')]
        [ValidateRange(1,9999)]
        [int32] $StartYear = [DateTime]::Now.Year,

        # How many months to show. Default is 1.
        [Parameter()]
        [Alias('m')]
        [ValidateRange(1,[int]::MaxValue)]
        [int32] $Months = 1,

        # Day to mark on the calendar.
        [Parameter()]
        [ValidateRange(1,31)]
        [int32] $MarkDay,

        # Date to mark on the calendar.
        [Parameter()]
        [datetime] $MarkDate,

        # Set alignment of the dates in the output. Default value is 'Right'.
        [Parameter()]
        [ValidateSet('Left','Right')]
        [string] $Alignment = 'Right',

        # Use the Invariant Culture (English).
        [Parameter(ParameterSetName = 'InvariantCulture')]
        [switch] $InvariantCulture,

        # Use this parameter to choose what culture to use. If this parameter is not used and
        # the InvariantCulture parameter is false, the current culture will be used instead.
        [Parameter(ParameterSetName = 'Culture')]
        [string] $Culture,

        # Use this parameter to use abbreviated day names. Default is to use the full name of days.
        [Parameter()]
        [switch] $AbbreviatedDayNames
    )

    function New-DayOfWeekString {
        <#
            .SYNPSIS
                Output a culture aware string of a specified week day.
            .NOTES
                Author: Øyvind Kallstad
        #>
        [CmdletBinding()]
        [OutputType([String])]
        param (
            # The day of week in Invariant Culture (English).
            [Parameter(Position = 0, Mandatory)]
            [System.DayOfWeek] $DayOfWeek,

            [Parameter(Position = 1, ValueFromPipeline)]
            [CultureInfo] $CultureInfo = [System.Globalization.CultureInfo]::CurrentCulture,

            # Show the week day in an abbreviated form.
            [Parameter()]
            [switch] $Abbreviated
        )

        if ($Abbreviated) {
            Write-Output ($cultureInfo.TextInfo.ToTitleCase($cultureInfo.DateTimeFormat.GetAbbreviatedDayName([System.DayOfWeek]::$DayOfWeek)))
        }

        else {
            Write-Output ($cultureInfo.TextInfo.ToTitleCase($cultureInfo.DateTimeFormat.GetDayName([System.DayOfWeek]::$DayOfWeek)))
        }
    }

    function New-Week {
        <#
            .SYNOPSIS
                Returns an ordered dictionary representing a week.
            .NOTES
                Author: Øyvind Kallstad
        #>
        [CmdletBinding()]
        [OutputType([System.Collections.Specialized.OrderedDictionary])]
        param (
            [Parameter(Position = 0, ValueFromPipeline)]
            [CultureInfo] $CultureInfo = [System.Globalization.CultureInfo]::CurrentCulture,

            # Show the week day in an abbreviated form.
            [Parameter()]
            [switch] $Abbreviated
        )

        $propHash = @{
            CultureInfo = $CultureInfo
        }

        if ($Abbreviated) {
            $propHash.Abbreviated = $true
        }

        # define week day names
        $monday = New-DayOfWeekString 'Monday' @propHash
        $tuesday = New-DayOfWeekString 'Tuesday' @propHash
        $wednesday = New-DayOfWeekString 'Wednesday' @propHash
        $thursday = New-DayOfWeekString 'Thursday' @propHash
        $friday = New-DayOfWeekString 'Friday' @propHash
        $saturday = New-DayOfWeekString 'Saturday' @propHash
        $sunday = New-DayOfWeekString 'Sunday' @propHash
 
        $week = [Ordered] @{
            $tuesday = $null
            $wednesday = $null
            $thursday = $null
            $friday = $null
            $saturday = $null
        }
 
        if (($CultureInfo.DateTimeFormat.FirstDayOfWeek) -eq 'Monday') {
            $week.Insert(0, $monday, $null)
            $week.Add($sunday, $null)
        }
 
        else {
            $week.Insert(0, $sunday, $null)
            $week.Insert(1, $monday, $null)
        }

        Write-Output $week
    }

    # get a CultureInfo object based on user input
    # either with an Invariant Culture...
    if ($InvariantCulture) {
        $cultureInfo = [System.Globalization.CultureInfo]::InvariantCulture
    }
    # ... user defined culture...
    elseif ($Culture) {
        $cultureInfo = [System.Globalization.CultureInfo]::CreateSpecificCulture($Culture)
    }
    # ... or the current culture
    else {
        $cultureInfo = [System.Globalization.CultureInfo]::CurrentCulture
    }

    # supporting internationalization
    # add additional languages as needed
    switch ($cultureInfo.Name) {
        'nb-NO' {$translate = @{Year = 'År';       Month = 'Måned';    Week = 'Uke'}}        # Norwegian (Bokmål)
        'da-DK' {$translate = @{Year = 'År';       Month = 'Måned';    Week = 'Uge'}}        # Danish
        'sv-SE' {$translate = @{Year = 'År';       Month = 'Månad';    Week = 'Vecka'}}      # Swedish
        'fi-FI' {$translate = @{Year = 'Vuosi';    Month = 'Kuukausi'; Week = 'Viikko'}}     # Finnish
        'de-DE' {$translate = @{Year = 'Jahr';     Month = 'Monat';    Week = 'Woche'}}      # German
        'de-AT' {$translate = @{Year = 'Jahr';     Month = 'Monat';    Week = 'Woche'}}      # German (Austria)
        'de-CH' {$translate = @{Year = 'Jahr';     Month = 'Monat';    Week = 'Woche'}}      # German (Switzerland)
        'nl-NL' {$translate = @{Year = 'Jaar';     Month = 'Maand';    Week = 'Week'}}       # Dutch
        'fr-FR' {$translate = @{Year = 'Année';    Month = 'Mois';     Week = 'Semaine'}}    # French
        'fr-CH' {$translate = @{Year = 'Année';    Month = 'Mois';     Week = 'Semaine'}}    # French (Switzerland)
        'fr-LU' {$translate = @{Year = 'Année';    Month = 'Mois';     Week = 'Semaine'}}    # French (Luxembourg)
        'it-IT' {$translate = @{Year = 'Anno';     Month = 'Mese';     Week = 'Settimana'}}  # Italian
        'es-ES' {$translate = @{Year = 'Año';      Month = 'Mes';      Week = 'Semana'}}     # Spanish
        'ru-RU' {$translate = @{Year = 'Год';      Month = 'Месяц';    Week = 'Неделя'}}     # Russian
        'cs-CZ' {$translate = @{Year = 'Rok';      Month = 'Měsíc';    Week = 'Týden'}}      # Czech
        'ms-MY' {$translate = @{Year = 'Tahun';    Month = 'Bulan';    Week = 'Minggu'}}     # Malay
        'ja-JP' {$translate = @{Year = '年';       Month = '月';       Week = '1週間'}}      # Japanese
        'is-IS' {$translate = @{Year = 'Ári';      Month = 'Mánuði';   Week = 'Viku'}}       # Icelandic
        'pl-PL' {$translate = @{Year = 'Rok';      Month = 'Miesiąc';  Week = 'Tydzień'}}    # Polish
        'cy-GB' {$translate = @{Year = 'Blwyddyn'; Month = 'Mis';      Week = 'Wythnos'}}    # Welsh (United Kingdom)
        DEFAULT {$translate = @{Year = 'Year';     Month = 'Month';    Week = 'Week'}}       # Invariant Culture (English)
    }

    $thisMonth = $StartMonth - 1
    $thisYear = $StartYear
    $output = @()
    $weekProperties = @{}
    if ($AbbreviatedDayNames) { $weekProperties.Abbreviated = $true }

    # loop through the months
    for ($i = 1; $i -le $Months; $i++) {

        # increment month
        $thisMonth++

        # when month is greater than 12, a new year is triggered, so reset month to 1 and increment year
        if ($thisMonth -gt 12) {
            $thisMonth = 1
            $thisYear++
        }

        # get the number of days in the month
        $daysInMonth = $cultureInfo.Calendar.GetDaysInMonth($thisYear,$thisMonth)

        # define new week
        $thisWeek = $cultureInfo | New-Week @weekProperties
        $thisWeek.Insert(0, $translate.Month, $null)
        $thisWeek.Insert(1, $translate.Year, $null)
        $thisWeek.Insert(2, $translate.Week, $null)

        # loop through each day in the month
        for ($y = 1; $y -lt ($daysInMonth + 1); $y++) {

            # get a datetime object of the current date
            $thisDate = New-Object -TypeName 'System.DateTime' -ArgumentList ($thisYear,$thisMonth,$y,$cultureInfo.Calendar)

            # if current date is the first day of a week (but not if it's the very first day of the month at the same time)
            if (($thisDate.DayOfWeek -eq ($cultureInfo.DateTimeFormat.FirstDayOfWeek)) -and ($y -gt 1)) {
 
                # add the week object to the output array
                $weekObject = New-Object -TypeName 'PSCustomObject' -Property $thisWeek
                $output += $weekObject
 
                # reset the week
                $thisWeek = $cultureInfo | New-Week @weekProperties
                $thisWeek.Insert(0, $translate.Month, $null)
                $thisWeek.Insert(1, $translate.Year, $null)
                $thisWeek.Insert(2, $translate.Week, $null)
            }

            # get string representation of the month and the current week number (if week number is 53, change to 1)
            $monthString = $cultureInfo.TextInfo.ToTitleCase($thisDate.ToString('MMMM',$cultureInfo))
            $thisWeekNumber = $cultureInfo.calendar.GetWeekOfYear($thisDate,$cultureInfo.DateTimeFormat.CalendarWeekRule,$cultureInfo.DateTimeFormat.FirstDayOfWeek)
            if ($thisWeekNumber -eq 53) { $thisWeekNumber = 1 }

            # overload the ToString method of the datetime object
            $thisDate | Add-Member -MemberType ScriptMethod -Name 'ToString' -Value {
                # mark today with '*'
                if (($this.Date) -eq ([DateTime]::Now.Date)) {
                    if($Alignment -eq 'Left') {$this.Day.ToString() + '*'}
                    else {'*' + $this.Day.ToString()}
                }
                elseif ($MarkDay -eq $this.Day) {
                    if($Alignment -eq 'Left') {$this.Day.ToString() + '!'}
                    else {'!' + $this.Day.ToString()}
                }
                elseif ($MarkDate.Date -eq $this.Date) {
                    if($Alignment -eq 'Left') {$this.Day.ToString() + '!'}
                    else {'!' + $this.Day.ToString()}
                }
                else {
                    $this.Day.ToString()
                }
            } -Force

            # update the week hashtable with the current day, week, month and year
            $thisWeek[($cultureInfo | New-DayOfWeekString ($thisDate.DayOfWeek) -Abbreviated:$AbbreviatedDayNames)] = $thisDate
            $thisWeek[$translate.Week] = $thisWeekNumber
            $thisWeek[$translate.Month] = $monthString
            $thisWeek[$translate.Year] = $thisYear
        }

        # add the final week to the output array
        $weekObject = New-Object -TypeName 'PSCustomObject' -Property $thisWeek
        $output += $weekObject
    }

    # translate day names
    $monday    = $cultureInfo | New-DayOfWeekString 'Monday' -Abbreviated:$AbbreviatedDayNames
    $tuesday   = $cultureInfo | New-DayOfWeekString 'Tuesday' -Abbreviated:$AbbreviatedDayNames
    $wednesday = $cultureInfo | New-DayOfWeekString 'Wednesday' -Abbreviated:$AbbreviatedDayNames
    $thursday  = $cultureInfo | New-DayOfWeekString 'Thursday' -Abbreviated:$AbbreviatedDayNames
    $friday    = $cultureInfo | New-DayOfWeekString 'Friday' -Abbreviated:$AbbreviatedDayNames
    $saturday  = $cultureInfo | New-DayOfWeekString 'Saturday' -Abbreviated:$AbbreviatedDayNames
    $sunday    = $cultureInfo | New-DayOfWeekString 'Sunday' -Abbreviated:$AbbreviatedDayNames

    # define a hashtable to hold format properties for the table output
    if (($cultureInfo.DateTimeFormat.FirstDayOfWeek) -eq 'Monday') {
        $formatProperties = @{
            Property =
                "$($translate.Week)",
                @{Name = "$monday"    ;Expression = {$_.$monday}    ;Alignment = $Alignment}, 
                @{Name = "$tuesday"   ;Expression = {$_.$tuesday}   ;Alignment = $Alignment},
                @{Name = "$wednesday" ;Expression = {$_.$wednesday} ;Alignment = $Alignment},
                @{Name = "$thursday"  ;Expression = {$_.$thursday}  ;Alignment = $Alignment},
                @{Name = "$friday"    ;Expression = {$_.$friday}    ;Alignment = $Alignment},
                @{Name = "$saturday"  ;Expression = {$_.$saturday}  ;Alignment = $Alignment},
                @{Name = "$sunday"    ;Expression = {$_.$sunday}    ;Alignment = $Alignment}
        }
    }

    else {
        $formatProperties = @{
            Property =
                "$($translate.Week)",
                @{Name = "$sunday"    ;Expression = {$_.$sunday}    ;Alignment = $Alignment},
                @{Name = "$monday"    ;Expression = {$_.$monday}    ;Alignment = $Alignment}, 
                @{Name = "$tuesday"   ;Expression = {$_.$tuesday}   ;Alignment = $Alignment},
                @{Name = "$wednesday" ;Expression = {$_.$wednesday} ;Alignment = $Alignment},
                @{Name = "$thursday"  ;Expression = {$_.$thursday}  ;Alignment = $Alignment},
                @{Name = "$friday"    ;Expression = {$_.$friday}    ;Alignment = $Alignment},
                @{Name = "$saturday"  ;Expression = {$_.$saturday}  ;Alignment = $Alignment}
        }
    }

    # if FormatPx is loaded, use it to format the output
    if (Get-Module -Name 'FormatPx') {
        Write-Output ($output | Format-Table @formatProperties -AutoSize -GroupBy @{Name = "$($translate.Month)";Expression = {"$($_.($translate.Month)) $($_.($translate.Year))"}} -PersistWhenOutput)
    }

    # else use default PowerShell formatting
    else {
        Write-Output ($output | Format-Table @formatProperties -AutoSize -GroupBy @{Name = "$($translate.Month)";Expression = {"$($_.($translate.Month)) $($_.($translate.Year))"}})
    }
}