@echo off

:: Remove Cmder keys
@reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\Cmder" /f
@reg delete "HKEY_CLASSES_ROOT\Directory\shell\Cmder" /f

:: Remove Sublime Text keys
@reg delete "HKEY_CLASSES_ROOT\Applications\sublime_text.exe" /f
@reg delete "HKEY_CLASSES_ROOT\*\shell\Edit with Sublime Text" /f
@reg delete "HKEY_CLASSES_ROOT\Directory\shell\Open in Sublime Text" /f 
@reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\Sublime Text" /f
@reg delete "HKEY_CLASSES_ROOT\Directory\shell\Sublime Text" /f
@reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Open folder" /f
@reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Create new file here" /f