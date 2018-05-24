@echo off

cd /d "%~dp0"

call RemoveRegistryKeys.bat
echo.
call RemoveShortcuts.bat

cd /d "%1"

exit /b 0