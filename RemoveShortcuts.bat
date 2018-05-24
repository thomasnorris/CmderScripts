@echo off

set shortcutDir="%APPDATA%\Microsoft\Windows\Start Menu\Programs\Cmder Tools"
set cmderDesktopShortcut="%USERPROFILE%\Desktop\Cmder.lnk"
set sublimeDesktopShortcut="%USERPROFILE%\Desktop\Sublime Text 3.lnk"

if exist %shortcutDir% (
	rmdir /s /q %shortcutDir%
	echo Shortcuts removed from Windows search.
) else (
	echo No shortcuts to remove from Windows search.
)

if exist %cmderDesktopShortcut% (
	del /s /q /f %cmderDesktopShortcut%
)

if exist %sublimeDesktopShortcut% (
	del /s /q /f %sublimeDesktopShortcut%
)

exit /b 0
