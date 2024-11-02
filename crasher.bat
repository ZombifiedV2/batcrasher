@echo off
setlocal enabledelayedexpansion


set count=5


set "vbsFile=move.vbs"


(
    echo Set objShell = CreateObject("WScript.Shell")
    echo Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
    echo Do
    echo     Set colItems = objWMIService.ExecQuery("Select * from Win32_Process Where Name = 'cmd.exe'")
    echo     For Each objItem in colItems
    echo         x = Int(Rnd * 800) ' Random x position (0-800)
    echo         y = Int(Rnd * 600) ' Random y position (0-600)
    echo         objShell.AppActivate objItem.ProcessId
    echo         WScript.Sleep 100
    echo         objShell.SendKeys "% {DOWN}" ' Simulates Alt + Down to move the window
    echo         WScript.Sleep 100
    echo         objShell.SendKeys "% {UP}" ' Simulates Alt + Up to move the window
    echo     Next
    echo     WScript.Sleep 500
    echo Loop
) > "%vbsFile%"

for /L %%i in (1,1,%count%) do (
    start "" "%~f0"
)

start "" wscript "%vbsFile%"

timeout /t 10 > nul
del "%vbsFile%"

endlocal
exit /b
