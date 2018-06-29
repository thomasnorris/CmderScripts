@echo off

set dropboxLinkFileName=DropboxLink.txt
set configDownloadFileName=Config.7z
set addRegistryKeysFileName=AddRegistryKeys.bat
set removeRegistryKeysFileName=RemoveRegistryKeys.bat
set addShortcutsFileName=AddShortcuts.bat
set removeShortcutsFileName=RemoveShortcuts.bat
set addVscCmderIntegrationFileName=AddVscCmderIntegration.bat

set startDir=%CD%
cd /d "%~dp0"

echo Close any VSCode instances and stop other programs associated with Cmder before continuing.
echo Run in an elevated window to modify registry keys.
pause

set /p dropboxLink=< %dropboxLinkFileName%
if not exist %dropboxLinkFileName% (
	goto FileNotExist
)

:: Delete current files and run scripts
echo Removing shortcuts and registry keys
call "%HOME%\batch scripts\%removeRegistryKeysFileName%"
call "%HOME%\batch scripts\%removeShortcutsFileName%"

echo Deleting old files
cd /d "%~dp0\.."
for /f "delims=" %%f in ('dir /b') do (
    if not ["%%~nf"] == ["batch scripts"] if not ["%%~nf"] == ["7-zip"] (
        echo Removing %%f
        :: Test to see if a file or folder
        if exist %%~f\* (
            rmdir /s /q "%%~ff"
        ) else (
            del /q /s "%%~ff"
        )
    )
)
echo Done.
echo Downloading new files...
set configDownloadPath="%CMDER_ROOT%\%configDownloadFileName%"
powershell -Command Invoke-WebRequest %dropboxLink% -OutFile %configDownloadPath% || goto ManualDownload

goto ExtractAndMove

:ExtractAndMove
:: Extract configs
7za x -y %configDownloadPath% -o%CMDER_ROOT%

:: Move ConEmu.xml file to the correct directory
move /y %CMDER_ROOT%\ConEmu.xml %CMDER_ROOT%\vendor\conemu-maximus5

:: Run batch scripts
call "%HOME%\batch scripts\%addRegistryKeysFileName%"
call "%HOME%\batch scripts\%addShortcutsFileName%"
call "%HOME%\batch scripts\%addVscCmderIntegrationFileName%"

echo. && echo Cmder will open a new instance with applied configs. Close this instance after. && echo.
pause

:: Start Cmder
cmder

:: Delete downloaded file
del %CMDER_ROOT%\%configDownloadFileName%
exit /b 0

:ManualDownload
echo There was an issue downloading from Dropbox. The browser will open and try to download %configDownloadFileName%.
pause
start "" %dropboxLink%
echo If there is still an issue downloading, download the Dropbox desktop app and find %configDownloadFileName%.
echo Copy %configDownloadFileName% into %CMDER_ROOT% and then continue.
pause

goto ExtractAndMove


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