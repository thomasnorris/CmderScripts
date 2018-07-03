@echo off

echo This will remove Cmder from the system.
echo Close and VSCode instances and stop other programs associated with Cmder before continuing.
echo Run in an elevated window to remove registry keys.
pause

set cmderInstallFolderName=Cmder
set defaultDownloadLocation=%USERPROFILE%\Desktop
set removeRegistryKeysFileName=RemoveRegistryKeys.bat
set removeShortcutsFileName=RemoveShortcuts.bat

:: Set download location to be the root of the C: drive if %USERPROFILE% has spaces in the name
if not [%defaultDownloadLocation%] == [%defaultDownloadLocation: =%] (
	set defaultDownloadLocation=C:
)

:SetLocation
set /p cmderInstallDir=Where is Cmder installed? (Press enter to default to "%defaultDownloadLocation%"):
if [%cmderInstallDir%] == [] (
	set cmderInstallDir=%defaultDownloadLocation%\%cmderInstallFolderName%
) else (
	set cmderInstallDir=%cmderInstallDir%\%cmderInstallFolderName%
)

if not exist %cmderInstallDir%\Cmder.exe (
	echo Cmder not found.
	set cmderInstallDir=
	goto SetLocation
)

call "%cmderInstallDir%\personal\batch scripts\%removeRegistryKeysFileName%"
call "%cmderInstallDir%\personal\batch scripts\%removeShortcutsFileName%"

echo Removing "%cmderInstallDir%", please wait...
rmdir /s /q %cmderInstallDir%
echo Cmder was removed. Some folders may still exist and will need to be removed manually.

pause

exit /b 0
