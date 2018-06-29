@echo off

set fileName=IntegrateCmder.js
set filePath="%HOME%\batch scripts\%fileName%"

call node %filePath% "%CMDER_ROOT%"

exit /b 0
