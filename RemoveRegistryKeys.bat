@echo off

set cmderName=Cmder
set vsCodeName=Visual Studio Code

net session >nul 2>&1
if not [%ERRORLEVEL%] == [0] (
    echo Cannot remove registry keys; administrator permissions required.
    exit /b 0
)

:: Remove Cmder keys
echo Removing %cmderName% keys...
call :RemoveKey "HKEY_CLASSES_ROOT\Directory\Background\shell\%cmderName%"
call :RemoveKey "HKEY_CLASSES_ROOT\Directory\shell\%cmderName%"

::VSCode Keys
echo Removing %vsCodeName% keys...
call :RemoveKey "HKEY_CLASSES_ROOT\Applications\Code.exe\shell\open\command"
call :RemoveKey "HKEY_CLASSES_ROOT\*\shell\Edit with %vsCodeName%"
call :RemoveKey "HKEY_CLASSES_ROOT\Directory\shell\Open in %vsCodeName%"

echo Registry keys removed.

exit /b 0

:RemoveKey
reg delete %1 /f >nul 2>&1
exit /b 0