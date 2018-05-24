@echo off

call "%HOME%\batch scripts\RemoveRegistryKeys.bat"
echo.
call "%HOME%\batch scripts\RemoveShortcuts.bat"

exit /b 0