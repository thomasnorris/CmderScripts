@echo off

set shortcutDir="%APPDATA%\Microsoft\Windows\Start Menu\Programs\Cmder Tools"

if not exist %shortcutDir% (
	mkdir %shortcutDir%
)

set /p createOnDesktop=Do you want to create shortcuts on the Desktop? (y/n) 

if [%createOnDesktop%] == [y] (
	call :CreateShortcut "%CMDER_ROOT%\Cmder.exe" , "Cmder" , "%USERPROFILE%\Desktop"
	call :CreateShortcut "%HOME%\sublime_text\sublime_text.exe" , "Sublime Text 3" , "%USERPROFILE%\Desktop"
	echo Shortcuts created on the desktop.
)

call :CreateShortcut "%CMDER_ROOT%\Cmder.exe" , "Cmder" , %shortcutDir%
call :CreateShortcut "%HOME%\sublime_text\sublime_text.exe" , "Sublime Text 3" , %shortcutDir%

echo Shortcuts will be available in Windows search momentarily.

exit /b 0

:CreateShortcut
nircmd shortcut %1 %3 %2
exit /b 0