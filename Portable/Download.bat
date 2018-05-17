@echo off

:: add 7-zip to the path (make sure 7za.exe is in the same directory as this file)
set "PATH=%CD%;%PATH%"
goto SetLocation

:SetLocation
set /p cmderInstallDir=Where should Cmder be downloaded? (Default is the Desktop): 
if [%cmderInstallDir%] == [] (
	set cmderInstallDir=%USERPROFILE%\Desktop
)

if not exist %cmderInstallDir% (
	echo. && echo That is not a valid directory.
	set cmderInstallDir=
	goto SetLocation
)

set cmderInstallDir=%cmderInstallDir%\Cmder

set cmderDownloadLink="https://github.com/cmderdev/cmder/releases/download/v1.3.5/cmder.7z"
set cmderOutputFilePath=%cmderInstallDir%\Cmder.7z
set dropboxLinkFileName="DropboxLink.txt"
set /p dropboxLink=< %dropboxLinkFileName%
set configDownloadPath=%cmderInstallDir%\Config.7z

if not exist %dropboxLinkFileName% (
	goto FileNotExist
)

mkdir %cmderInstallDir%

echo Downloading Cmder from their website... && echo.
call :DownloadFile %cmderDownloadLink% , %cmderOutputFilePath%

echo Downloading config files from Dropbox... && echo.
call :DownloadFile %dropboxLink% , %configDownloadPath%

goto ExtractAndDelete

:ExtractAndDelete
call :ExtractArchive %cmderOutputFilePath% , %cmderInstallDir%
call :ExtractArchive %configDownloadPath% , %cmderInstallDir%

:: Move ConEmu.xml file to the correct directory
move /y %cmderInstallDir%\ConEmu.xml %cmderInstallDir%\vendor\conemu-maximus5

del %cmderOutputFilePath%
del %configDownloadPath%

echo. && echo Downloaded successfully to %cmderInstallDir%. && echo.
echo Cmder will now start. Run "runbat" in an elevated window to finish setup. && echo.
pause

%cmderInstallDir%\Cmder.exe

exit /b 0

:: functions
:ManualDownload
echo. && echo There was an issue downloading a file from %1. && echo.
echo A browser will open and try to download it. && echo.
pause
start "" %1
echo. && echo If there is still an issue downloading, you will have to find a workaround or wait until a later time. && echo.
echo Copy the downloaded file into %cmderInstallDir% and then continue. && echo.
pause

goto CheckFileExist

:CheckFileExist
if not exist %2 (
	echo. && echo The file does not exist in %cmderInstallDir%. Copy it there before continuing. && echo.
	pause
	goto CheckFileExist
)

exit /b 0

:DownloadFile
powershell -Command "& { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest %1 -OutFile %2 }" || goto ManualDownload %1

exit /b 0

:ExtractArchive
7za x -y %1 -o%2

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