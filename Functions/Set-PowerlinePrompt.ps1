function Set-PowerlinePrompt {
    $global:branchSymbol = [char]57504
    $global:dividerSymbolFull = [char]57520
    $global:arrowUpSymbol = [char]42779
    $global:arrowDownSymbol = [char]42780
    $global:isAdmin = Test-IsAdmin

    if (Get-Module -Name 'psgit' -ListAvailable) {

        $customPrompt = {
            $currentLocation = $executionContext.SessionState.Path.CurrentLocation.ToString()
            $host.UI.RawUI.WindowTitle = $currentLocation

            if ([bool]($gitStatus = Get-GitStatus -WarningAction SilentlyContinue)) {
                $branch = $gitStatus.Branch
                if ($isAdmin) {
                    Write-Host " $($branchSymbol) $($branch) " -NoNewline -BackgroundColor DarkRed
                    Write-Host $dividerSymbolFull -NoNewline -ForegroundColor DarkRed -BackgroundColor Gray
                }
                else {
                    Write-Host " $($branchSymbol) $($branch) " -NoNewline -BackgroundColor DarkGray
                    Write-Host $dividerSymbolFull -NoNewline -ForegroundColor DarkGray -BackgroundColor Gray
                }
            }
            else {
                if (Test-Path variable:/PSDebugContext) {
                    Write-Host ' DBG ' -NoNewline -BackgroundColor DarkGray -ForegroundColor DarkRed
                    Write-Host $dividerSymbolFull -NoNewline -ForegroundColor DarkGray -BackgroundColor Gray
                } 
                elseif($isAdmin){
                    Write-Host " $($env:COMPUTERNAME) " -NoNewLine -BackgroundColor DarkRed
                    Write-Host $dividerSymbolFull -NoNewline -ForegroundColor DarkRed -BackgroundColor Gray
                }
                else{
                    Write-Host " $($env:COMPUTERNAME) " -NoNewLine -BackgroundColor DarkGray
                    Write-Host $dividerSymbolFull -NoNewline -ForegroundColor DarkGray -BackgroundColor Gray
                }
            }
            Write-Host "$(Invoke-PathShortener -Path $currentLocation) " -NoNewLine -BackgroundColor Gray -ForegroundColor Black
            
            if ([bool]$gitStatus) {
                if ([bool]([array]$gitChange = Get-GitChange)) {
                    Write-Host $dividerSymbolFull -NoNewline -ForegroundColor Gray -BackgroundColor DarkRed
                    
                    if (($gitStatus.Ahead -gt 0) -or ($gitStatus.Behind -gt 0)) {
                        Write-Host "$($arrowUpSymbol)$($gitStatus.Ahead) $($arrowDownSymbol)$($gitStatus.Behind) " -BackgroundColor DarkRed -NoNewline
                    }
                    
                    Write-Host "+$(($gitChange.Where({$_.Change -eq 'Added'})).Count) ~$(($gitChange.Where({$_.Change -eq 'Modified'})).Count) -$(($gitChange.Where({$_.Change -eq 'Removed'})).Count) " -NoNewline -BackgroundColor DarkRed
                    Write-Host $dividerSymbolFull -NoNewline -ForegroundColor DarkRed
                }
                elseif (($gitStatus.Ahead -gt 0) -or ($gitStatus.Behind -gt 0)) {
                    Write-Host $dividerSymbolFull -NoNewline -ForegroundColor Gray -BackgroundColor DarkGreen
                    Write-Host "$($arrowUpSymbol)$($gitStatus.Ahead) $($arrowDownSymbol)$($gitStatus.Behind) " -BackgroundColor DarkGreen -NoNewline
                    Write-Host $dividerSymbolFull -NoNewline -ForegroundColor DarkGreen
                }
                else {
                    Write-Host $dividerSymbolFull -NoNewline -ForegroundColor Gray
                }
            }
            else {
                Write-Host $dividerSymbolFull -NoNewline -ForegroundColor Gray
            }

            return ' '
        }
        Set-Prompt -ScriptBlock $customPrompt
    }
}