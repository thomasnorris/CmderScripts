@echo off

set shortcutDir="%APPDATA%\Microsoft\Windows\Start Menu\Programs\Cmder Tools"
set cmderDesktopShortcut="%USERPROFILE%\Desktop\Cmder.lnk"
set vsCodeDesktopShortcut="%USERPROFILE%\Desktop\VSCode.lnk"

if exist %shortcutDir% (
	rmdir /s /q %shortcutDir%
	echo Shortcuts removed from Windows search.
) else (
	echo No shortcuts to remove from Windows search.
)

if exist %cmderDesktopShortcut% (
	del /s /q /f %cmderDesktopShortcut%
)

if exist %vsCodeDesktopShortcut% (
	del /s /q /f %vsCodeDesktopShortcut%
)

exit /b 0
