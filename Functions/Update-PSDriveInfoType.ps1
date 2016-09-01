function Update-PSDriveInfoType {
    <#
        Update PSDriveInfo type to include BlockSize
        Author: Øyvind Kallstad
    #>
    $typeData = Get-TypeData System.Management.Automation.PSDriveInfo
    $scriptBlock = {
        if ($this.Provider.ImplementingType -eq [Microsoft.PowerShell.Commands.FileSystemProvider]) {
            $driveRoot = ([System.IO.DirectoryInfo] $this.Root).Name.Replace('\','\\')
            (Get-WmiObject -Query "SELECT BlockSize FROM Win32_Volume WHERE Name='$driveRoot'").BlockSize
        }
    }
    $scriptProperty = New-Object System.Management.Automation.Runspaces.ScriptPropertyData 'BlockSize', $scriptBlock
    if (-not($typeData.Members['BlockSize'])) {
        $typeData.Members.Add('BlockSize', $scriptProperty)
    }
    Update-TypeData $typeData -Force
}