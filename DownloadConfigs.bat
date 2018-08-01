@echo off

set dropboxLinkFileName=DropboxLink.txt
set configDownloadFileName=Config.7z
set batchAlias=addall

set removeRegistryKeysBat=%SCRIPTS_DIR%\RemoveRegistryKeys.bat
set removeShortcutsBat=%SCRIPTS_DIR%\RemoveShortcuts.bat

set startDir="%CD%"
cd /d "%~dp0"

echo Close any VSCode windows and stop other programs associated with Cmder before continuing.
echo Run in an elevated window to modify registry keys.
pause

set /p dropboxLink=< %dropboxLinkFileName%
if not exist %dropboxLinkFileName% (
	goto DropboxFileNotFound
)

:: Delete current files and run scripts
call %removeRegistryKeysBat%
call %removeShortcutsBat%

cd /d "%~dp0\.."
for /f "delims=" %%f in ('dir /b') do (
    :: Remove all files and folders unless specified here
    if not ["%%~nf"] == ["%SCRIPTS_FOLDER%"] if not ["%%~nf"] == ["7-zip"] (
        echo Removing %%f
        :: Test to see if it is a folder or a file and remove accordingly
        if exist %%~f\* (
            rmdir /s /q "%%~ff"
        ) else (
            del /q /s "%%~ff"
        )
    )
)
:: Delete the %CMDER_ROOT%\config folder
rmdir /q /s "%CMDER_ROOT%\config"

echo Downloading "%configDownloadFileName%"
set configDownloadPath="%CMDER_ROOT%\%configDownloadFileName%"
powershell "& { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest %dropboxLink% -OutFile %configDownloadPath% }" || goto ManualDownload

:ExtractAndMove
echo Extracting "%configDownloadFileName%"
7za x -y %configDownloadPath% -o%CMDER_ROOT% > nul

:: Move ConEmu.xml file to the correct directory
move /y %CMDER_ROOT%\ConEmu.xml %CMDER_ROOT%\vendor\conemu-maximus5

echo Cmder will open a new window with applied configs.
echo Run "%batchAlias%" in an elevated window to finish setup.
pause

:: Start Cmder
cmder

:: Delete downloaded file
del "%CMDER_ROOT%\%configDownloadFileName%"
exit /b 0

:ManualDownload
echo There was an issue downloading "%configDownloadFileName%".
echo A browser will open and try to download it.
echo If there is still an issue downloading, you will have to find a workaround or wait until a later time.
pause
start "" %dropboxLink%
echo Copy "%configDownloadFileName%" into "%CMDER_ROOT%" and then continue.
pause

:CheckFileExist
if not exist %configDownloadPath% (
	echo. && echo "%configDownloadPath%" does not exist and is required to continue.
	pause
	goto CheckFileExist
)
goto ExtractAndMove


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
