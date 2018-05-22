@echo off

set startDir=%CD%
cd /d "%~dp0"

set dropboxLinkFileName=DropboxLink.txt
set configDownloadFileName=Config.7z

set /p dropboxLink=< %dropboxLinkFileName%
if not exist %dropboxLinkFileName% (
	goto FileNotExist
)

set configDownloadPath="%CMDER_ROOT%\%configDownloadFileName%"
echo Downloading...
powershell -Command Invoke-WebRequest %dropboxLink% -OutFile %configDownloadPath% || goto ManualDownload

goto ExtratctAndMove

:ExtratctAndMove
:: Extract configs
7za x -y %configDownloadPath% -o%CMDER_ROOT%

:: Move ConEmu.xml file to the correct directory
move /y %CMDER_ROOT%\ConEmu.xml %CMDER_ROOT%\vendor\conemu-maximus5

echo Cmder will open a new instance with applied configs; close this instance after. && echo.
pause

:: Start Cmder
cmder 

:: End
cd /d "%startDir%"
exit /b 0

:ManualDownload
echo There was an issue downloading from Dropbox. The browser will open and try to download %configDownloadFileName%.
pause
start "" %dropboxLink%
echo If there is still an issue downloading, download the Dropbox desktop app and find %configDownloadFileName%. 
echo Copy %configDownloadFileName% into %CMDER_ROOT% and then continue.
pause

goto ExtratctAndMove


:FileNotExist
echo %dropboxLinkFileName% is missing.

echo "" > %dropboxLinkFileName%
echo Paste the dropbox link in between the quotes above this line >> %dropboxLinkFileName%
echo Link should be structured like so (with quotes) >> %dropboxLinkFileName%
echo "https://dropbox.com/..../configfilename.ext?dl=1" >> %dropboxLinkFileName%
echo. && echo A template file has been generated and will open. Paste the link in the file and try again.
pause

start "" %dropboxLinkFileName%

exit /b 0