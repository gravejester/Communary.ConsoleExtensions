function Invoke-PathShortener {
    <#
        .SYNOPSIS
            Path Shortener
        .EXAMPLE
            Invoke-PathShortener
            Will take the current path and shortened it using default values.
        .EXAMPLE
            Invoke-PathShortener -KeepBefore 3
            Will shorten the current path and keep the first 3 parts and last 1.
        .EXAMPLE
            Invoke-PathShortener -KeepBefore 3 -KeepAfter 2
            Will shorten the current path and keep the first 3 parts and the last 2 parts.
        .EXAMPLE
            'C:\Windows\System32\WindowsPowerShell\v1.0\Modules' | Invoke-PathShortener -TruncateChar ([char]8230)
            Will shorten the path piped in from the pipeline, using a custom truncate character.
        .NOTES
            Author: Øyvind Kallstad
            Date: 10.09.2016
            Version: 2.1
    #>
    [CmdletBinding()]
    param (
        # Path to shorten.
        [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullorEmpty()]
        [string] $Path = (Get-Location),

        # Number of parts to keep before truncating. Default value is 2.
        [Parameter()]
        [ValidateRange(0, [int32]::MaxValue)]
        [int] $KeepBefore = 2,

        # Number of parts to keep after truncating. Default value is 1.
        [Parameter()]
        [ValidateRange(1, [int32]::MaxValue)]
        [int] $KeepAfter = 1,

        # Path separator character.
        [Parameter()]
        [string] $Separator = [System.IO.Path]::DirectorySeparatorChar,

        # Truncate character(s). Default is '...'
        # Use '[char]8230' to use the horizontal ellipsis character instead.
        [Parameter()]
        [string] $TruncateChar = '...'
    )

    $Path = (Resolve-Path -Path $Path).Path

    $splitPath = $Path.Split($Separator, [System.StringSplitOptions]::RemoveEmptyEntries)

    if ($splitPath.Count -gt ($KeepBefore + $KeepAfter)) {
      $outPath = [string]::Empty

      for ($i = 0; $i -lt $KeepBefore; $i++) {
        $outPath += $splitPath[$i] + $Separator
      }

      $outPath += "$($TruncateChar)$($Separator)"

      for ($i = ($splitPath.Count - $KeepAfter); $i -lt $splitPath.Count; $i++) {
        if ($i -eq ($splitPath.Count - 1)) {
          $outPath += $splitPath[$i]
        }
        else {
          $outPath += $splitPath[$i] + $Separator
        }
      }
    }

    else {
      $outPath = $splitPath -join $Separator
      if ($splitPath.Count -eq 1) {
        $outPath += $Separator
      }
    }

    Write-Output $outPath
}