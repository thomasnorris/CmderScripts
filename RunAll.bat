@echo off

cd /d "%~dp0"

:: defined in .gitconfig
call git cocl
call git com

call AddRegistryKeys.bat
echo.
call CreateShortcuts.bat

cd /d "%1"

exit /b 0
