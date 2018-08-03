@echo off

set cmderDownloadLink="https://github.com/cmderdev/cmder/releases/download/v1.3.5/cmder.7z"
set cmderDownloadFileName=Cmder.7z
set configDownloadFileName=Config.7z
set batchAlias=addall
set dropboxLinkFileName=DropboxLink.txt
set defaultDownloadLocation=%USERPROFILE%\Desktop

if not exist %dropboxLinkFileName% (
	goto DropboxFileNotFound
)

:: Set download location to be the root of the C: drive if %USERPROFILE% has spaces in the name
if not [%defaultDownloadLocation%] == [%defaultDownloadLocation: =%] (
	set defaultDownloadLocation=C:
)

:SetLocation
set /p cmderInstallDir=Where should Cmder be installed? [Press enter to default to "%defaultDownloadLocation%"]:
if [%cmderInstallDir%] == [] (
	set cmderInstallDir=%defaultDownloadLocation%
)
if not [%cmderInstallDir%] == [%cmderInstallDir: =%] (
	echo Install location cannot contain spaces.
	set cmderInstallDir=
	goto SetLocation
)
if not exist %cmderInstallDir% (
	echo "%cmderInstallDir%" does not exist.
	set cmderInstallDir=
	goto SetLocation
)

set cmderInstallDir=%cmderInstallDir%\Cmder
set cmderOutputFilePath=%cmderInstallDir%\%cmderDownloadFileName%
set /p dropboxLink=< %dropboxLinkFileName%
set configDownloadPath=%cmderInstallDir%\%configDownloadFileName%

if exist %cmderInstallDir%\Cmder.exe (
	echo Cmder is already installed.
	pause
	exit /b 0
)

mkdir %cmderInstallDir%

:: Download and manipulate files
call :DownloadFile %cmderDownloadLink% , %cmderOutputFilePath% , %cmderDownloadFileName%
call :DownloadFile %dropboxLink% , %configDownloadPath% , %configDownloadFileName%

:ExtractAndMove
call :ExtractArchive %cmderOutputFilePath% , %cmderInstallDir% , %cmderDownloadFileName%
call :ExtractArchive %configDownloadPath% , %cmderInstallDir% , %configDownloadFileName%

:: Move individual files to their directories
:: Note: anything changed here will need to be added to batch_scripts\DownloadConfigs.bat as well
move /y %cmderInstallDir%\ConEmu.xml %cmderInstallDir%\vendor\conemu-maximus5
move /y %cmderInstallDir%\Consolas-NF.ttf %cmderInstallDir%\vendor\conemu-maximus5\ConEmu

echo Downloaded successfully to "%cmderInstallDir%".
echo Cmder will now start. Run "%batchAlias%" in an elevated window to finish setup.
pause

%cmderInstallDir%\Cmder.exe

:: Delete the downloaded files
del %cmderOutputFilePath%
del %configDownloadPath%

:: End
exit /b 0

:ManualDownload
echo There was an issue downloading "%3".
echo A browser will open and try to download it.
echo If there is still an issue downloading, you will have to find a workaround or wait until a later time.
pause
start "" %1
echo Copy "%3" into "%cmderInstallDir%" and then continue.
pause

:CheckFileExist
if not exist %2 (
	echo. && echo "%2" does not exist and is required to continue.
	pause
	goto CheckFileExist
)
goto ExtractAndMove

:DownloadFile
echo Downloading "%3", please wait...
powershell -Command "& { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest %1 -OutFile %2 }" || goto ManualDownload %1 , %2 , %3
exit /b 0

:ExtractArchive
echo Extracting "%3", please wait...
7za x -y %1 -o%2 > nul
exit /b 0

:DropboxFileNotFound
echo %dropboxLinkFileName% is missing.

echo "" > %dropboxLinkFileName%
echo Paste the dropbox link in between the quotes above this line >> %dropboxLinkFileName%
echo Link should be structured like so (with quotes) >> %dropboxLinkFileName%
echo "https://dropbox.com/..../configfilename.ext?dl=1" >> %dropboxLinkFileName%
echo. && echo A template file has been generated and will open. Paste the link in the file and try again.
pause

start "" %dropboxLinkFileName%
exit /b 0