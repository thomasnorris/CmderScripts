@echo off

set shortcutDir="%APPDATA%\Microsoft\Windows\Start Menu\Programs\Cmder"
set cmderDesktopShortcut="%USERPROFILE%\Desktop\Cmder.lnk"
set vsCodeDesktopShortcut="%USERPROFILE%\Desktop\Visual Studio Code.lnk"

if exist %shortcutDir% (
	rmdir /s /q %shortcutDir%
)

if exist %cmderDesktopShortcut% (
	del /q /f %cmderDesktopShortcut%
)

if exist %vsCodeDesktopShortcut% (
	del /q /f %vsCodeDesktopShortcut%
)

echo Shortcuts removed.

exit /b 0
