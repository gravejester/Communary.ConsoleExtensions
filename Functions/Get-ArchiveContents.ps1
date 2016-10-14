Add-Type -AssemblyName System.IO.Compression.FileSystem

function Get-ArchiveContents {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, Mandatory = $true)]
        [string] $Path
    )
    $Path = Resolve-Path -Path $Path
    $contents = [System.IO.Compression.ZipFile]::OpenRead($Path)
    $contents.Entries | Select-Object FullName, LastWriteTime, CompressedLength,Length
    $contents.Dispose()
}

New-Alias -Name 'peek' -Value 'Get-ArchiveContents' -Force