@echo off

set shortcutDir="%APPDATA%\Microsoft\Windows\Start Menu\Programs\Cmder"
set cmderDesktopShortcut="%USERPROFILE%\Desktop\Cmder.lnk"
set vsCodeDesktopShortcut="%USERPROFILE%\Desktop\Visual Studio Code.lnk"
set winScpDesktopShortcut="%USERPROFILE%\Desktop\WinSCP.lnk"

if exist %shortcutDir% (
	rmdir /s /q %shortcutDir%
)

if exist %cmderDesktopShortcut% (
	del /q /f %cmderDesktopShortcut%
)

if exist %vsCodeDesktopShortcut% (
	del /q /f %vsCodeDesktopShortcut%
)

if exist %winScpDesktopShortcut% (
	del /q /f %winScpDesktopShortcut%
)

echo Shortcuts removed successfully.

exit /b 0
