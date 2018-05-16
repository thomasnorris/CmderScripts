@echo off

set CURRENT_DIR="%CD%"
set UPLOAD_DIR="%CMDER_ROOT%\uploads"

:: Make sure this is the same name as what is in Dropbox now 
set CONFIG_NAME="Config.7z"

set GITCONFIG="%CMDER_ROOT%\personal\.gitconfig"
set DROPBOX_FOLDER_NAME="PneumaticTube Uploads"
set DROPBOX_URL="https://www.dropbox.com/home/PneumaticTube%%20Uploads"

rmdir /q /s %UPLOAD_DIR%
mkdir %UPLOAD_DIR%
cd /d %UPLOAD_DIR%

:: These are the files/folders that will be added to the archive and uploaded
7za a %CONFIG_NAME% %CMDER_ROOT%\config
7za a %CONFIG_NAME% %CMDER_ROOT%\personal
7za a %CONFIG_NAME% %CMDER_ROOT%\vendor\conemu-maximus5\ConEmu.xml

set /p SLOW=Are you uploading from a slow connection? (y/n) 
if [%SLOW%] == [y] (
	goto Manual
)

pneumatictube -f %CONFIG_NAME% -p /%DROPBOX_FOLDER_NAME%

:: Upload .gitconfig separately so it can be downloaded without the rest of the config
pneumatictube -f %GITCONFIG% -p /%DROPBOX_FOLDER_NAME% && echo.

goto Finish

:Manual
copy %GITCONFIG% %UPLOAD_DIR%
echo Take the files in %UPLOAD_DIR% and manually upload to Dropbox.
pause
start "" %DROPBOX_URL%
explorer %UPLOAD_DIR%

goto Finish

:Finish
cd /d %CURRENT_DIR%

echo Upload completed.

exit /b 0