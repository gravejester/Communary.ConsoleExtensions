[![Build status](https://ci.appveyor.com/api/projects/status/5m4gq1x3ume2qadj?svg=true)](https://ci.appveyor.com/project/gravejester/communary-consoleextensions)

# Communary.ConsoleExtensions
A set of helper functions for working in the PowerShell console.

## Functions
- Get-SpecialFolder
- Invoke-ColorizedFileListing (alias: 'c')
- Invoke-Pause (alias: 'pause')
- Invoke-Touch (alias: 'touch')
- Resize-Console
- Get-ConsoleSize
- Get-WindowState
- Show-Calendar (alias: 'cal')
- Invoke-Highlight (alias: 'highlight)
- Invoke-PathShortener
- Write-RGB
- Test-IsAdmin
- Set-Prompt
- Set-PowerlinePrompt
- Get-MasterVolume
- Set-MasterVolume
- Test-MasterVolumeIsMuted
- Invoke-MuteMasterVolume
- Invoke-MasterVolumeControl (alias: 'vol')

The module also includes a custom formats data file that includes colorization and customization to the standard file listing using Get-ChildItem (alias 'ls' and 'dir').

Four global variables are also included:
- colors (List of predefined colors)
- psFileColors (Defines the different colors used in the colorization of files and folders)
- psFormatsOptions (Options for the custom formats file - used to turn on/off humanizing Date and Size)
- originalPrompt (copy of the prompt at the time of loading this module)

## Installation
```powershell
Install-Module -Name Communary.ConsoleExtensions -Scope CurrentUser
```

## Dependencies
To get the most out of this module, the following PowerShell modules should also be installed:
- PowerShellHumanizer
- PSGit

You should also install a powerline font if you want to get the full benefit of the Set-PowerlinePrompt function.

---

See my [blog post](https://communary.net/2016/09/10/communary-consoleextensions/) about the module for examples of how to use the different functions.