function Invoke-Touch {
    <#
        .SYNOPSIS
            PowerShell inplementation of the Unix/Linux utility called touch.
        .DESCRIPTION
            Touch let's you update the access date and / or modification date of a file. If the file don't exist, an empty file will be created
            unless you use the DoNotCreateNewFile parameter. This implementation have the original parameter names added as
            aliases, so if you are familiar with the original touch utility it should be easy to use this one.
        .EXAMPLE
            Invoke-Touch newfile
            Will create a new empty file called 'newfile' in the current folder.
        .EXAMPLE
            Invoke-Touch newfile3 -DateTime '10.10.2014'
            Will create a new empty file called 'newfile3' with the provided date.
        .EXAMPLE
            Invoke-Touch newfile -r newfile3
            Will update the timestamp of 'newfile' using 'newfile3' as a reference.
        .LINK
            https://gist.github.com/gravejester/f4934a5ce16c652d11d3
        .NOTES
            *** THIS FUNCTION IS USING 'Resolve-PathEx' AND WON'T WORK WITHOUT IT ***
 
            Author: Øyvind Kallstad
            Date: 13.11.2014
            Version: 1.0
    #>
    [CmdletBinding(ConfirmImpact = 'Low',SupportsShouldProcess, DefaultParameterSetName = 'UserDateTime')]
    param (
        # Filename and/or path.
        [Parameter(Position = 0, ValueFromPipeline, ValueFromPipelinebyPropertyName)]
        [string[]] $Path,
 
        # File to use as a timestamp reference.
        [Parameter(ParameterSetName = 'ReferenceDateTime')]
        [Alias('r')]
        [string] $Reference,
 
        # Timestamp offset in seconds.
        [Parameter()]
        [Alias('B','F')]
        [int] $OffsetSeconds = 0,
 
        # Used to override the timestamp. If omitted the current date and time will be used.
        [Parameter(ParameterSetName = 'UserDateTime')]
        [Alias('t','d')]
        [string] $DateTime,
 
        # Update Last Access Time.
        [Parameter()]
        [Alias('a')]
        [switch] $AccessTime,
 
        # Update Last Write Time.
        [Parameter()]
        [Alias('m','w')]
        [switch] $WriteTime,
 
        # Switch to override the basic functionality of creating a new file if it don't exist already.
        [Parameter()]
        [Alias('c')]
        [switch] $DoNotCreateNewFile,
 
        [Parameter()]
        [switch] $PassThru
    )
 
    BEGIN {
        
        try {
            # use timestamp from a reference file
            if (-not([string]::IsNullOrEmpty($Reference))) {
                if (Test-Path $Reference) {
                    $referenceFile = Get-ChildItem -Path $Reference
                    $newLastAccessTime = ($referenceFile.LastAccessTime).AddSeconds($OffsetSeconds)
                    $newLastWriteTime = ($referenceFile.LastWriteTime).AddSeconds($OffsetSeconds)
                    Write-Verbose "Using timestamp from $Reference"
                }
                else {
                    Write-Warning "$Reference not found!"
                }
            }
 
            # use timestamp from user input
            elseif (-not([string]::IsNullOrEmpty($DateTime))) {
                $userDateTime = [DateTime]::Parse($DateTime,[CultureInfo]::CurrentCulture,[System.Globalization.DateTimeStyles]::NoCurrentDateDefault)
                Write-Verbose "Using timestamp from user input: $DateTime (Parsed: $($userDateTime))"
            }
 
            # use timestamp from current date/time
            else {
                $currentDateTime = (Get-Date).AddSeconds($OffsetSeconds)
                $newLastAccessTime = $currentDateTime
                $newLastWriteTime = $currentDateTime
                Write-Verbose "Using timestamp from current date/time: $currentDateTime"
            }
        }
        catch {
            Write-Warning $_.Exception.Message
        }
    }
 
    PROCESS {
        foreach ($thisPath in $Path) {
            
            try {
                $thisPathResolved = Resolve-PathEx -Path $thisPath
 
                foreach ($p in $thisPathResolved.Path) {
                    Write-Verbose "Resolved path: $p"
 
                    # if file is not found, and it's ok to create a new file, create it!
                    if (-not(Test-Path $p)) {
                        if ($DoNotCreateNewFile) {
                            Write-Verbose "$p not created"
                            return
                        }
                        else {
                            if ($PSCmdlet.ShouldProcess($p, 'Create File')) {
                                $null = New-Item -path $p -ItemType 'File' -ErrorAction 'Stop'
                            }
                        }
                    }
 
                    # get fileinfo object
                    $fileObject = Get-ChildItem $p -ErrorAction SilentlyContinue

                    if (-not([string]::IsNullOrEmpty($fileObject))) {
                        # handle date & time if datetime parameter is used
                        if (-not([string]::IsNullOrEmpty($DateTime))) {
 
                            # if parsed datetime object contains time
                            if ([bool]$userDateTime.TimeOfDay.Ticks) {
                                Write-Verbose 'Found time in datetime'
                                $userTime = $userDateTime.ToLongTimeString()
                            }
                            # else, get time from file
                            else {
                                Write-Verbose 'Did not find time in datetime - using time from file'
                                $userTime = $fileObject.LastAccessTime.ToLongTimeString()
                            }
 
                            # if parsed datetime object contains date
                            if ([bool]$userDateTime.Date.Ticks) {
                                Write-Verbose 'Found date in datetime'
                                $userDate = $userDateTime.ToShortDateString()
                            }

                            # else, get date from file
                            else {
                                Write-Verbose 'Did not find date in datetime - using date from file'
                                $userDate = $fileObject.LastAccessTime.ToShortDateString()
                            }
 
                            # parse the new datetime
                            $parsedNewDateTime = [datetime]::Parse("$userDate $userTime")
 
                            # add offset and save to the appropriate variables
                            $newLastAccessTime = $parsedNewDateTime.AddSeconds($OffsetSeconds)
                            $newLastWriteTime = $parsedNewDateTime.AddSeconds($OffsetSeconds)
                        }
                    }
 
                    if ($PSCmdlet.ShouldProcess($p, 'Update Timestamp')) {
                        # if neither -AccessTime nor -WriteTime is used, update both Last Access Time and Last Write Time
                        if ((-not($AccessTime)) -and (-not($WriteTime))) {
                            $fileObject.LastAccessTime = $newLastAccessTime
                            $fileObject.LastWriteTime = $newLastWriteTime
                        }
 
                        else {
                            if ($AccessTime) { $fileObject.LastAccessTime = $newLastAccessTime }
                            if ($WriteTime) { $fileObject.LastWriteTime = $newLastWriteTime }
                        }
                    }
                }
 
                if ($PassThru) {
                    Write-Output (Get-ChildItem $p)
                }
            }
 
            catch {
                Write-Warning $_.Exception.Message
            }
        }
    }
}
New-Alias -Name 'Touch' -Value 'Invoke-Touch' -Force