@echo off

set currentDir="%CD%"
set uploadDir="%CMDER_ROOT%\uploads"
 
set configDownloadFileName=Config.7z
set gitconfigPath="%CMDER_ROOT%\personal\.gitconfig"
set uploadFolderInDropbox="PneumaticTube Uploads"
set dropboxUrl="https://www.dropbox.com/home/PneumaticTube%%20Uploads"

rmdir /q /s %uploadDir%
mkdir %uploadDir%
cd /d %uploadDir%

:: These are the files/folders that will be added to the archive and uploaded
7za a %configDownloadFileName% %CMDER_ROOT%\config
7za a %configDownloadFileName% %CMDER_ROOT%\personal
7za a %configDownloadFileName% %CMDER_ROOT%\vendor\conemu-maximus5\ConEmu.xml

set /p slowConnection=Are you uploading from a slow connection? (y/n) 
if [%slowConnection%] == [y] (
	copy %gitconfigPath% %uploadDir%
	echo. && echo Take the files in %uploadDir% and manually upload to Dropbox.
	pause
	start "" %dropboxUrl%
	explorer %uploadDir%

	goto Finish
)

:: upload the config file and .gitconfig separately
pneumatictube -f %configDownloadFileName% -p /%uploadFolderInDropbox%
pneumatictube -f %gitconfigPath% -p /%uploadFolderInDropbox%

echo Upload completed.

goto Finish

:Finish
cd /d %currentDir%
exit /b 0