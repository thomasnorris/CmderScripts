@echo off

set LINK_FILE_NAME="DropboxLink.txt"
set /p CONFIG_LINK=< %LINK_FILE_NAME%
set CONFIG_OUTPUT_DEST="%CMDER_ROOT%\Config.7z"
set FILE_NAME=Config.7z

if [%CONFIG_LINK%] == [""] (
	goto FileReadError
)

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
echo.
pause

cmder 

exit /b 0

:FileReadError
echo The file %LINK_FILE_NAME% was not found or the link has not been pasted in.
pause
echo "" > %LINK_FILE_NAME%
echo Paste the dropbox link in between the quotes above this line >> %LINK_FILE_NAME%
echo Link should be structured like so (with quotes) >> %LINK_FILE_NAME%
echo "https://dropbox.com/..../configfilename.ext?dl=1" >> %LINK_FILE_NAME%
echo. && echo A template file has been generated and will open. Paste the link and try again.
pause

start "" %LINK_FILE_NAME%

exit /b 0