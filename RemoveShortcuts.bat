@echo off

set SEARCH_SHORTCUT_DIR="%APPDATA%\Microsoft\Windows\Start Menu\Programs\Cmder Tools"
set CMDER_DESKTOP_SHORTCUT="%USERPROFILE%\Desktop\Cmder.lnk"
set SUBLIME_DESKTOP_SHORTCUT="%USERPROFILE%\Desktop\Sublime Text.lnk"

if exist %SEARCH_SHORTCUT_DIR% (
	rmdir /s /q %SEARCH_SHORTCUT_DIR%
	echo Shortcuts removed from Windows search.
) else (
	echo No shortcuts to remove from Windows search.
)

if exist %CMDER_DESKTOP_SHORTCUT% (
	del /s /q /f %CMDER_DESKTOP_SHORTCUT%
)

if exist %SUBLIME_DESKTOP_SHORTCUT% (
	del /s /q /f %SUBLIME_DESKTOP_SHORTCUT%
)

exit /b 0
