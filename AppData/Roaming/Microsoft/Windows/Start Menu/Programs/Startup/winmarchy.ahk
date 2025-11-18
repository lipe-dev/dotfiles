#Requires AutoHotkey v2.0
#SingleInstance Force

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

#HotIf GetKeyState("F13")
+b:: Run "C:\Users\lipe\AppData\Local\BraveSoftware\Brave-Browser\Application\brave.exe"
Space:: Send "{LWin}"
Escape:: Shutdown 1
+F:: Run "explorer.exe"
+T:: Run "taskmgr.exe"
Enter:: Run "wt.exe"
+;:: Run "C:\Users\lipe\AppData\Local\Programs\Bitwarden\Bitwarden.exe"
+N:: Run "C:\Users\lipe\AppData\Local\Programs\Microsoft VS Code\Code.exe"
+A:: Run "https://chatgpt.com/"
+G:: Run "C:\Users\lipe\AppData\Local\Discord\app-1.0.9212\Discord.exe"
+^G:: Run "https://web.whatsapp.com/"
+W:: Run "powershell.exe -NoExit -Command iwr -useb https://christitus.com/win | iex"
+R:: Reload
