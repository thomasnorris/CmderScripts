@echo off

set shortcutDir="%APPDATA%\Microsoft\Windows\Start Menu\Programs\Cmder"
set cmderDesktopShortcut="%USERPROFILE%\Desktop\Cmder.lnk"
set vsCodeDesktopShortcut="%USERPROFILE%\Desktop\VSCode.lnk"

if exist %shortcutDir% (
	rmdir /s /q %shortcutDir%
)

if exist %cmderDesktopShortcut% (
	del /s /q /f %cmderDesktopShortcut%
)

if exist %vsCodeDesktopShortcut% (
	del /s /q /f %vsCodeDesktopShortcut%
)

echo Shortcuts removed.

exit /b 0
