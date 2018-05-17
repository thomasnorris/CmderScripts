@echo off

:: add 7-zip to the path (make sure 7-zip folder is in the same directory as this file)
set "PATH=%CD%\7-zip;%PATH%"
goto SetLocation

:SetLocation
set /p INSTALL_DIR=Where should Cmder be downloaded? (Default is the Desktop): 
if [%INSTALL_DIR%] == [] (
	set INSTALL_DIR=%USERPROFILE%\Desktop
)

if not exist %INSTALL_DIR% (
	echo. && echo That is not a valid directory.
	set INSTALL_DIR=
	goto SetLocation
)

set INSTALL_DIR=%INSTALL_DIR%\Cmder

set CMDER_LINK="https://github.com/cmderdev/cmder/releases/download/v1.3.5/cmder.7z"
set CMDER_OUTPUT_FILE=%INSTALL_DIR%\Cmder.7z
set LINK_FILE_NAME="DropboxLink.txt"
set /p CONFIG_LINK=< %LINK_FILE_NAME%
set CONFIG_OUTPUT_FILE=%INSTALL_DIR%\Config.7z

if not exist %LINK_FILE_NAME% (
	echo %LINK_FILE_NAME% is missing.

	echo "" > %LINK_FILE_NAME%
	echo Paste the dropbox link in between the quotes above this line >> %LINK_FILE_NAME%
	echo Link should be structured like so (with quotes) >> %LINK_FILE_NAME%
	echo "https://dropbox.com/..../configfilename.ext?dl=1" >> %LINK_FILE_NAME%
	echo. && echo A template file has been generated and will open. Paste the link in the file and try again.
	pause

	start "" %LINK_FILE_NAME%

	exit /b 0
)

mkdir %INSTALL_DIR%

echo Downloading Cmder from their website... && echo.
call :DownloadFile %CMDER_LINK% , %CMDER_OUTPUT_FILE%

echo Downloading config files from Dropbox... && echo.
call :DownloadFile %CONFIG_LINK% , %CONFIG_OUTPUT_FILE%

goto ExtractAndDelete

:ExtractAndDelete
call :ExtractArchive %CMDER_OUTPUT_FILE% , %INSTALL_DIR%
call :ExtractArchive %CONFIG_OUTPUT_FILE% , %INSTALL_DIR%

:: Move ConEmu.xml file to the correct directory
move /y %INSTALL_DIR%\ConEmu.xml %INSTALL_DIR%\vendor\conemu-maximus5

del %CMDER_OUTPUT_FILE%
del %CONFIG_OUTPUT_FILE%

echo. && echo Downloaded successfully to %INSTALL_DIR%. && echo.
echo Cmder will now start. Run "runbat" in an elevated window to finish setup. && echo.
pause

%INSTALL_DIR%\Cmder.exe

exit /b 0

:: functions
:ManualDownload
echo. && echo There was an issue downloading a file from %1. && echo.
echo A browser will open and try to download it. && echo.
pause
start "" %1
echo. && echo If there is still an issue downloading, you will have to find a workaround or wait until a later time. && echo.
echo Copy the downloaded file into %INSTALL_DIR% and then continue. && echo.
pause

goto CheckFileExist

:CheckFileExist
if not exist %2 (
	echo. && echo The file does not exist in %INSTALL_DIR%. Copy it there before continuing. && echo.
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
