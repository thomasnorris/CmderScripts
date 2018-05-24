@echo off

call "%HOME%\batch scripts\AddRegistryKeys.bat"
echo.
call "%HOME%\batch scripts\CreateShortcuts.bat"

exit /b 0