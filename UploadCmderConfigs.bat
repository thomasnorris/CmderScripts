@echo off

set currentDir="%CD%"
set uploadDir="%CMDER_ROOT%\uploads"

:: Make sure this is the same name as what is in Dropbox now 
set configFileName="Config.7z"

set gitconfigPath="%CMDER_ROOT%\personal\.gitconfig"
set uploadFolderInDropbox="PneumaticTube Uploads"
set dropboxUrl="https://www.dropbox.com/home/PneumaticTube%%20Uploads"

rmdir /q /s %uploadDir%
mkdir %uploadDir%
cd /d %uploadDir%

:: These are the files/folders that will be added to the archive and uploaded
7za a %configFileName% %CMDER_ROOT%\config
7za a %configFileName% %CMDER_ROOT%\personal
7za a %configFileName% %CMDER_ROOT%\vendor\conemu-maximus5\ConEmu.xml

set /p SLOW=Are you uploading from a slow connection? (y/n) 
if [%SLOW%] == [y] (
	goto Manual
)

pneumatictube -f %configFileName% -p /%uploadFolderInDropbox%

:: Upload .gitconfig separately so it can be downloaded without the rest of the config
pneumatictube -f %gitconfigPath% -p /%uploadFolderInDropbox% && echo.

goto Finish

:Manual
copy %gitconfigPath% %uploadDir%
echo Take the files in %uploadDir% and manually upload to Dropbox.
pause
start "" %dropboxUrl%
explorer %uploadDir%

goto Finish

:Finish
cd /d %currentDir%

echo Upload completed.

exit /b 0