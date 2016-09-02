function Invoke-Highlight {
    <#
        .SYNOPSIS
            Highlight patterns in string(s).
        .DESCRIPTION
            This function will let you define a regular expression pattern and
            highlight matches in a string or string array.
        .EXAMPLE
            Get-Content .\file.txt | Invoke-Highlight error
            Will output the contents of .\file.txt and highlight all occurences of 'error'
        .NOTES
            Author: Øyvind Kallstad
            Date: 02.09.2016
            Version: 1.0
    #>
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true)]
        [string[]]$InputObject,
        
        # Specifies the text you want to highlight, as a regular expression.
        [Parameter(Position = 0)]
        [string] $Pattern,
        
        # Makes matches case-sensitive. By default, matches are not case-sensitive.
        [Parameter()]
        [switch] $CaseSensitive
    )
    
    PROCESS {
        foreach ($item in $InputObject) {
        
            # Get matches
            $match = $item | Select-String -Pattern $Pattern -AllMatches -CaseSensitive:$CaseSensitive
            
            # Set initial index
            $index = 0
            
            # Loop through matches
            foreach ($matchItem in ($match.Matches | Sort-Object -Property Index)) {
                
                # Before match
                $thisLength = $matchItem.Index - $index
                Write-Host $item.SubString($index,$thisLength) -NoNewline
                
                # Match
                Write-Host $item.SubString($matchItem.Index,$matchItem.Length) -ForegroundColor Red -NoNewline
                
                # Calculate new index
                $index = $matchItem.Index + $matchItem.Length
                
            }
            
            # Write the rest of the line
            $thisLength = $item.ToCharArray().Length - $index
            Write-Host $item.SubString($index,$thisLength)
            
         }
    }
}

New-Alias -Name 'highlight' -Value 'Invoke-Highlight' -force