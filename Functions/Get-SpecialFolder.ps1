function Get-SpecialFolder {
    param ([System.Environment+SpecialFolder] $Name)
    
    if (-not $Name) {
        [Enum]::GetValues([System.Environment+SpecialFolder])
    }
    
    else {
        Write-Output (,([PSCustomObject] @{
                    Name = $Name.ToString()
                    Path = [System.Environment]::GetFolderPath($Name)
        }))
    }    
}