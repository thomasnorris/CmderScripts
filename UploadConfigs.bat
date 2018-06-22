@echo off

set currentDir="%CD%"
set uploadDir="%CMDER_ROOT%\uploads"
 
set configArchiveName=Config.7z
set setupScriptsArchiveName=SetupScripts.zip
set gitconfigPath="%HOME%\.gitconfig"
set uploadFolderInDropbox="PneumaticTube Uploads"
set dropboxUrl="https://www.dropbox.com/home/PneumaticTube%%20Uploads"

echo Please close any instances of VSCode before continuing.
pause

:: Remove old uploads folder and recreate
call :RemoveDir %uploadDir%
mkdir %uploadDir%
cd /d %uploadDir%

:: Delete these before adding to the archive (cache)
call :RemoveDir "%HOME%\vscode\Data\code\Cache"
call :RemoveDir "%HOME%\vscode\Data\code\CachedData"
call :RemoveDir "%HOME%\vscode\Data\code\CachedExtensions"

:: These are the files/folders that will be added to the config archive
7za a %configArchiveName% "%CMDER_ROOT%\config"
7za a %configArchiveName% "%HOME%"
7za a %configArchiveName% "%CMDER_ROOT%\vendor\conemu-maximus5\ConEmu.xml"

:: Create a separate archive for the "Setup" batch scripts
7za a %setupScriptsArchiveName% "%HOME%\batch scripts\Setup"

set /p slowConnection=Are you uploading from a slow connection? (y/n) 
if [%slowConnection%] == [y] (
	copy %gitconfigPath% %uploadDir%
	echo. && echo Take the files in %uploadDir% and manually upload to Dropbox.
	pause
	start "" %dropboxUrl%
	explorer %uploadDir%

	goto Finish
)

:: Upload
call :Upload %configArchiveName%
call :Upload %setupScriptsArchiveName%
call :Upload %gitconfigPath%

echo. && echo Upload(s) completed.

:Finish
cd /d %currentDir%
exit /b 0

:RemoveDir
rmdir /q /s %1
exit /b 0

:Upload
pneumatictube -f %1 -p /%uploadFolderInDropbox%
exit /b 0