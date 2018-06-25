@echo off

set shortcutDir="%APPDATA%\Microsoft\Windows\Start Menu\Programs\Cmder"
set cmderDir="%CMDER_ROOT%\Cmder.exe"
set vsCodeDir="%HOME%\vscode\VSCodePortable.exe"
set desktopDir="%USERPROFILE%\Desktop"
set cmderName=Cmder
set vsCodeName=Visual Studio Code

if not exist %shortcutDir% (
	mkdir %shortcutDir%
)

set /p createOnDesktop=Do you want to create shortcuts on the Desktop? (y/n) 

if [%createOnDesktop%] == [y] (
	call :CreateShortcut %cmderDir% , "%cmderName%" , %desktopDir%
	call :CreateShortcut %vsCodeDir% , "%vsCodeName%" , %desktopDir%
	echo Shortcuts created on the desktop.
)

call :CreateShortcut %cmderDir% , "%cmderName%" , %shortcutDir%
call :CreateShortcut %vsCodeDir% , "%vsCodeName%" , %shortcutDir%

echo Shortcuts will be available in Windows search momentarily.

exit /b 0

:CreateShortcut
nircmd shortcut %1 %3 %2
echo Created shortcut for %2.
exit /b 0