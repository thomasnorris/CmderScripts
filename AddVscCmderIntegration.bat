@echo off

set fileName=AddVscCmderIntegration.js
set filePath=%SCRIPTS_DIR%\%fileName%

call node %filePath% %CMDER_ROOT%

exit /b 0
