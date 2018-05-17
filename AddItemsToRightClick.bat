@echo off

:: Add "Open Cmder here" to the shift-right click menu
set cmderExePath=%CMDER_ROOT%\Cmder.exe
set cmderBackgroundKey=HKEY_CLASSES_ROOT\Directory\Background\shell\Cmder
set cmderShellKey=HKEY_CLASSES_ROOT\Directory\shell\Cmder

@reg add "%cmderBackgroundKey%" /t REG_EXPAND_SZ /v "Extended" /d "" /f
@reg add "%cmderBackgroundKey%" /t REG_SZ /v "" /d "Open Cmder here" /f
@reg add "%cmderBackgroundKey%" /t REG_EXPAND_SZ /v "Icon" /d "%cmderExePath%,0" /f

@reg add "%cmderBackgroundKey%\command" /t REG_EXPAND_SZ /v "Extended" /d "" /f
@reg add "%cmderBackgroundKey%\command" /t REG_SZ /v "" /d "%cmderExePath% \"%%V\"" /f

@reg add "%cmderShellKey%" /t REG_SZ /v "" /d "Open Cmder here" /f
@reg add "%cmderShellKey%" /t REG_EXPAND_SZ /v "Icon" /d "%cmderExePath%,0" /f

@reg add "%cmderShellKey%\command" /t REG_SZ /v "" /d "%cmderExePath% \"%%1\"" /f

:: Add Sublime Text to the list of programs to open files with (for setting as default)
set sublimePath="%HOME%\sublime_text\sublime_text.exe"
set sublimeShellKey="HKEY_CLASSES_ROOT\Applications\sublime_text.exe\shell\open\command"

@reg add %sublimeShellKey% /t REG_EXPAND_SZ /v "" /d "%sublimePath% \"%%1\"" /f

:: Add "Edit with Sublime Text" to the right click menu
set allFileTypesKey=HKEY_CLASSES_ROOT\*\shell\Edit with Sublime Text

@reg add "%allFileTypesKey%" /t REG_SZ /v "" /d "Edit with Sublime Text"   /f
@reg add "%allFileTypesKey%" /t REG_EXPAND_SZ /v "Icon" /d "%sublimePath%,0" /f
@reg add "%allFileTypesKey%\command" /t REG_SZ /v "" /d "%sublimePath% \"%%1\"" /f

exit /b 0