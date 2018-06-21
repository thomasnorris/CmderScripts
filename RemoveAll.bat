@echo off

cd /d "%~dp0"

call RemoveRegistryKeys.bat
echo.
call RemoveShortcuts.bat

if not ["%1"] == [""] (
    cd /d "%1"
)

exit /b 0