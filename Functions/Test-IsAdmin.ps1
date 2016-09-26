function Test-IsAdmin {
    $windowsIdentity=[System.Security.Principal.WindowsIdentity]::GetCurrent()
    $windowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($windowsIdentity)
    $adm=[System.Security.Principal.WindowsBuiltInRole]::Administrator
    Write-Output ($windowsPrincipal.IsInRole($adm))
}