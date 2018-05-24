@echo off

cd /d "%~dp0"
:: defined in .gitconfig - checkout, clean, and pull
call git coclp

call AddRegistryKeys.bat
echo.
call CreateShortcuts.bat

cd /d "%1"

exit /b 0
