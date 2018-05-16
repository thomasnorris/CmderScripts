@echo off

set CONFIG_LINK=
set CONFIG_OUTPUT_DEST="%CMDER_ROOT%\Config.7z"
set FILE_NAME=Config.7z

echo Downloading configs...
powershell -Command Invoke-WebRequest %CONFIG_LINK% -OutFile %CONFIG_OUTPUT_DEST% || goto ManualDownload

goto ExtratctAndMove


:ExtratctAndMove
:: Extract configs except for the folders/files that follow -xr!
7za x -y %CONFIG_OUTPUT_DEST% -o%CMDER_ROOT%

:: Move ConEmu.xml file to the correct directory
move /y %CMDER_ROOT%\ConEmu.xml %CMDER_ROOT%\vendor\conemu-maximus5

goto Finish

exit /b 0


:ManualDownload
echo There was an issue downloading from Dropbox. The browser will open and try to download %FILE_NAME%. 
pause
start "" %CONFIG_LINK%
echo If there is still an issue downloading, download the Dropbox desktop app and find %FILE_NAME%. 
echo Copy %FILE_NAME% into %CMDER_ROOT% and then continue.
pause

goto ExtratctAndMove

exit /b 0


:Finish
echo Cmder will open a new instance with applied configs; close this instance after.
pause

cmder 

exit /b 0