@echo off

set cmderName=Cmder
set vsCodeName=Visual Studio Code

net session >nul 2>&1
if not [%ERRORLEVEL%] == [0] (
    echo Cannot remove registry keys; administrator permissions required.
    exit /b 0
)

echo Removing registry keys...

:: Remove Cmder keys
reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\%cmderName%" /f
reg delete "HKEY_CLASSES_ROOT\Directory\shell\%cmderName%" /f

::VSCode Keys
reg delete "HKEY_CLASSES_ROOT\Applications\Code.exe\shell\open\command" /f
reg delete "HKEY_CLASSES_ROOT\*\shell\Edit with %vsCodeName%" /f
reg delete "HKEY_CLASSES_ROOT\Directory\shell\Open in %vsCodeName%" /f

echo Registry keys removed.

exit /b 0