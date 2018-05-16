@echo off

set "PATH=%HOME%\nodejs;%PATH%"
echo node and npm are ready to be used now.

:: sets global npm packages to be installed in this location
npm config set prefix "%HOME%\.npm"
exit /b 0