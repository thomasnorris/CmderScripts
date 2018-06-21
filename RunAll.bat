@echo off

cd /d "%~dp0"

call AddRegistryKeys.bat
echo.
call CreateShortcuts.bat

if not ["%1"] == [""] (
    cd /d "%1"
)

exit /b 0
