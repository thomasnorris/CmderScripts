@echo off

set cmderName=Cmder
set vsCodeName=VSCode

echo Administrative permissions required. Detecting permissions...
net session >nul 2>&1
if %ERRORLEVEL% == 0 (
    echo Success: Administrative permissions confirmed, removing registry keys.
    goto RemoveKeys
) else (
    echo Failure: Current permissions inadequate, cannot remove registry keys.
    exit /b 0
)

:RemoveKeys
:: Remove Cmder keys
reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\%cmderName%" /f
reg delete "HKEY_CLASSES_ROOT\Directory\shell\%cmderName%" /f

::VSCode Keys
reg delete "HKEY_CLASSES_ROOT\Applications\VSCodePortable.exe\shell\open\command" /f
reg delete "HKEY_CLASSES_ROOT\*\shell\Edit with %vsCodeName%" /f
reg delete "HKEY_CLASSES_ROOT\Directory\shell\Open with %vsCodeName%" /f