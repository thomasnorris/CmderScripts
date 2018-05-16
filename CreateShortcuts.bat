@echo off

set SHORTCUT_DIR="%APPDATA%\Microsoft\Windows\Start Menu\Programs\Cmder Tools"

if not exist %SHORTCUT_DIR% (
	mkdir %SHORTCUT_DIR%
)

set /p DESKTOP=Do you want to create shortcuts on the Desktop? (y/n) 

if [%DESKTOP%] == [y] (
	call :CreateShortcut "%CMDER_ROOT%\Cmder.exe" , "Cmder" , "%USERPROFILE%\Desktop"
	call :CreateShortcut "%HOME%\sublime_text\sublime_text.exe" , "Sublime Text" , "%USERPROFILE%\Desktop"
	echo Shortcuts created on the desktop.
)

call :CreateShortcut "%CMDER_ROOT%\Cmder.exe" , "Cmder" , %SHORTCUT_DIR%
call :CreateShortcut "%HOME%\sublime_text\sublime_text.exe" , "Sublime Text" , %SHORTCUT_DIR%

echo Shortcuts will be available in Windows search momentarily.

exit /b 0

:CreateShortcut
nircmd shortcut %1 %3 %2
exit /b 0