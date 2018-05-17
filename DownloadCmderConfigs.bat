@echo off

set dropboxLinkFileName="DropboxLink.txt"
set /p dropboxLink=< %dropboxLinkFileName%
set configDownloadDir="%CMDER_ROOT%\Config.7z"
set configFileName=Config.7z

if not exist %dropboxLinkFileName% (
	goto FileNotExist
)

echo Downloading configs...
powershell -Command Invoke-WebRequest %dropboxLink% -OutFile %configDownloadDir% || goto ManualDownload

goto ExtratctAndMove


:ExtratctAndMove
:: Extract configs except for the folders/files that follow -xr!
7za x -y %configDownloadDir% -o%CMDER_ROOT%

:: Move ConEmu.xml file to the correct directory
move /y %CMDER_ROOT%\ConEmu.xml %CMDER_ROOT%\vendor\conemu-maximus5

goto Finish

exit /b 0


:ManualDownload
echo There was an issue downloading from Dropbox. The browser will open and try to download %configFileName%.
pause
start "" %dropboxLink%
echo If there is still an issue downloading, download the Dropbox desktop app and find %configFileName%. 
echo Copy %configFileName% into %CMDER_ROOT% and then continue.
pause

goto ExtratctAndMove

exit /b 0


:Finish
echo Cmder will open a new instance with applied configs; close this instance after.
echo.
pause

cmder 

exit /b 0

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