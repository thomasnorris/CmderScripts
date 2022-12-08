@echo off

set fileName=RemoveWindowsTerminalCmderIntegration.js
set filePath=%SCRIPTS_DIR%\%fileName%

call node %filePath% %USERPROFILE%

exit /b 0