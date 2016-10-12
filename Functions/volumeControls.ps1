function Get-MasterVolume {
    Write-Output ([Math]::Round([CoreAudio.API]::GetMasterVolume(),0))
}

function Set-MasterVolume {
    param([int]$Volume)
    if ($Volume) {
        [CoreAudio.API]::SetMasterVolume($Volume)
    }
}

function Test-MasterVolumeIsMuted {
    [CoreAudio.API]::GetMasterVolumeMute()
}

function Invoke-MuteMasterVolume {
    $res = [CoreAudio.API]::ToggleMasterVolumeMute()
    if ($res) {
        Write-Output 'Master Volume Muted'
    }
    else {
        $vol = Get-MasterVolume
        Write-Output "Master Volume: $($vol)%"
    }
}

function Invoke-MasterVolumeControl {
    if (-not $args) {
        Get-MasterVolume
        break
    }
    switch ($args) {
        'm' {Invoke-MuteMasterVolume;break}
        {$_ -in 1..100} {Set-MasterVolume $_;Write-Output $_;break}
        DEFAULT {Get-MasterVolume}
    }
}

New-Alias -Name 'vol' -Value 'Invoke-MasterVolumeControl' -Force