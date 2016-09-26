function Write-RGB {
    <#
        .SYNOPSIS
            Write to the console in 24-bit colors!
        .DESCRIPTION
            This function lets you write to the console using 24-bit color depth.
            You can specify colors using its RGB values.
        .EXAMPLE
            Write-RGB 'PowerShell rocks!'
            Will write the text using the default colors.
        .EXAMPLE
            Write-RGB 'PowerShell rocks!' -ForegroundColor ([rgb]::new(255,192,203))
            Will write the text in a pink foreground color.
        .EXAMPLE
            Write-RGB 'PowerShell rocks!' -ForegroundColor ([rgb]::new(255,192,203)) -BackgroundColor ([rgb]::new(128,128,0))
            Will write the text in a pink foreground color and an olive background color.
        .NOTES
            Author: Øyvind Kallstad
            Version: 1.0
            Date: 23.09.2016
        .LINK
            https://communary.net/ 
    #>
    [CmdletBinding()]
    param (
        # The text you want to write.
        [Parameter(Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string] $Text,
        
        # The foreground color of the text. Defaults to white.
        [Parameter(Position = 1)]
        [rgb] $ForegroundColor = [rgb]::new(255,255,255),
        
        # The background color of the text. Defaults to PowerShell Blue.
        [Parameter(Position = 2)]
        [rgb] $BackgroundColor = [rgb]::new(1,36,86),
        
        # No newline after the text.
        [Parameter()]
        [switch] $NoNewLine
    )
    
    if ($PSVersionTable.PSVersion.Build -ge 14931) {

        $escape = [char]27 + '['
        $resetAttributes = "$($escape)0m"
        
        $foreground = "$($escape)38;2;$($ForegroundColor.Red);$($ForegroundColor.Green);$($ForegroundColor.Blue)m"
        $background = "$($escape)48;2;$($BackgroundColor.Red);$($BackgroundColor.Green);$($BackgroundColor.Blue)m"
        
        #Write-Host ($escape + $foreground + $background + $Text + $resetAttributes)
        Write-Host ($foreground + $background + $Text + $resetAttributes) -NoNewline:$NoNewLine
    }

    else {
        Write-Warning "This function will only work with build 14931 or above. Your build version is $($PSVersionTable.PSVersion.Build)"
    }
}