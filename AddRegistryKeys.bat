@echo off

:: Add new keys to RemoveRegistryKeys.bat!

:::: Add "Open Cmder here" to the shift right-click menu
set cmderExePath=%CMDER_ROOT%\Cmder.exe
set cmderBackgroundKey=HKEY_CLASSES_ROOT\Directory\Background\shell\Cmder
set cmderShellKey=HKEY_CLASSES_ROOT\Directory\shell\Cmder

:: /t REG_EXPAND_SZ /v "Extended" /d "" /f makes it shift-right click
@reg add "%cmderBackgroundKey%" /t REG_EXPAND_SZ /v "Extended" /d "" /f 
@reg add "%cmderBackgroundKey%" /t REG_SZ /v "" /d "Open Cmder here" /f
@reg add "%cmderBackgroundKey%" /t REG_EXPAND_SZ /v "Icon" /d "%cmderExePath%,0" /f
@reg add "%cmderBackgroundKey%\command" /t REG_EXPAND_SZ /v "Extended" /d "" /f
@reg add "%cmderBackgroundKey%\command" /t REG_SZ /v "" /d "%cmderExePath% \"%%V\"" /f

@reg add "%cmderShellKey%" /t REG_EXPAND_SZ /v "Extended" /d "" /f
@reg add "%cmderShellKey%" /t REG_SZ /v "" /d "Open Cmder here" /f
@reg add "%cmderShellKey%" /t REG_EXPAND_SZ /v "Icon" /d "%cmderExePath%,0" /f
@reg add "%cmderShellKey%\command" /t REG_SZ /v "" /d "%cmderExePath% \"%%1\"" /f

:::: Add Sublime Text to the list of programs to open files with (for setting as default)
set sublimeExePath="%HOME%\sublime_text\sublime_text.exe"
set sublimeShellKey="HKEY_CLASSES_ROOT\Applications\sublime_text.exe\shell\open\command"

@reg add %sublimeShellKey% /t REG_EXPAND_SZ /v "" /d "%sublimeExePath% \"%%1\"" /f

:::: Add "Edit with Sublime Text" to the shift right-click menu for files and folders
set allFileTypesKey=HKEY_CLASSES_ROOT\*\shell\Edit with Sublime Text
set foldersKey=HKEY_CLASSES_ROOT\Directory\shell\Open in Sublime Text

@reg add "%allFileTypesKey%" /t REG_EXPAND_SZ /v "Extended" /d "" /f 
@reg add "%allFileTypesKey%" /t REG_SZ /v "" /d "Edit with Sublime Text"   /f
@reg add "%allFileTypesKey%" /t REG_EXPAND_SZ /v "Icon" /d "%sublimeExePath%,0" /f
@reg add "%allFileTypesKey%\command" /t REG_SZ /v "" /d "%sublimeExePath% \"%%1\"" /f

@reg add "%foldersKey%" /t REG_EXPAND_SZ /v "Extended" /d "" /f 
@reg add "%foldersKey%" /t REG_SZ /v "" /d "Open in Sublime Text"   /f
@reg add "%foldersKey%" /t REG_EXPAND_SZ /v "Icon" /d "%sublimeExePath%,0" /f
@reg add "%foldersKey%\command" /t REG_SZ /v "" /d "%sublimeExePath% \"%%1\"" /f

::: Add "Create file here" to the shift right-click menu
set sublimeBackgroundKey=HKEY_CLASSES_ROOT\Directory\Background\shell\Sublime Text
set sublimeShellKey=HKEY_CLASSES_ROOT\Directory\shell\Sublime Text

@reg add "%sublimeBackgroundKey%" /t REG_EXPAND_SZ /v "Extended" /d "" /f
@reg add "%sublimeBackgroundKey%" /t REG_SZ /v "" /d "Create file here" /f
@reg add "%sublimeBackgroundKey%" /t REG_EXPAND_SZ /v "Icon" /d "%sublimeExePath%,0" /f
@reg add "%sublimeBackgroundKey%\command" /t REG_EXPAND_SZ /v "Extended" /d "" /f
@reg add "%sublimeBackgroundKey%\command" /t REG_SZ /v "" /d "%sublimeExePath% \"untitled\"" /f

@reg add "%sublimeShellKey%" /t REG_EXPAND_SZ /v "Extended" /d "" /f
@reg add "%sublimeShellKey%" /t REG_SZ /v "" /d "Create file here" /f
@reg add "%sublimeShellKey%" /t REG_EXPAND_SZ /v "Icon" /d "%sublimeExePath%,0" /f
@reg add "%sublimeShellKey%\command" /t REG_SZ /v "" /d "%sublimeExePath% \"%%1\untitled\"" /f

exit /b 0