@echo off

set currentDir="%CD%"
set uploadDir="%CMDER_ROOT%\uploads"

set configArchiveName=Config.7z
set setupScriptsArchiveName=SetupScripts.zip
set gitconfigPath="%HOME%\.gitconfig"
:: Do not put quotes around the folder name here
set uploadFolderInDropbox=Cmder Uploads

:: Remove old uploads folder and recreate
if exist %uploadDir% (
	rmdir /q /s %uploadDir%
)
mkdir %uploadDir%
cd /d %uploadDir%

:: These are the files/folders that will be added to the config archive
:: Use -xr! to ignore files and folders
echo Adding files to "%configArchiveName%", please wait...
7za a %configArchiveName% "%CMDER_ROOT%\config" > nul
set vsCodeIgnoreRoot=personal\vscode\Data
7za a %configArchiveName% "%HOME%" -xr!"%vsCodeIgnoreRoot%\code\Cache*\" -xr!"%vsCodeIgnoreRoot%\code\logs\" -xr!"%vsCodeIgnoreRoot%\Temp\" > nul
7za a %configArchiveName% "%CMDER_ROOT%\vendor\conemu-maximus5\ConEmu.xml" > nul

:: Create a separate archive for the "Setup" scripts
echo Adding files to "%setupScriptsArchiveName%", please wait...
7za a %setupScriptsArchiveName% "%SCRIPTS_DIR%\Setup" > nul

set /p slowConnection=Are you uploading from a slow connection? (y/n)
if [%slowConnection%] == [y] (
	copy %gitconfigPath% %uploadDir%
	echo. && echo Take the files in %uploadDir% and manually upload to Dropbox.
	pause

	:: Replace any spaces in the upload folder name with %20 to create the URL
	setlocal enabledelayedexpansion
	set uploadFolderInDropbox=!uploadFolderInDropbox: =%%20!
	start "" "https://www.dropbox.com/home/%uploadFolderInDropbox%"
	explorer %uploadDir%

	goto Finish
)

:: Upload
call :Upload %configArchiveName%
call :Upload %setupScriptsArchiveName%
call :Upload %gitconfigPath%

echo Upload(s) completed.

:Finish
cd /d %currentDir%
exit /b 0

:Upload
pneumatictube -f %1 -p /"%uploadFolderInDropbox%"
exit /b 0