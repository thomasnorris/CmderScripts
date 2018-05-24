@echo off

echo This will remove Cmder and run batch programs. Close any instances of Cmder and Sublime Text before continuing.
echo Close and re-run in an elevated cmd, otherwise the uninstall will not complete completely.
pause

set cmderInstallFolderName=Cmder
set removeRegistryKeysBatFileName=RemoveRegistryKeys.bat
set removeShortcutsBatFileName=RemoveShortcuts.bat

goto SetLocation

:SetLocation
set /p cmderInstallDir=Where is Cmder located? (Default is the Desktop): 
if [%cmderInstallDir%] == [] (
	set cmderInstallDir="%USERPROFILE%\Desktop\%cmderInstallFolderName%"
) else (
	set cmderInstallDir=%cmderInstallDir%\%cmderInstallFolderName%
)

if not exist %cmderInstallDir%\Cmder.exe (
	echo. && echo Cmder not found.
	set cmderInstallDir=
	goto SetLocation
)

echo. && echo Running batch scripts...
call "%cmderInstallDir%\personal\batch scripts\%removeRegistryKeysBatFileName%"
call "%cmderInstallDir%\personal\batch scripts\%removeShortcutsBatFileName%"

echo. && echo Removing %cmderInstallDir%. This may take some time, please be patient...
rmdir /s /q %cmderInstallDir%
echo. && echo Cmder was removed. Some folders may still exist and will need to be removed manually.

pause

exit /b 0