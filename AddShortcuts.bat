@echo off

set shortcutDir="%APPDATA%\Microsoft\Windows\Start Menu\Programs\Cmder"
set cmderExe="%CMDER_ROOT%\Cmder.exe"
set vsCodeExe="%HOME%\vscode\Code.exe"
set desktopDir="%USERPROFILE%\Desktop"
set cmderName=Cmder
set vsCodeName=Visual Studio Code

if not exist %shortcutDir% (
	mkdir %shortcutDir%
)

choice /t 5 /d "N" /m "Create shortcuts on the Desktop? Defaults \"N\" in 5 seconds."
:: %ERRRORLEVEL% == 1 is "Y"
if [%ERRORLEVEL%] == [1] (
	call :CreateShortcut %cmderExe% , "%cmderName%" , %desktopDir%
	call :CreateShortcut %vsCodeExe% , "%vsCodeName%" , %desktopDir%
	echo Shortcuts created on the desktop.
)

call :CreateShortcut %cmderExe% , "%cmderName%" , %shortcutDir%
call :CreateShortcut %vsCodeExe% , "%vsCodeName%" , %shortcutDir%

echo Shortcuts created.

exit /b 0

:CreateShortcut
nircmd shortcut %1 %3 %2
exit /b 0