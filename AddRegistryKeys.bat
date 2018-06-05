@echo off

:: Add new keys to RemoveRegistryKeys.bat!

:: This command will make the item show on the shift right-click menu only
:: @reg add "%keyNameHere%" /t REG_EXPAND_SZ /v "Extended" /d "" /f

:::: Add "Open Cmder here" to the shift right-click menu
set cmderExePath=%CMDER_ROOT%\Cmder.exe
set cmderBackgroundKey=HKEY_CLASSES_ROOT\Directory\Background\shell\Cmder
set cmderShellKey=HKEY_CLASSES_ROOT\Directory\shell\Cmder
set openCmderHereText=Open Cmder here

@reg add "%cmderBackgroundKey%" /t REG_EXPAND_SZ /v "Extended" /d "" /f 
@reg add "%cmderBackgroundKey%" /t REG_SZ /v "" /d "%openCmderHereText%" /f
@reg add "%cmderBackgroundKey%" /t REG_EXPAND_SZ /v "Icon" /d "%cmderExePath%,0" /f
@reg add "%cmderBackgroundKey%\command" /t REG_EXPAND_SZ /v "Extended" /d "" /f
@reg add "%cmderBackgroundKey%\command" /t REG_SZ /v "" /d "%cmderExePath% \"%%V\"" /f

@reg add "%cmderShellKey%" /t REG_EXPAND_SZ /v "Extended" /d "" /f
@reg add "%cmderShellKey%" /t REG_SZ /v "" /d "%openCmderHereText%" /f
@reg add "%cmderShellKey%" /t REG_EXPAND_SZ /v "Icon" /d "%cmderExePath%,0" /f
@reg add "%cmderShellKey%\command" /t REG_SZ /v "" /d "%cmderExePath% \"%%1\"" /f

:::: Add Sublime Text to the list of programs to open files with (for setting as default)
set sublimeExePath="%HOME%\sublime_text\sublime_text.exe"
set sublimeShellKey="HKEY_CLASSES_ROOT\Applications\sublime_text.exe\shell\open\command"

@reg add %sublimeShellKey% /t REG_EXPAND_SZ /v "" /d "%sublimeExePath% \"%%1\"" /f

:::: Add "Edit with Sublime Text" to the shift right-click menu for files and folders
set editWithSublimeText=Edit with Sublime Text 3
set openInSublimeText=Open in Sublime Text 3
set allFileTypesKey=HKEY_CLASSES_ROOT\*\shell\%editWithSublimeText%
set foldersKey=HKEY_CLASSES_ROOT\Directory\shell\%openInSublimeText%

@reg add "%allFileTypesKey%" /t REG_EXPAND_SZ /v "Extended" /d "" /f 
@reg add "%allFileTypesKey%" /t REG_SZ /v "" /d "%editWithSublimeText%"   /f
@reg add "%allFileTypesKey%" /t REG_EXPAND_SZ /v "Icon" /d "%sublimeExePath%,0" /f
@reg add "%allFileTypesKey%\command" /t REG_SZ /v "" /d "%sublimeExePath% \"%%1\"" /f

rem @reg add "%foldersKey%" /t REG_EXPAND_SZ /v "Extended" /d "" /f 
rem @reg add "%foldersKey%" /t REG_SZ /v "" /d "%openInSublimeText%"   /f
rem @reg add "%foldersKey%" /t REG_EXPAND_SZ /v "Icon" /d "%sublimeExePath%,0" /f
rem @reg add "%foldersKey%\command" /t REG_SZ /v "" /d "%sublimeExePath% \"%%1\"" /f

::: Add "Create new file here" to the shift right-click menu
set sublimeBackgroundKey=HKEY_CLASSES_ROOT\Directory\Background\shell\Sublime Text 3
set sublimeShellKey=HKEY_CLASSES_ROOT\Directory\shell\Sublime Text 3
set createNewFileHereText=Create new file here

@reg add "%sublimeBackgroundKey%" /t REG_EXPAND_SZ /v "Extended" /d "" /f
@reg add "%sublimeBackgroundKey%" /t REG_SZ /v "" /d "%createNewFileHereText%" /f
@reg add "%sublimeBackgroundKey%" /t REG_EXPAND_SZ /v "Icon" /d "%sublimeExePath%,0" /f
@reg add "%sublimeBackgroundKey%\command" /t REG_EXPAND_SZ /v "Extended" /d "" /f
@reg add "%sublimeBackgroundKey%\command" /t REG_SZ /v "" /d "%sublimeExePath% \"untitled\"" /f

rem @reg add "%sublimeShellKey%" /t REG_EXPAND_SZ /v "Extended" /d "" /f
rem @reg add "%sublimeShellKey%" /t REG_SZ /v "" /d "%createNewFileHereText%" /f
rem @reg add "%sublimeShellKey%" /t REG_EXPAND_SZ /v "Icon" /d "%sublimeExePath%,0" /f
rem @reg add "%sublimeShellKey%\command" /t REG_SZ /v "" /d "%sublimeExePath% \"%%1\untitled\"" /f

:::: Add cascading context menu for Sublime Text 3 when clicking on folders
set sublimeCascadingKey=HKEY_CLASSES_ROOT\Directory\shell\Sublime Text 3
set openInSublimeCommandKey=HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\%openInSublimeText%
set createNewFileCommandKey=HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\%createNewFileHereText%

@reg add "%sublimeCascadingKey%" /t REG_EXPAND_SZ /v "Extended" /d "" /f
@reg add "%sublimeCascadingKey%" /t REG_EXPAND_SZ /v "Icon" /d "%sublimeExePath%,0" /f
@reg add "%sublimeCascadingKey%" /t REG_EXPAND_SZ /v "MUIVerb" /d "Sublime Text 3" /f
@reg add "%sublimeCascadingKey%" /t REG_EXPAND_SZ /v "SubCommands" /d "%openInSublimeText%;%createNewFileHereText%" /f

@reg add "%openInSublimeCommandKey%" /t REG_EXPAND_SZ /v "Icon" /d "%sublimeExePath%,0" /f
@reg add "%openInSublimeCommandKey%" /t REG_SZ /v "" /d "%openInSublimeText%"   /f
@reg add "%openInSublimeCommandKey%\command" /t REG_SZ /v "" /d "%sublimeExePath% \"%%1\"" /f

@reg add "%createNewFileCommandKey%" /t REG_EXPAND_SZ /v "Icon" /d "%sublimeExePath%,0" /f
@reg add "%createNewFileCommandKey%" /t REG_SZ /v "" /d "%createNewFileHereText%" /f
@reg add "%createNewFileCommandKey%\command" /t REG_SZ /v "" /d "%sublimeExePath% \"untitled\"" /f

exit /b 0