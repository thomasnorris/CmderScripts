@echo off

:: Add new keys to RemoveRegistryKeys.bat!

:: This command will make the item show on the shift right-click menu only
:: reg add "%keyNameHere%" /t REG_EXPAND_SZ /v "Extended" /d "" /f

echo Administrative permissions required. Detecting permissions...
net session >nul 2>&1
if %ERRORLEVEL% == 0 (
    echo Success: Administrative permissions confirmed, adding registry keys.
    goto AddKeys
) else (
    echo Failure: Current permissions inadequate, cannot add registry keys.
    exit /b 0
)

:AddKeys
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

REM :::: Add "Edit with %vsCodeName%" to the context menu for files
REM set editWithVsCodeText=Edit with %vsCodeName%
REM set allFileTypesVsCodeKey=HKEY_CLASSES_ROOT\*\shell\%editWithVsCodeText%

REM reg add "%allFileTypesVsCodeKey%" /t REG_SZ /v "" /d "%editWithVsCodeText%" /f
REM reg add "%allFileTypesVsCodeKey%" /t REG_EXPAND_SZ /v "Icon" /d "%vscodeExePath%,0" /f
REM reg add "%allFileTypesVsCodeKey%\command" /t REG_SZ /v "" /d "%vscodeExePath% \"%%1\"" /f

REM :::: Add "Open in %vsCodeName%" to the context menu for folders
REM set openWithVsCodeText=Open in %vsCodeName%
REM set vsCodeFoldersKey=HKEY_CLASSES_ROOT\Directory\shell\%openWithVsCodeText%

REM reg add "%vsCodeFoldersKey%" /t REG_SZ /v "" /d "%openWithVsCodeText%"   /f
REM reg add "%vsCodeFoldersKey%" /t REG_EXPAND_SZ /v "Icon" /d "%vscodeExePath%,0" /f
REM reg add "%vsCodeFoldersKey%\command" /t REG_SZ /v "" /d "%vscodeExePath% \"%%1\"" /f

echo Registry keys added.

exit /b 0