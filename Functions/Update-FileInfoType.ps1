function Update-FileInfoType {
    <#
        Update FileInfo type to include SizeOnDisk
        Author: Øyvind Kallstad
    #>
    $typeData = Get-TypeData System.IO.FileInfo
    $scriptBlock = {
        $blockSize = $this.PSDrive.BlockSize
        $size = $this.Length
        [math]::Ceiling($size/$blockSize) * $blockSize
    }
    $scriptProperty = New-Object System.Management.Automation.Runspaces.ScriptPropertyData 'SizeOnDisk', $scriptBlock
    if (-not($typeData.Members['SizeOnDisk'])) {
        $typeData.Members.Add('SizeOnDisk', $scriptProperty)
    }
    Update-TypeData $typeData -Force
}