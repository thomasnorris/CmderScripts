@echo off

set cmderName=Cmder
set vsCodeName=VSCode
set createNewFileVsCode=Create new file here
set openInVsCode=Open folder

:: Remove Cmder keys
@reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\%cmderName%" /f
@reg delete "HKEY_CLASSES_ROOT\Directory\shell\%cmderName%" /f

::VSCode Keys
@reg delete "HKEY_CLASSES_ROOT\Applications\VSCodePortable.exe" /f
@reg delete "HKEY_CLASSES_ROOT\*\shell\Edit with %vsCodeName%" /f
@reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\%vsCodeName%" /f
@reg delete "HKEY_CLASSES_ROOT\Directory\shell\%vsCodeName%" /f
@reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\%openInVsCode%" /f
@reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\%createNewFileVsCode%" /f