function Resize-Console {
    <#
        .SYNOPSIS
            Resize the PowerShell console programmatically.
        .DESCRIPTION
            This function lets you resize the PowerShell console window by setting
            custom width and height properties, as well as maximize and restore the
            console window.
        .EXAMPLE
            Resize-Console 200 50
        .EXAMPLE
            Resize-Console -Maximize
        .EXAMPLE
            Resize-Console -Restore
        .EXAMPLE
            if (Get-WindowState -eq 'Normal') {Resize-Console -Maximize}
        .NOTES
            Author: Øyvind Kallstad
            Date: 11.10.2015
            Version: 1.0
        .LINK
            https://communary.wordpress.com/
    #>
    [CmdletBinding(DefaultParameterSetName = 'CustomSize')]
    param (
        # Set the window width.
        [Parameter(ParameterSetName = 'CustomSize', Position = 0)]
        [ValidateRange(1,[int]::MaxValue)]
        [int] $Width = $host.UI.RawUI.WindowSize.Width,

        # Set the window height.
        [Parameter(ParameterSetName = 'CustomSize', Position = 1)]
        [ValidateRange(1,[int]::MaxValue)]
        [int] $Height = $host.UI.RawUI.WindowSize.Height,

        # Maximize the window.
        [Parameter(ParameterSetName = 'Maximize')]
        [switch] $Maximize,

        # Restore the window (if maximized).
        [Parameter(ParameterSetName = 'Restore')]
        [switch] $Restore
    )

    if(($PSCmdlet.ParameterSetName -eq 'Maximize') -or ($PSCmdlet.ParameterSetName -eq 'Restore')) {

        # get main window handle of the current process
        $MainWindowHandle = (Get-Process -id $pid).MainWindowHandle

        if ($Maximize) {
            [Win32Functions.Win32ShowWindowAsync]::ShowWindowAsync($MainWindowHandle, 3) | Out-Null
        }

        if ($Restore) {
            [Win32Functions.Win32ShowWindowAsync]::ShowWindowAsync($MainWindowHandle, 9) | Out-Null
        }
    }

    else {
        if ($host.Name -eq 'ConsoleHost') {
            # buffer size can't be smaller than window size
            if ($Width -gt $host.UI.RawUI.BufferSize.Width) {
                $host.UI.RawUI.BufferSize = New-Object -TypeName System.Management.Automation.Host.Size -ArgumentList ($Width, $host.UI.RawUI.BufferSize.Height)
            }

            # if width is too large, set to max allowed size
            if ($Width -gt $host.UI.RawUI.MaxPhysicalWindowSize.Width) {
                $Width = $host.UI.RawUI.MaxPhysicalWindowSize.Width
            }

            # if height is too large, set to max allowed size
            if ($Height -gt $host.UI.RawUI.MaxPhysicalWindowSize.Height) {
                $Height = $host.UI.RawUI.MaxPhysicalWindowSize.Height
            }

            # set window size
            $host.UI.RawUI.WindowSize = New-Object -TypeName System.Management.Automation.Host.Size -ArgumentList ($Width, $Height)
        }
        
        else {
            Write-Warning 'Setting the console window size is only supported when running in the console host.'
        }
    }
}

function Get-ConsoleSize {
    Write-Output ($host.UI.RawUI.WindowSize)
}

function Get-WindowState {
    if ([Win32Functions.Win32IsZoomed]::IsZoomed(((Get-Process -id $pid).MainWindowHandle))) {
        Write-Output 'Maximized'
    }
    else {
        Write-Output 'Normal'
    }
}