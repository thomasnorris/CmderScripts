@echo off
echo Run in an elevated command prompt if batch scripts were used.
echo This will remove Cmder. Close any instances of Cmder and Sublime Text before continuing. && echo.
pause
goto SetLocation

:SetLocation
set /p cmderInstallDir=Where is Cmder located? (Default is the Desktop): 
if [%cmderInstallDir%] == [] (
	set cmderInstallDir="%USERPROFILE%\Desktop\Cmder"
) else (
	set cmderInstallDir=%cmderInstallDir%\Cmder
)

if not exist %cmderInstallDir%\Cmder.exe (
	echo. && echo Cmder not found.
	set cmderInstallDir=
	goto SetLocation
)

echo. && echo Running batch scripts...
call "%cmderInstallDir%\personal\batch scripts\RemoveItemsFromRightClick.bat"
call "%cmderInstallDir%\personal\batch scripts\RemoveShortcuts.bat"

echo. && echo Removing %cmderInstallDir%. This may take some time, please be patient...
rmdir /s /q %cmderInstallDir%
echo. && echo Cmder was removed. Some folders may still exist and will need to be removed manually.

pause

exit /b 0