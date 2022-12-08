@echo off

set fileName=AddWindowsTerminalCmderIntegration.js
set filePath=%SCRIPTS_DIR%\%fileName%

call node %filePath% %CMDER_ROOT% %USERPROFILE%

exit /b 0