function Invoke-ColorizedFileListing {
    <#
            .SYNOPSIS
                Provides colorized file listing.
            .DESCRIPTION
                This function is a replacement for Get-ChildItem when used to
                list files and folders, and adds colorization of file types
                as well as humanized dates and file sizes.
            .EXAMPLE
                Invoke-ColorizedFileListing
                Will list the contents of the current folder.
            .EXAMPLE
                Invoke-ColorizedFileListing c:\ -Force
                Will list all contents of c:\, including hidden files.
            .EXAMPLE
                Get-ChildItem c:\windows\*.log | Invoke-ColorizedFileListing
                Will list all log files in the c:\windows directory.
            .NOTES
                Author: Øyvind Kallstad
                Version: 1.0
                Date: 31.08.2016
                Dependencies:  PowerShellHumanizer
    #>
    [CmdletBinding(DefaultParameterSetName = 'Path')]
    param (
        # Path. Will be forwarded to Get-ChildItem. Default value is '.'
        [Parameter(ParameterSetName = 'Path', Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string] $Path = '.',
        
        # If Path is not used, you can pass in a FileSystemInfo object through the pipeline.
        [Parameter(ParameterSetName = 'Object', ValueFromPipeline = $true)]
        [System.IO.FileSystemInfo[]] $FileSystemInfo,
        
        # Will also list hidden files.  Will be forwarded to Get-ChildItem.
        [Parameter(ParameterSetName = 'Path')]
        [switch] $Force,
        
        # Pause file listing if the results are longer than the window height.
        [Parameter()]
        [Alias('p')]
        [switch] $Pause,
        
        # Show file owner.
        [Parameter()]
        [Alias('owner')]
        [switch] $ShowOwner,
        
        [Parameter()]
        [Alias('parent','directory','d')]
        [switch] $ShowParentDirectory,
        
        # Files that match this filter will be highlighted in red.
        [Parameter()]
        [Alias('m')]
        [string] $Highlight = [string]::Empty,

        # Show size on disk.
        [Parameter()]
        [Alias('s')]
        [switch] $ShowSizeOnDisk
    )
    
    BEGIN {
        # Colors
        $directoryColor = 'Yellow'
        $documentColor = 'Cyan'
        $executableColor = 'Magenta'
        $logColor = 'DarkCyan'
        $hiddenColor = 'DarkGray'
        $modeColor = 'Gray'
        $compressedColor = 'Green'
        $highlightColor = 'Red'
        $defaultColor = 'White'
        
        if (-not(Get-Module -Name 'PowerShellHumanizer' -ListAvailable -Verbose:$false)) {
            Write-Warning 'This function depends on the module PowerShellHumanizer.'
            Write-Warning 'Please run "Install-Module -Name PowerShellHumanizer -Scope CurrentUser" to install the missing module.'
            break
        }
        else {
            if (-not(Get-Module -Name 'PowerShellHumanizer')) {
                try {
                    Write-Verbose 'Importing PowerShellHumanizer'
                    Import-Module -Name 'PowerShellHumanizer' -Force
                }
                catch {
                    Write-Warning $_.Exception.Message
                    break
                }
            }
        }
        
        # Since we need the window height for the pause function
        # it will only work when in the console.
        if (($host.Name -eq 'ConsoleHost') -and ($Pause)) {
            $windowHeight = [console]::WindowHeight
            $usableHeight = $windowHeight - 2
            $lines = 0
        }
    }
    
    PROCESS {
        foreach ($FileSystemInfoItem in $FileSystemInfo) {
            [array]$files += $FileSystemInfoItem
        }
    }
    
    END {
    
        if ($PSCmdlet.ParameterSetName -eq 'Path') {
            [array]$files = Get-ChildItem -Path $Path -Force:$Force -ErrorAction SilentlyContinue
        }
        
        if ($ShowParentDirectory) {
            Write-Host ''
            Write-Host "    Directory: $(($files.Where({-not $_.PSIsContainer})[0]).DirectoryName)"
            Write-Host ''
        }
        else {
            Write-Host ''
        }
    
        foreach ($file in $files) {
        
            # Only supported for files and folders.
            if (-not ($file.PSProvider.Name -eq 'FileSystem')) {
                break
            }
    
            $fileOwner = [String]::Empty
            $fileSizeValue = [string]::Empty
            $fileSizeUnit = [string]::Empty
            $fileSizeOnDiskValue = [string]::Empty
            $fileSizeOnDiskUnit = [string]::Empty
    
            # File
            if (-not $file.PSIsContainer) {
            
                $fileSize = [Humanizer.ByteSizeExtensions]::bytes($file.Length).ToString(0.00)
                $fileSizeSplit = $fileSize.split(' ')
                $fileSizeUnit = ($fileSizeSplit[-1][0]).ToString()
                $fileSizeValue = $fileSizeSplit[0]

                if (($ShowSizeOnDisk) -and (-not $file.PSIsContainer)) {
                    $fileSizeOnDisk = [Humanizer.ByteSizeExtensions]::bytes($file.SizeOnDisk).ToString(0.00)
                    $fileSizeOnDiskSplit = $fileSizeOnDisk.split(' ')
                    $fileSizeOnDiskUnit = ($fileSizeOnDiskSplit[-1][0]).ToString()
                    $fileSizeOnDiskValue = $fileSizeOnDiskSplit[0]
                }

                switch ($file.Extension) {
                    '.ps1'  {$color = $executableColor}
                    '.exe'  {$color = $executableColor}
                    '.cmd'  {$color = $executableColor}
                    '.com'  {$color = $executableColor}
                    '.bat'  {$color = $executableColor}
                    '.vbs'  {$color = $executableColor}
                    '.log'  {$color = $logColor}
                    '.txt'  {$color = $documentColor}
                    '.doc'  {$color = $documentColor}
                    '.docx' {$color = $documentColor}
                    '.zip'  {$color = $compressedColor}
                    '.7z'   {$color = $compressedColor}
                    '.rar'  {$color = $compressedColor}
                    '.tar'  {$color = $compressedColor}
                    DEFAULT {$color = $defaultColor}
                }
            
            }
        
            # Directory
            else {
                $color = $directoryColor
            }
        
            # If file is hidden, overwrite the color with the color for hidden files.
            if ($file.Attributes.HasFlag([System.IO.FileAttributes]::Hidden)) {
                $color = $hiddenColor
            }
            else {
                try {
                    if ($ShowOwner) {
                        $fileOwner = ((Get-Acl -Path $file.FullName).Owner).Split('\')[-1]
                    }
                }
                catch {} # if this doesn't work, just silently ignore it.
            }
            
            $lastWriteTimeHumanized = $file.LastWriteTime.Humanize()
            $lastWriteTimeHumanizedSplit = $lastWriteTimeHumanized.split(' ')
            if ($lastWriteTimeHumanizedSplit.count -eq 3) {
                $timeNumber = $lastWriteTimeHumanizedSplit[0]
                $timeUnit = $lastWriteTimeHumanizedSplit[1]
                if (($timeNumber -eq 'an') -or ($timeNumber -eq 'one') -or ($timeNumber -eq 'a')) {
                    $timeNumber = '1'
                }
            }
            elseif ($lastWriteTimeHumanized -eq 'yesterday') {
                $timeNumber = '1'
                $timeUnit = 'day'
            }
            
            # Highligh
            if ($Highlight) {
                if ($file.Name -like $Highlight) {
                    $color = $highlightColor
                }
            }
        
            # Write output
            Write-Host "$($file.Mode)" -ForegroundColor $modeColor -NoNewline
            if ($ShowOwner) {
                Write-Host "  $($fileOwner.PadRight(17,' '))  " -NoNewline
            }
            Write-Host " $($timeNumber.PadLeft(3, ' ')) $($timeUnit.PadRight(8, ' ')) $($fileSizeValue.PadLeft(5,' ')) $($fileSizeUnit.PadRight(3,' '))" -NoNewline -ForegroundColor $defaultColor
            if ($ShowSizeOnDisk) {
                Write-Host "$($fileSizeOnDiskValue.PadLeft(5, ' ')) $($fileSizeOnDiskUnit.PadRight(3,' '))" -NoNewline -ForegroundColor $modeColor
            }
            Write-Host "$($file.Name)" -ForegroundColor $color
            
            if (($host.Name -eq 'ConsoleHost') -and ($Pause)) {
                $lines++
                
                if ($lines -eq $usableHeight) {
                    Write-Host ''
                    Write-Host 'Press any key to continue ...' -NoNewline
                    $x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
                    Write-Host ''
                    $lines = 0
                }
            }
        }
    
        Write-Host ''
    }
}

New-Alias -Name 'c' -Value 'Invoke-ColorizedFileListing' -Force