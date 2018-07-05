@echo off

:: Add new keys to RemoveRegistryKeys.bat!

:: This command will make the item show on the shift right-click menu only
:: reg add "%keyNameHere%" /t REG_EXPAND_SZ /v "Extended" /d "" /f

net session >nul 2>&1
if not [%ERRORLEVEL%] == [0] (
    echo Cannot add registry keys; permissions inadequate.
    exit /b 0
)
echo Adding registry keys...

set cmderName=Cmder
set vsCodeName=Visual Studio Code

:::: Add "Open %cmderName% here" to the context menu
set cmderExePath=%CMDER_ROOT%\Cmder.exe
set openCmderHereText=Open %cmderName% here
set cmderBackgroundKey=HKEY_CLASSES_ROOT\Directory\Background\shell\%cmderName%
set cmderShellKey=HKEY_CLASSES_ROOT\Directory\shell\%cmderName%

reg add "%cmderBackgroundKey%" /t REG_SZ /v "" /d "%openCmderHereText%" /f
reg add "%cmderBackgroundKey%" /t REG_EXPAND_SZ /v "Icon" /d "%cmderExePath%,0" /f
reg add "%cmderBackgroundKey%\command" /t REG_EXPAND_SZ /v "Extended" /d "" /f
reg add "%cmderBackgroundKey%\command" /t REG_SZ /v "" /d "%cmderExePath% \"%%V\"" /f

reg add "%cmderShellKey%" /t REG_SZ /v "" /d "%openCmderHereText%" /f
reg add "%cmderShellKey%" /t REG_EXPAND_SZ /v "Icon" /d "%cmderExePath%,0" /f
reg add "%cmderShellKey%\command" /t REG_SZ /v "" /d "%cmderExePath% \"%%1\"" /f

:::: Add %vsCodeName% to the list of programs to open files with (for setting as default)
set vscodeExePath="%HOME%\vscode\VSCodePortable.exe"
set vscodeShellKey=HKEY_CLASSES_ROOT\Applications\VSCodePortable.exe\shell\open\command

reg add %vscodeShellKey% /t REG_EXPAND_SZ /v "" /d "%vscodeExePath% \"%%1\"" /f

:::: Add "Edit with %vsCodeName%" to the context menu for files
set editWithVsCodeText=Edit with %vsCodeName%
set allFileTypesVsCodeKey=HKEY_CLASSES_ROOT\*\shell\%editWithVsCodeText%

reg add "%allFileTypesVsCodeKey%" /t REG_SZ /v "" /d "%editWithVsCodeText%" /f
reg add "%allFileTypesVsCodeKey%" /t REG_EXPAND_SZ /v "Icon" /d "%vscodeExePath%,0" /f
reg add "%allFileTypesVsCodeKey%\command" /t REG_SZ /v "" /d "%vscodeExePath% -n \"%%1\"" /f

:::: Add "Open in %vsCodeName%" to the context menu for folders
set openWithVsCodeText=Open in %vsCodeName%
set vsCodeFoldersKey=HKEY_CLASSES_ROOT\Directory\shell\%openWithVsCodeText%

reg add "%vsCodeFoldersKey%" /t REG_SZ /v "" /d "%openWithVsCodeText%"   /f
reg add "%vsCodeFoldersKey%" /t REG_EXPAND_SZ /v "Icon" /d "%vscodeExePath%,0" /f
reg add "%vsCodeFoldersKey%\command" /t REG_SZ /v "" /d "%vscodeExePath% -n \"%%1\"" /f

echo Registry keys added.

exit /b 0