#Requires AutoHotkey v2.0
#SingleInstance Force

full_command_line := DllCall("GetCommandLine", "str")
if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)")) {
    try
    {
        if A_IsCompiled
            Run '*RunAs "' A_ScriptFullPath '" /restart'
        else
            Run '*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"'
    }
    ExitApp
}

; Disable LWin from sending Win key normally
LWin::return

; LWin+Space to open Start Menu (sends RWin)
LWin & Space::Send "{RWin}"

; Clipboard operations with LWin
LWin & c::Send "^c"
LWin & x::Send "^x"
LWin & v::Send "^v"

; Terminal (no shift)
LWin & Return::
{
    Run "wt.exe"
}

; App launching with LWin+Shift
+LWin & b::Run "C:\Users\lipe\AppData\Local\BraveSoftware\Brave-Browser\Application\brave.exe"
LWin & Escape::Shutdown 1
+LWin & f::Run "explorer.exe"
+LWin & t::Run "taskmgr.exe"
+LWin & SC027::Run "C:\Users\lipe\AppData\Local\Programs\Bitwarden\Bitwarden.exe"  ; semicolon
+LWin & n::Run "wt.exe -p archlinux -- nvim"
+LWin & a::Run "https://chatgpt.com/"
+LWin & g::Run "C:\Users\lipe\AppData\Local\Discord\app-1.0.9212\Discord.exe"
+LWin & ^g::Run "https://web.whatsapp.com/"
+LWin & w::Run "powershell.exe -NoExit -Command iwr -useb https://christitus.com/win | iex"
+LWin & r::Reload
