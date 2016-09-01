# Communary.ConsoleExtensions
# Author: Øyvind Kallstad

# read functions
Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Functions') | ForEach-Object {
    Get-ChildItem -Path $_.FullName | ForEach-Object {
        . $_.FullName
    }
}

try {
    Update-PSDriveInfo
    Update-FileInfoType
}
catch {
    Write-Warning $_.Exception.Message
}
