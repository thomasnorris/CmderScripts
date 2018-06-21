@echo off

echo This will remove Cmder from the system.
echo Close and VSCode instances and stop other programs associated with Cmder before continuing.
echo Run in an elevated window to remove registry keys.
pause

set cmderInstallFolderName=Cmder
set removeAllFileName=RemoveAll.bat

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
call "%cmderInstallDir%\personal\batch scripts\%removeAllFileName%"

echo. && echo Removing %cmderInstallDir%. This may take some time, please be patient...
rmdir /s /q %cmderInstallDir%
echo. && echo Cmder was removed. Some folders may still exist and will need to be removed manually.

pause

exit /b 0