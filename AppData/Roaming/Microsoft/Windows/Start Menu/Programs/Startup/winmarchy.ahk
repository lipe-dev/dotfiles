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

; LWin+Space to open Start Menu (sends RWin)
#Space::Send "{RWin}"

; Clipboard operations with LWin
#c::Send "^c"
#x::Send "^x"
#v::Send "^v"

; Terminal (no shift)
#Enter::
{
    Run "wt.exe"
}

; App launching with LWin+Shift
#+b::Run "C:\Users\lipe\AppData\Local\BraveSoftware\Brave-Browser\Application\brave.exe"
#Escape::Shutdown 1
#+f::Run "explorer.exe"
#+t::Run "taskmgr.exe"
#+SC027::Run "C:\Users\lipe\AppData\Local\Programs\Bitwarden\Bitwarden.exe"  ; semicolon
#+n::Run "wt.exe -d ~ -- nvim"
#+a::Run "https://chatgpt.com/"
#+g::Run "C:\Users\lipe\AppData\Local\Discord\app-1.0.9212\Discord.exe"
#^g::Run "https://web.whatsapp.com/"
#+w::Run "powershell.exe -NoExit -Command iwr -useb https://christitus.com/win | iex"
#+r::Reload
