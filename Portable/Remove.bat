@echo off
echo Run in an elevated command prompt if batch scripts were used.
echo This will remove Cmder. Close any instances of Cmder and Sublime Text before continuing. && echo.
pause
goto SetLocation

:SetLocation
set /p INSTALL_DIR=Where is Cmder located? (Default is the Desktop): 
if [%INSTALL_DIR%] == [] (
	set INSTALL_DIR="%USERPROFILE%\Desktop\Cmder"
) else (
	set INSTALL_DIR=%INSTALL_DIR%\Cmder
)

if not exist %INSTALL_DIR%\Cmder.exe (
	echo. && echo Cmder not found.
	set INSTALL_DIR=
	goto SetLocation
)

echo. && echo Running batch scripts...
call "%INSTALL_DIR%\personal\batch scripts\RemoveItemsFromRightClick.bat"
call "%INSTALL_DIR%\personal\batch scripts\RemoveShortcuts.bat"

echo. && echo Removing %INSTALL_DIR%. This may take some time, please be patient...
rmdir /s /q %INSTALL_DIR%
echo. && echo Cmder was removed. Some folders may still exist and will need to be removed manually.

pause

exit /b 0