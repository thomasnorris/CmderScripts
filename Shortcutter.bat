@echo off

set name=%~nx1

if [%name%] == [] (
	echo A name or path must be supplied, exiting
	exit /b 0
)

set shortcutDir="%APPDATA%\Microsoft\Windows\Start Menu\Programs\Shortcutter"

if not exist %shortcutDir% (
	mkdir %shortcutDir%
)

nircmd shortcut "%~f1" %shortcutDir% "%name%"

echo Shortcut for %name% created.

exit /b 0