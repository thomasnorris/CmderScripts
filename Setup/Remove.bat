@echo off

echo This will remove Cmder and related files from the system.
echo Close any VSCode windows and stop other programs associated with Cmder before continuing.
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
set /p cmderInstallDir=Where is Cmder installed? [Press enter to default to "%defaultDownloadLocation%"]:
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

:: Run scripts
call :RunScript %removeRegistryKeysFileName%
call :RunScript %removeShortcutsFileName%

echo Removing "%cmderInstallDir%", please wait...
rmdir /s /q %cmderInstallDir%

if exist %cmderInstallDir% (
	echo Cmder was partially removed. Some files/folders will need to be removed manually.
	echo An explorer window will now open "%cmderInstallDir%".
	pause
	start "" %cmderInstallDir%
) else (
	echo Cmder was completely removed.
	pause
)

exit /b 0

:RunScript
:: Explicitly give the path to the scripts folder without using Cmder variables
call "%cmderInstallDir%\personal\batch_scripts\%1"

exit /b 0
