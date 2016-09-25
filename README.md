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

The module also includes a custom formats data file that includes colorization and customization to the standard file listing using Get-ChildItem (alias 'ls' and 'dir').

Three global variables are also included:
- colors (List of predefined colors)
- psFileColors (Defines the different colors used in the colorization of files and folders)
- psFormatsOptions (Options for the custom formats file - used to turn on/off humanizing Date and Size)

## Installation
```ps
Install-Module -Name Communary.ConsoleExtensions -Scope CurrentUser
```

See also my [blog post](https://communary.net/2016/09/10/communary-consoleextensions/) about the module for examples of how to use the different functions.