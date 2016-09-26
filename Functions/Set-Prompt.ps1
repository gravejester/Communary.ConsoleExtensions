function Set-Prompt {
    param ([ScriptBlock] $ScriptBlock)
    $null = New-Item -Path function:prompt -Value $ScriptBlock -Force
}