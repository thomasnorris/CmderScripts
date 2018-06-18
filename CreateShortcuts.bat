@echo off

set shortcutDir="%APPDATA%\Microsoft\Windows\Start Menu\Programs\Cmder Tools"
set cmderDir="%CMDER_ROOT%\Cmder.exe"
set vsCodeDir="%HOME%\vscode\VSCodePortable.exe"

if not exist %shortcutDir% (
	mkdir %shortcutDir%
)

set /p createOnDesktop=Do you want to create shortcuts on the Desktop? (y/n) 

if [%createOnDesktop%] == [y] (
	call :CreateShortcut %cmderDir% , "Cmder" , "%USERPROFILE%\Desktop"
	call :CreateShortcut %vsCodeDir% , "VSCode" , "%USERPROFILE%\Desktop"
	echo Shortcuts created on the desktop.
)

call :CreateShortcut %cmderDir% , "Cmder" , %shortcutDir%
call :CreateShortcut %vsCodeDir% , "VSCode" , %shortcutDir%

echo Shortcuts will be available in Windows search momentarily.

exit /b 0

:CreateShortcut
nircmd shortcut %1 %3 %2
exit /b 0