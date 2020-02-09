@echo off
Setlocal EnableDelayedExpansion

:: Assuming this file is in the root of the %HOME% directory
:: Must match in user-profile.cmd!
set configRevisionFile=config_revision.txt

:: These must match the same variables in UploadConfigs.bat
set uploadFolderInDropbox=Cmder Files
set configArchiveName=Config.7z

set revs=
for /f %%a in ('dbxcli revs "/%uploadFolderInDropbox%/%configArchiveName%"') do (
    set revs=!revs! %%a
)

for /f "tokens=1" %%a in ("%revs%") do (
    set rev=%%a
)

Setlocal DisableDelayedExpansion

echo %rev% > "%HOME%\%configRevisionFile%"
echo Config file revision %rev% stored.

exit /b 0