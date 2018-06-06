@echo off

set cmderName=Cmder
set sublimeName=Sublime Text 3
set createNewFileHereText=Create new file here
set openInSublimeText=Open folder

:: Remove Cmder keys
@reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\%cmderName%" /f
@reg delete "HKEY_CLASSES_ROOT\Directory\shell\%cmderName%" /f

:: Remove Sublime Text keys
@reg delete "HKEY_CLASSES_ROOT\Applications\sublime_text.exe" /f
@reg delete "HKEY_CLASSES_ROOT\*\shell\Edit with %sublimeName%" /f
@reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\%sublimeName%" /f
@reg delete "HKEY_CLASSES_ROOT\Directory\shell\%sublimeName%" /f
@reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\%openInSublimeText%" /f
@reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\%createNewFileHereText%" /f