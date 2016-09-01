function Resolve-PathEx {
    <#
        .SYNOPSIS
            Resolve-Path extended to also work with files that don't exist.
        .DESCRIPTION
            You can use Resolve-PathEx when you want to handle both filenames and paths in a single parameter in your functions.
            The function returns an object, and includes the resolved path as well as a boolean indicating whether the file
            exists or not. Wildcards are supported for both path and filename.
        .EXAMPLE
            Resolve-Path *.ps1
            Will resolve full path of all files in the current directory with the ps1 file extension.
        .EXAMPLE
            Resolve-PathEx c:\program*\windows*\w*.exe
            Will resolve full path of all exe files beginning with w in any folders of the root of C: that starts with 'progra',
            and all subfolders of these that start with 'windows'.
        .EXAMPLE
            Resolve-Path
            Will resolve the current path.
        .EXAMPLE
            Resolve-Path nosuchfile.txt
            Will resolve the full path of the file, even though it doesn't exist.
        .LINK
            https://gist.github.com/gravejester/a5c8407fcf5fb16a356a
        .NOTES
            Author: Øyvind Kallstad
            Date: 13.11.2014
            Version: 1.0
    #>
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, ValueFromPipeline, ValueFromPipelinebyPropertyName)]
        [string[]] $Path = '.\'
    )
 
    PROCESS{
        foreach ($thisPath in $Path) {
            try {
                # first try to resolve using the whole path
                [array]$resolvedPath += (Resolve-Path -Path $thisPath -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Path)
 
                # if that didn't work, split to get the path only
                if ([string]::IsNullOrEmpty($resolvedPath)) {
                    $pathOnly = Split-Path $thisPath
                    # if no path returned, add current directory as path
                    if ([string]::IsNullOrEmpty($pathOnly)) {
                        $pathOnly = '.\'
                    }
                    # try to resolve again using only the path
                    $pathOnlyResolve = (Resolve-Path -Path $pathOnly -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Path)
                    # if successfull
                    if (-not([string]::IsNullOrEmpty($pathOnlyResolve))) {
                        # add the path and the filename back together
                        foreach ($p in $pathOnlyResolve) {
                            $pathAndFile = Join-Path -Path $p -ChildPath (Split-Path -Path $thisPath -Leaf)
                            $exists = Test-Path $pathAndFile
                            Write-Output (,([PSCustomObject] [Ordered] @{
                                Path = $pathAndFile
                                Exists = $exists
                            }))
                        }
                    }
                    # if we still are unable to resolve, the path most likely don't exist
                    else {
                        Write-Warning "Unable to resolve $pathOnly"
                    }
                }
                else {
                    foreach ($item in $resolvedPath) {
                        $exists = Test-Path $item
                        Write-Output (,([PSCustomObject] [Ordered] @{
                            Path = $item
                            Exists = $exists
                        }))
                    }   
                }
            }
 
            catch {
                Write-Warning $_.Exception.Message
            }
        }
    }
}