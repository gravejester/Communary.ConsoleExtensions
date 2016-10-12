# Communary.ConsoleExtensions
# Author: Øyvind Kallstad

$global:originalPrompt = (Get-Item function:prompt).ScriptBlock

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

if (-not ([System.Management.Automation.PSTypeName]'CoreAudio.API').Type) {
    # C# Code liftet from Sverrir Sigmundarson (blog: https://blog.sverrirs.com/2016/02/windows-coreaudio-api-in-c.html)
Add-Type -MemberDefinition @"
/// <summary>
/// Gets the current master volume in scalar values (percentage)
/// </summary>
/// <returns>-1 in case of an error, if successful the value will be between 0 and 100</returns>
public static float GetMasterVolume()
{
    IAudioEndpointVolume masterVol = null;
    try
    {
        masterVol = GetMasterVolumeObject();
        if (masterVol == null)
            return -1;

        float volumeLevel;
        masterVol.GetMasterVolumeLevelScalar(out volumeLevel);
        return volumeLevel*100;
    }
    finally
    {
        if (masterVol != null)
            Marshal.ReleaseComObject(masterVol);
    }
}

/// <summary>
/// Gets the mute state of the master volume. 
/// While the volume can be muted the <see cref="GetMasterVolume"/> will still return the pre-muted volume value.
/// </summary>
/// <returns>false if not muted, true if volume is muted</returns>
public static bool GetMasterVolumeMute()
{
    IAudioEndpointVolume masterVol = null;
    try
    {
        masterVol = GetMasterVolumeObject();
        if (masterVol == null)
            return false;

        bool isMuted;
        masterVol.GetMute(out isMuted);
        return isMuted;
    }
    finally
    {
        if (masterVol != null)
            Marshal.ReleaseComObject(masterVol);
    }
}

/// <summary>
/// Sets the master volume to a specific level
/// </summary>
/// <param name="newLevel">Value between 0 and 100 indicating the desired scalar value of the volume</param>
public static void SetMasterVolume(float newLevel)
{
    IAudioEndpointVolume masterVol = null;
    try
    {
        masterVol = GetMasterVolumeObject();
        if (masterVol == null)
            return;

        masterVol.SetMasterVolumeLevelScalar(newLevel/100, Guid.Empty);
    }
    finally
    {
        if (masterVol != null)
            Marshal.ReleaseComObject(masterVol);
    }
}

/// <summary>
/// Increments or decrements the current volume level by the <see cref="stepAmount"/>.
/// </summary>
/// <param name="stepAmount">Value between -100 and 100 indicating the desired step amount. Use negative numbers to decrease
/// the volume and positive numbers to increase it.</param>
/// <returns>the new volume level assigned</returns>
public static float StepMasterVolume(float stepAmount)
{
    IAudioEndpointVolume masterVol = null;
    try
    {
        masterVol = GetMasterVolumeObject();
        if (masterVol == null)
            return -1;

        float stepAmountScaled = stepAmount/100;

        // Get the level
        float volumeLevel;
        masterVol.GetMasterVolumeLevelScalar(out volumeLevel);

        // Calculate the new level
        float newLevel = volumeLevel + stepAmountScaled;
        newLevel = Math.Min(1, newLevel);
        newLevel = Math.Max(0, newLevel);

        masterVol.SetMasterVolumeLevelScalar(newLevel, Guid.Empty);

        // Return the new volume level that was set
        return newLevel*100;
    }
    finally
    {
        if (masterVol != null)
            Marshal.ReleaseComObject(masterVol);
    }
}

/// <summary>
/// Mute or unmute the master volume
/// </summary>
/// <param name="isMuted">true to mute the master volume, false to unmute</param>
public static void SetMasterVolumeMute(bool isMuted)
{
    IAudioEndpointVolume masterVol = null;
    try
    {
        masterVol = GetMasterVolumeObject();
        if (masterVol == null)
            return;

        masterVol.SetMute(isMuted, Guid.Empty);
    }
    finally
    {
        if (masterVol != null)
            Marshal.ReleaseComObject(masterVol);
    }
}

/// <summary>
/// Switches between the master volume mute states depending on the current state
/// </summary>
/// <returns>the current mute state, true if the volume was muted, false if unmuted</returns>
public static bool ToggleMasterVolumeMute()
{
    IAudioEndpointVolume masterVol = null;
    try
    {
        masterVol = GetMasterVolumeObject();
        if (masterVol == null)
            return false;

        bool isMuted;
        masterVol.GetMute(out isMuted);
        masterVol.SetMute(!isMuted, Guid.Empty);

        return !isMuted;
    }
    finally
    {
        if (masterVol != null)
            Marshal.ReleaseComObject(masterVol);
    }
}

private static IAudioEndpointVolume GetMasterVolumeObject()
{
    IMMDeviceEnumerator deviceEnumerator = null;
    IMMDevice speakers = null;
    try
    {
        deviceEnumerator = (IMMDeviceEnumerator) (new MMDeviceEnumerator());
        deviceEnumerator.GetDefaultAudioEndpoint(EDataFlow.eRender, ERole.eMultimedia, out speakers);

        Guid IID_IAudioEndpointVolume = typeof (IAudioEndpointVolume).GUID;
        object o;
        speakers.Activate(ref IID_IAudioEndpointVolume, 0, IntPtr.Zero, out o);
        IAudioEndpointVolume masterVol = (IAudioEndpointVolume) o;

        return masterVol;
    }
    finally
    {
        if (speakers != null) Marshal.ReleaseComObject(speakers);
        if (deviceEnumerator != null) Marshal.ReleaseComObject(deviceEnumerator);
    }
}

public static float? GetApplicationVolume(int pid)
{
    ISimpleAudioVolume volume = GetVolumeObject(pid);
    if (volume == null)
        return null;

    float level;
    volume.GetMasterVolume(out level);
    Marshal.ReleaseComObject(volume);
    return level*100;
}

public static bool? GetApplicationMute(int pid)
{
    ISimpleAudioVolume volume = GetVolumeObject(pid);
    if (volume == null)
        return null;

    bool mute;
    volume.GetMute(out mute);
    Marshal.ReleaseComObject(volume);
    return mute;
}

public static void SetApplicationVolume(int pid, float level)
{
    ISimpleAudioVolume volume = GetVolumeObject(pid);
    if (volume == null)
        return;

    Guid guid = Guid.Empty;
    volume.SetMasterVolume(level/100, ref guid);
    Marshal.ReleaseComObject(volume);
}

public static void SetApplicationMute(int pid, bool mute)
{
    ISimpleAudioVolume volume = GetVolumeObject(pid);
    if (volume == null)
        return;

    Guid guid = Guid.Empty;
    volume.SetMute(mute, ref guid);
    Marshal.ReleaseComObject(volume);
}

private static ISimpleAudioVolume GetVolumeObject(int pid)
{
    IMMDeviceEnumerator deviceEnumerator = null;
    IAudioSessionEnumerator sessionEnumerator = null;
    IAudioSessionManager2 mgr = null;
    IMMDevice speakers = null;
    try
    {
        // get the speakers (1st render + multimedia) device
        deviceEnumerator = (IMMDeviceEnumerator) (new MMDeviceEnumerator());
        deviceEnumerator.GetDefaultAudioEndpoint(EDataFlow.eRender, ERole.eMultimedia, out speakers);

        // activate the session manager. we need the enumerator
        Guid IID_IAudioSessionManager2 = typeof (IAudioSessionManager2).GUID;
        object o;
        speakers.Activate(ref IID_IAudioSessionManager2, 0, IntPtr.Zero, out o);
        mgr = (IAudioSessionManager2) o;

        // enumerate sessions for on this device
        mgr.GetSessionEnumerator(out sessionEnumerator);
        int count;
        sessionEnumerator.GetCount(out count);

        // search for an audio session with the required process-id
        ISimpleAudioVolume volumeControl = null;
        for (int i = 0; i < count; ++i)
        {
            IAudioSessionControl2 ctl = null;
            try
            {
                sessionEnumerator.GetSession(i, out ctl);

                // NOTE: we could also use the app name from ctl.GetDisplayName()
                int cpid;
                ctl.GetProcessId(out cpid);

                if (cpid == pid)
                {
                    volumeControl = ctl as ISimpleAudioVolume;
                    break;
                }
            }
            finally
            {
                if (ctl != null) Marshal.ReleaseComObject(ctl);
            }
        }

        return volumeControl;
    }
    finally
    {
        if (sessionEnumerator != null) Marshal.ReleaseComObject(sessionEnumerator);
        if (mgr != null) Marshal.ReleaseComObject(mgr);
        if (speakers != null) Marshal.ReleaseComObject(speakers);
        if (deviceEnumerator != null) Marshal.ReleaseComObject(deviceEnumerator);
    }
}

[ComImport]
[Guid("BCDE0395-E52F-467C-8E3D-C4579291692E")]
internal class MMDeviceEnumerator
{
}

internal enum EDataFlow
{
    eRender,
    eCapture,
    eAll,
    EDataFlow_enum_count
}

internal enum ERole
{
    eConsole,
    eMultimedia,
    eCommunications,
    ERole_enum_count
}

[Guid("A95664D2-9614-4F35-A746-DE8DB63617E6"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
internal interface IMMDeviceEnumerator
{
    int NotImpl1();

    [PreserveSig]
    int GetDefaultAudioEndpoint(EDataFlow dataFlow, ERole role, out IMMDevice ppDevice);

    // the rest is not implemented
}

[Guid("D666063F-1587-4E43-81F1-B948E807363F"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
internal interface IMMDevice
{
    [PreserveSig]
    int Activate(ref Guid iid, int dwClsCtx, IntPtr pActivationParams, [MarshalAs(UnmanagedType.IUnknown)] out object ppInterface);

    // the rest is not implemented
}

[Guid("77AA99A0-1BD6-484F-8BC7-2C654C9A9B6F"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
internal interface IAudioSessionManager2
{
    int NotImpl1();
    int NotImpl2();

    [PreserveSig]
    int GetSessionEnumerator(out IAudioSessionEnumerator SessionEnum);

    // the rest is not implemented
}

[Guid("E2F5BB11-0570-40CA-ACDD-3AA01277DEE8"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
internal interface IAudioSessionEnumerator
{
    [PreserveSig]
    int GetCount(out int SessionCount);

    [PreserveSig]
    int GetSession(int SessionCount, out IAudioSessionControl2 Session);
}

[Guid("87CE5498-68D6-44E5-9215-6DA47EF883D8"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
internal interface ISimpleAudioVolume
{
    [PreserveSig]
    int SetMasterVolume(float fLevel, ref Guid EventContext);

    [PreserveSig]
    int GetMasterVolume(out float pfLevel);

    [PreserveSig]
    int SetMute(bool bMute, ref Guid EventContext);

    [PreserveSig]
    int GetMute(out bool pbMute);
}

[Guid("bfb7ff88-7239-4fc9-8fa2-07c950be9c6d"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
internal interface IAudioSessionControl2
{
    // IAudioSessionControl
    [PreserveSig]
    int NotImpl0();

    [PreserveSig]
    int GetDisplayName([MarshalAs(UnmanagedType.LPWStr)] out string pRetVal);

    [PreserveSig]
    int SetDisplayName([MarshalAs(UnmanagedType.LPWStr)]string Value, [MarshalAs(UnmanagedType.LPStruct)] Guid EventContext);

    [PreserveSig]
    int GetIconPath([MarshalAs(UnmanagedType.LPWStr)] out string pRetVal);

    [PreserveSig]
    int SetIconPath([MarshalAs(UnmanagedType.LPWStr)] string Value, [MarshalAs(UnmanagedType.LPStruct)] Guid EventContext);

    [PreserveSig]
    int GetGroupingParam(out Guid pRetVal);

    [PreserveSig]
    int SetGroupingParam([MarshalAs(UnmanagedType.LPStruct)] Guid Override, [MarshalAs(UnmanagedType.LPStruct)] Guid EventContext);

    [PreserveSig]
    int NotImpl1();

    [PreserveSig]
    int NotImpl2();

    // IAudioSessionControl2
    [PreserveSig]
    int GetSessionIdentifier([MarshalAs(UnmanagedType.LPWStr)] out string pRetVal);

    [PreserveSig]
    int GetSessionInstanceIdentifier([MarshalAs(UnmanagedType.LPWStr)] out string pRetVal);

    [PreserveSig]
    int GetProcessId(out int pRetVal);

    [PreserveSig]
    int IsSystemSoundsSession();

    [PreserveSig]
    int SetDuckingPreference(bool optOut);
}

// http://netcoreaudio.codeplex.com/SourceControl/latest#trunk/Code/CoreAudio/Interfaces/IAudioEndpointVolume.cs
[Guid("5CDF2C82-841E-4546-9722-0CF74078229A"),InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
public interface IAudioEndpointVolume
{
    [PreserveSig]
    int NotImpl1();

    [PreserveSig]
    int NotImpl2();

    /// <summary>
    /// Gets a count of the channels in the audio stream.
    /// </summary>
    /// <param name="channelCount">The number of channels.</param>
    /// <returns>An HRESULT code indicating whether the operation passed of failed.</returns>
    [PreserveSig]
    int GetChannelCount(
        [Out] [MarshalAs(UnmanagedType.U4)] out UInt32 channelCount);

    /// <summary>
    /// Sets the master volume level of the audio stream, in decibels.
    /// </summary>
    /// <param name="level">The new master volume level in decibels.</param>
    /// <param name="eventContext">A user context value that is passed to the notification callback.</param>
    /// <returns>An HRESULT code indicating whether the operation passed of failed.</returns>
    [PreserveSig]
    int SetMasterVolumeLevel(
        [In] [MarshalAs(UnmanagedType.R4)] float level,
        [In] [MarshalAs(UnmanagedType.LPStruct)] Guid eventContext);

    /// <summary>
    /// Sets the master volume level, expressed as a normalized, audio-tapered value.
    /// </summary>
    /// <param name="level">The new master volume level expressed as a normalized value between 0.0 and 1.0.</param>
    /// <param name="eventContext">A user context value that is passed to the notification callback.</param>
    /// <returns>An HRESULT code indicating whether the operation passed of failed.</returns>
    [PreserveSig]
    int SetMasterVolumeLevelScalar(
        [In] [MarshalAs(UnmanagedType.R4)] float level,
        [In] [MarshalAs(UnmanagedType.LPStruct)] Guid eventContext);

    /// <summary>
    /// Gets the master volume level of the audio stream, in decibels.
    /// </summary>
    /// <param name="level">The volume level in decibels.</param>
    /// <returns>An HRESULT code indicating whether the operation passed of failed.</returns>
    [PreserveSig]
    int GetMasterVolumeLevel(
        [Out] [MarshalAs(UnmanagedType.R4)] out float level);

    /// <summary>
    /// Gets the master volume level, expressed as a normalized, audio-tapered value.
    /// </summary>
    /// <param name="level">The volume level expressed as a normalized value between 0.0 and 1.0.</param>
    /// <returns>An HRESULT code indicating whether the operation passed of failed.</returns>
    [PreserveSig]
    int GetMasterVolumeLevelScalar(
        [Out] [MarshalAs(UnmanagedType.R4)] out float level);

    /// <summary>
    /// Sets the volume level, in decibels, of the specified channel of the audio stream.
    /// </summary>
    /// <param name="channelNumber">The channel number.</param>
    /// <param name="level">The new volume level in decibels.</param>
    /// <param name="eventContext">A user context value that is passed to the notification callback.</param>
    /// <returns>An HRESULT code indicating whether the operation passed of failed.</returns>
    [PreserveSig]
    int SetChannelVolumeLevel(
        [In] [MarshalAs(UnmanagedType.U4)] UInt32 channelNumber,
        [In] [MarshalAs(UnmanagedType.R4)] float level,
        [In] [MarshalAs(UnmanagedType.LPStruct)] Guid eventContext);

    /// <summary>
    /// Sets the normalized, audio-tapered volume level of the specified channel in the audio stream.
    /// </summary>
    /// <param name="channelNumber">The channel number.</param>
    /// <param name="level">The new master volume level expressed as a normalized value between 0.0 and 1.0.</param>
    /// <param name="eventContext">A user context value that is passed to the notification callback.</param>
    /// <returns>An HRESULT code indicating whether the operation passed of failed.</returns>
    [PreserveSig]
    int SetChannelVolumeLevelScalar(
        [In] [MarshalAs(UnmanagedType.U4)] UInt32 channelNumber,
        [In] [MarshalAs(UnmanagedType.R4)] float level,
        [In] [MarshalAs(UnmanagedType.LPStruct)] Guid eventContext);

    /// <summary>
    /// Gets the volume level, in decibels, of the specified channel in the audio stream.
    /// </summary>
    /// <param name="channelNumber">The zero-based channel number.</param>
    /// <param name="level">The volume level in decibels.</param>
    /// <returns>An HRESULT code indicating whether the operation passed of failed.</returns>
    [PreserveSig]
    int GetChannelVolumeLevel(
        [In] [MarshalAs(UnmanagedType.U4)] UInt32 channelNumber,
        [Out] [MarshalAs(UnmanagedType.R4)] out float level);

    /// <summary>
    /// Gets the normalized, audio-tapered volume level of the specified channel of the audio stream.
    /// </summary>
    /// <param name="channelNumber">The zero-based channel number.</param>
    /// <param name="level">The volume level expressed as a normalized value between 0.0 and 1.0.</param>
    /// <returns>An HRESULT code indicating whether the operation passed of failed.</returns>
    [PreserveSig]
    int GetChannelVolumeLevelScalar(
        [In] [MarshalAs(UnmanagedType.U4)] UInt32 channelNumber,
        [Out] [MarshalAs(UnmanagedType.R4)] out float level);

    /// <summary>
    /// Sets the muting state of the audio stream.
    /// </summary>
    /// <param name="isMuted">True to mute the stream, or false to unmute the stream.</param>
    /// <param name="eventContext">A user context value that is passed to the notification callback.</param>
    /// <returns>An HRESULT code indicating whether the operation passed of failed.</returns>
    [PreserveSig]
    int SetMute(
        [In] [MarshalAs(UnmanagedType.Bool)] Boolean isMuted,
        [In] [MarshalAs(UnmanagedType.LPStruct)] Guid eventContext);

    /// <summary>
    /// Gets the muting state of the audio stream.
    /// </summary>
    /// <param name="isMuted">The muting state. True if the stream is muted, false otherwise.</param>
    /// <returns>An HRESULT code indicating whether the operation passed of failed.</returns>
    [PreserveSig]
    int GetMute(
        [Out] [MarshalAs(UnmanagedType.Bool)] out Boolean isMuted);

    /// <summary>
    /// Gets information about the current step in the volume range.
    /// </summary>
    /// <param name="step">The current zero-based step index.</param>
    /// <param name="stepCount">The total number of steps in the volume range.</param>
    /// <returns>An HRESULT code indicating whether the operation passed of failed.</returns>
    [PreserveSig]
    int GetVolumeStepInfo(
        [Out] [MarshalAs(UnmanagedType.U4)] out UInt32 step,
        [Out] [MarshalAs(UnmanagedType.U4)] out UInt32 stepCount);

    /// <summary>
    /// Increases the volume level by one step.
    /// </summary>
    /// <param name="eventContext">A user context value that is passed to the notification callback.</param>
    /// <returns>An HRESULT code indicating whether the operation passed of failed.</returns>
    [PreserveSig]
    int VolumeStepUp(
        [In] [MarshalAs(UnmanagedType.LPStruct)] Guid eventContext);

    /// <summary>
    /// Decreases the volume level by one step.
    /// </summary>
    /// <param name="eventContext">A user context value that is passed to the notification callback.</param>
    /// <returns>An HRESULT code indicating whether the operation passed of failed.</returns>
    [PreserveSig]
    int VolumeStepDown(
        [In] [MarshalAs(UnmanagedType.LPStruct)] Guid eventContext);

    /// <summary>
    /// Queries the audio endpoint device for its hardware-supported functions.
    /// </summary>
    /// <param name="hardwareSupportMask">A hardware support mask that indicates the capabilities of the endpoint.</param>
    /// <returns>An HRESULT code indicating whether the operation passed of failed.</returns>
    [PreserveSig]
    int QueryHardwareSupport(
        [Out] [MarshalAs(UnmanagedType.U4)] out UInt32 hardwareSupportMask);

    /// <summary>
    /// Gets the volume range of the audio stream, in decibels.
    /// </summary>
    /// <param name="volumeMin">The minimum volume level in decibels.</param>
    /// <param name="volumeMax">The maximum volume level in decibels.</param>
    /// <param name="volumeStep">The volume increment level in decibels.</param>
    /// <returns>An HRESULT code indicating whether the operation passed of failed.</returns>
    [PreserveSig]
    int GetVolumeRange(
        [Out] [MarshalAs(UnmanagedType.R4)] out float volumeMin,
        [Out] [MarshalAs(UnmanagedType.R4)] out float volumeMax,
        [Out] [MarshalAs(UnmanagedType.R4)] out float volumeStep);
}
"@ -Name API -Namespace CoreAudio
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