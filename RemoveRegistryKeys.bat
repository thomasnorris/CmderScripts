@echo off

set cmderName=Cmder
set vsCodeName=VSCode

:: Remove Cmder keys
reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\%cmderName%" /f
reg delete "HKEY_CLASSES_ROOT\Directory\shell\%cmderName%" /f

::VSCode Keys
reg delete "HKEY_CLASSES_ROOT\Applications\VSCodePortable.exe\shell\open\command" /f
reg delete "HKEY_CLASSES_ROOT\*\shell\Edit with %vsCodeName%" /f
reg delete "HKEY_CLASSES_ROOT\Directory\shell\Open with %vsCodeName%" /f