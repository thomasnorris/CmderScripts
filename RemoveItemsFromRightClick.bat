@echo off

:: Remove Cmder 
@reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\Cmder" /f
@reg delete "HKEY_CLASSES_ROOT\Directory\shell\Cmder" /f

:: Remove Sublime Text
@reg delete "HKEY_CLASSES_ROOT\Applications\sublime_text.exe" /f
@reg delete "HKEY_CLASSES_ROOT\*\shell\Edit with Sublime Text" /f