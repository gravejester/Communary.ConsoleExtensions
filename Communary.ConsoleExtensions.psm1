# Communary.ConsoleExtensions
# Author: Øyvind Kallstad

class RGB {
    [ValidateRange(0,255)]
    [int] $Red
    [ValidateRange(0,255)]
    [int] $Green
    [ValidateRange(0,255)]
    [int] $Blue
    
    RGB() {}
    
    RGB($r,$g,$b) {
        $this.Red = $r
        $this.Green = $g
        $this.Blue = $b
    }
    
    [string] ToString() {
        return "$($this.Red),$($this.Green),$($this.Blue)"
    }
}

$global:colors = @{
    Red = [rgb]::new(255,0,0)
    DarkRed = [rgb]::new(128,0,0)
    Green = [rgb]::new(0,255,0)
    DarkGreen = [rgb]::(0,128,0)
    Blue = [rgb]::new(0,0,255)
    DarkBlue = [rgb]::new(0,0,128)
    White = [rgb]::new(255,255,255)
    Black = [rgb]::new(0,0,0)
    Yellow = [rgb]::new(255,255,0)
    DarkGray = [rgb]::new(128,128,128)
    Gray = [rgb]::new(192,192,192)
    LightGray = [rgb]::new(238,237,240)
    Cyan = [rgb]::new(0,255,255)
    DarkCyan = [rgb]::new(0,128,128)
    Magenta = [rgb]::new(255,0,255)
    PSBlue = [rgb]::new(1,36,86)
    AliceBlue = [rgb]::new(240,248,255)
    AntiqueWhite = [rgb]::new(250,235,215)
    AquaMarine = [rgb]::new(127,255,212)
    Azure = [rgb]::new(240,255,255)
    Beige = [rgb]::new(245,245,220)
    Bisque = [rgb]::new(255,228,196)
    BlanchedAlmond = [rgb]::new(255,235,205)
    BlueViolet = [rgb]::new(138,43,226)
    Brown = [rgb]::new(165,42,42)
    Burlywood = [rgb]::new(222,184,135)
    CadetBlue = [rgb]::new(95,158,160)
    Chartreuse = [rgb]::new(127,255,0)
    Chocolate = [rgb]::new(210,105,30)
    Coral = [rgb]::new(255,127,80)
    CornflowerBlue = [rgb]::new(100,149,237)
    CornSilk = [rgb]::new(255,248,220)
    Crimson = [rgb]::new(220,20,60)
    DarkGoldenrod = [rgb]::new(184,134,11)
    DarkKhaki = [rgb]::new(189,183,107)
    DarkMagenta = [rgb]::new(139,0,139)
    DarkOliveGreen = [rgb]::new(85,107,47)
    DarkOrange = [rgb]::new(255,140,0)
    DarkOrchid = [rgb]::new(153,50,204)
    DarkSalmon = [rgb]::new(233,150,122)
    DarkSeaGreen = [rgb]::new(143,188,143)
    DarkSlateBlue = [rgb]::new(72,61,139)
    DarkSlateGray = [rgb]::new(47,79,79)
    DarkTurquoise = [rgb]::new(0,206,209)
    DarkViolet = [rgb]::new(148,0,211)
    DeepPink = [rgb]::new(255,20,147)
    DeepSkyBlue = [rgb]::new(0,191,255)
    DimGray = [rgb]::new(105,105,105)
    DodgerBlue = [rgb]::new(30,144,255)
    FireBrick = [rgb]::new(178,34,34)
    FloralWhite = [rgb]::new(255,250,240)
    ForestGreen = [rgb]::new(34,139,34)
    GainsBoro = [rgb]::new(220,220,220)
    GhostWhite = [rgb]::new(248,248,255)
    Gold = [rgb]::new(255,215,0)
    Goldenrod = [rgb]::new(218,165,32)
    GreenYellow = [rgb]::new(173,255,47)
    HoneyDew = [rgb]::new(240,255,240)
    HotPink = [rgb]::new(255,105,180)
    IndianRed = [rgb]::new(205,92,92)
    Indigo = [rgb]::new(75,0,130)
    Ivory = [rgb]::new(255,255,240)
    Khaki = [rgb]::new(240,230,140)
    Lavender = [rgb]::new(230,230,250)
    LavenderBlush = [rgb]::new(255,240,245)
    LawnGreen = [rgb]::new(124,252,0)
    LemonChiffon = [rgb]::new(255,250,205)
    LightBlue = [rgb]::new(173,216,230)
    LightCoral = [rgb]::new(240,128,128)
    LightCyan = [rgb]::new(224,255,255)
    LightGoldenrodYellow = [rgb]::new(250,250,210)
    LightPink = [rgb]::new(255,182,193)
    LightSalmon = [rgb]::new(255,160,122)
    LightSeaGreen = [rgb]::new(32,178,170)
    LightSkyBlue = [rgb]::new(135,206,250)
    LightSlateGray = [rgb]::new(119,136,153)
    LightSteelBlue = [rgb]::new(176,196,222)
    LightYellow = [rgb]::new(255,255,224)
    LimeGreen = [rgb]::new(50,205,50)
    Linen = [rgb]::new(250,240,230)
    MediumAquaMarine = [rgb]::new(102,205,170)
    MediumOrchid = [rgb]::new(186,85,211)
    MediumPurple = [rgb]::new(147,112,219)
    MediumSeaGreen = [rgb]::new(60,179,113)
    MediumSlateBlue = [rgb]::new(123,104,238)
    MediumSpringGreen = [rgb]::new(0,250,154)
    MediumTurquoise = [rgb]::new(72,209,204)
    MediumVioletRed = [rgb]::new(199,21,133)
    MidnightBlue = [rgb]::new(25,25,112)
    MintCream = [rgb]::new(245,255,250)
    MistyRose = [rgb]::new(255,228,225)
    Moccasin = [rgb]::new(255,228,181)
    NavajoWhite = [rgb]::new(255,222,173)
    OldLace = [rgb]::new(253,245,230)
    Olive = [rgb]::new(128,128,0)
    OliveDrab = [rgb]::new(107,142,35)
    Orange = [rgb]::new(255,165,0)
    OrangeRed = [rgb]::new(255,69,0)
    Orchid = [rgb]::new(218,112,214)
    PaleGoldenrod = [rgb]::new(238,232,170)
    PaleGreen = [rgb]::new(152,251,152)
    PaleTurquoise = [rgb]::new(175,238,238)
    PaleVioletRed = [rgb]::new(219,112,147)
    PapayaWhip = [rgb]::new(255,239,213)
    PeachPuff = [rgb]::new(255,218,185)
    Peru = [rgb]::new(205,133,63)
    Pink = [rgb]::new(255,192,203)
    Plum = [rgb]::new(221,160,221)
    PowderBlue = [rgb]::new(176,224,230)
    Purple = [rgb]::new(128,0,128)
    RosyBrown = [rgb]::new(188,143,143)
    RoyalBlue = [rgb]::new(65,105,225)
    SaddleBrown = [rgb]::new(139,69,19)
    Salmon = [rgb]::new(250,128,114)
    SandyBrown = [rgb]::new(244,164,96)
    SeaGreen = [rgb]::new(46,139,87)
    SeaShell = [rgb]::new(255,245,238)
    Sienna = [rgb]::new(160,82,45)
    SkyBlue = [rgb]::new(135,206,235)
    SlateBlue = [rgb]::new(106,90,205)
    SlateGray = [rgb]::new(112,128,144)
    Snow = [rgb]::new(255,250,250)
    SpringGreen = [rgb]::new(0,255,127)
    SteelBlue = [rgb]::new(70,130,180)
    Tan = [rgb]::new(210,180,140)
    Thistle = [rgb]::new(216,191,216)
    Tomato = [rgb]::new(255,99,71)
    Turquoise = [rgb]::new(64,224,208)
    Violet = [rgb]::new(238,130,238)
    Wheat = [rgb]::new(245,222,179)
    WhiteSmoke = [rgb]::new(245,245,245)
    YellowGreen = [rgb]::new(154,205,50)
}

$Global:psFileColors = @{
    Directories = [rgb]::new(236,208,120)
    Applications = [rgb]::new(246,114,128)
    Scripts = [rgb]::new(192,108,132)
    Modules = [rgb]::new(0,191,255)
    DataFiles = [rgb]::new(210,105,30)
    TextFiles = [rgb]::new(81,149,72)
    LogFiles = [rgb]::new(22,147,167)
    ConfigFiles = [rgb]::new(221,160,221)
    Documents = [rgb]::new(255,222,173)
    CompressedFiles = [rgb]::new(124,252,0)
    Hidden = [rgb]::new(105,105,105)
    DumpFiles = [rgb]::new(255,69,0)
    ReparsePoints = [rgb]::new(248,248,255)
}

$Global:psFormatsOptions = @{
    HumanizerInstalled = $false
    HumanizeDate = $false
    HumanizeSize = $false
}

if (Get-Module -Name PowerShellHumanizer -ListAvailable) {
    $Global:psFormatsOptions.HumanizerInstalled = $true
    Import-Module -Name PowerShellHumanizer
}

if (-not ([System.Management.Automation.PSTypeName]'Win32Functions.Win32ShowWindowAsync').Type) {
    Add-Type -MemberDefinition @"
[DllImport("user32.dll")]
public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
"@ -Name 'Win32ShowWindowAsync' -Namespace 'Win32Functions'
}

if (-not ([System.Management.Automation.PSTypeName]'Win32Functions.Win32IsZoomed').Type) {
    Add-Type -MemberDefinition @"
[DllImport("user32.dll")]
public static extern bool IsZoomed(IntPtr hWnd);
"@ -Name 'Win32IsZoomed' -Namespace 'Win32Functions'
}

# Found at http://stackoverflow.com/a/16926224/3940558
if (-not ([System.Management.Automation.PSTypeName]'System.Win32').Type) {
    Add-Type -MemberDefinition @"
private const int FILE_SHARE_READ = 1;
private const int FILE_SHARE_WRITE = 2;

private const int CREATION_DISPOSITION_OPEN_EXISTING = 3;
private const int FILE_FLAG_BACKUP_SEMANTICS = 0x02000000;

[DllImport("kernel32.dll", EntryPoint = "GetFinalPathNameByHandleW", CharSet = CharSet.Unicode, SetLastError = true)]
 public static extern int GetFinalPathNameByHandle(IntPtr handle, [In, Out] StringBuilder path, int bufLen, int flags);

[DllImport("kernel32.dll", EntryPoint = "CreateFileW", CharSet = CharSet.Unicode, SetLastError = true)]
 public static extern SafeFileHandle CreateFile(string lpFileName, int dwDesiredAccess, int dwShareMode,
 IntPtr SecurityAttributes, int dwCreationDisposition, int dwFlagsAndAttributes, IntPtr hTemplateFile);

 public static string GetSymbolicLinkTarget(System.IO.DirectoryInfo symlink)
 {
     SafeFileHandle directoryHandle = CreateFile(symlink.FullName, 0, 2, System.IntPtr.Zero, CREATION_DISPOSITION_OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, System.IntPtr.Zero);
     if(directoryHandle.IsInvalid)
     throw new Win32Exception(Marshal.GetLastWin32Error());

     StringBuilder path = new StringBuilder(512);
     int size = GetFinalPathNameByHandle(directoryHandle.DangerousGetHandle(), path, path.Capacity, 0);
     if (size<0)
     throw new Win32Exception(Marshal.GetLastWin32Error());
     // The remarks section of GetFinalPathNameByHandle mentions the return being prefixed with "\\?\"
     // More information about "\\?\" here -> http://msdn.microsoft.com/en-us/library/aa365247(v=VS.85).aspx
     if (path[0] == '\\' && path[1] == '\\' && path[2] == '?' && path[3] == '\\')
     return path.ToString().Substring(4);
     else
     return path.ToString();
 }
"@ -Name Win32 -NameSpace System -UsingNamespace System.Text,Microsoft.Win32.SafeHandles,System.ComponentModel

}

# read functions
Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Functions') | ForEach-Object {
    Get-ChildItem -Path $_.FullName | ForEach-Object {
        . $_.FullName
    }
}

try {
    Update-PSDriveInfoType
    Update-FileInfoType
}
catch {
    Write-Warning $_.Exception.Message
}

Update-FormatData -PrependPath (Join-Path -Path $PSScriptRoot -ChildPath 'customFormats.ps1xml')