function Invoke-Pause {
    <#
        .SYNOPSIS
            Will pause output of large objects.
        .DESCRIPTION
            This function will stop output of large objects at windows height,
            and lets you continue by pressing any key.
        .EXAMPLE
            Get-Content -Path file.txt | Invoke-Pause
        .EXAMPLE
            Get-Command Get-* | Invoke-Pause
    #>
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true)]
        $InputObject
    )
    
    BEGIN {
        if ($host.Name -eq 'ConsoleHost') {
            $windowHeight = [console]::WindowHeight
            $usableHeight = $windowHeight - 2
            $lines = 0
        }
    }
    
    PROCESS {
        foreach ($item in $InputObject) {
            if ($host.Name -eq 'ConsoleHost') {
             
                $lines++
                
                Write-Output $item
                
                if ($lines -eq $usableHeight) {
                    Write-Host ''
                    Write-Host 'Press any key to continue ...' -NoNewline
                    $x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
                    Write-Host ''
                    $lines = 0
                }
            }
        }
    }
}