# Communary.ConsoleExtensions
# Author: Øyvind Kallstad

Add-Type -MemberDefinition @"
[DllImport("user32.dll")]
public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
"@ -Name 'Win32ShowWindowAsync' -Namespace 'Win32Functions'

Add-Type -MemberDefinition @"
[DllImport("user32.dll")]
public static extern bool IsZoomed(IntPtr hWnd);
"@ -Name 'Win32IsZoomed' -Namespace 'Win32Functions'

# read functions
Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Functions') | ForEach-Object {
    Get-ChildItem -Path $_.FullName | ForEach-Object {
        . $_.FullName
    }
}

try {
    Update-PSDriveInfoType
    Update-FileInfoType
}
catch {
    Write-Warning $_.Exception.Message
}
