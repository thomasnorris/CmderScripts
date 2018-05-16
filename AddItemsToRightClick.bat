@echo off

:: Add "Open Cmder here" to the shift-right click menu
set CMDER=%CMDER_ROOT%\Cmder.exe
set CMDER_BACKGROUND_KEY=HKEY_CLASSES_ROOT\Directory\Background\shell\Cmder
set CMDER_SHELL_KEY=HKEY_CLASSES_ROOT\Directory\shell\Cmder

@reg add "%CMDER_BACKGROUND_KEY%" /t REG_EXPAND_SZ /v "Extended" /d "" /f
@reg add "%CMDER_BACKGROUND_KEY%" /t REG_SZ /v "" /d "Open Cmder here" /f
@reg add "%CMDER_BACKGROUND_KEY%" /t REG_EXPAND_SZ /v "Icon" /d "%CMDER%,0" /f

@reg add "%CMDER_BACKGROUND_KEY%\command" /t REG_EXPAND_SZ /v "Extended" /d "" /f
@reg add "%CMDER_BACKGROUND_KEY%\command" /t REG_SZ /v "" /d "%CMDER% \"%%V\"" /f

@reg add "%CMDER_SHELL_KEY%" /t REG_SZ /v "" /d "Open Cmder here" /f
@reg add "%CMDER_SHELL_KEY%" /t REG_EXPAND_SZ /v "Icon" /d "%CMDER%,0" /f

@reg add "%CMDER_SHELL_KEY%\command" /t REG_SZ /v "" /d "%CMDER% \"%%1\"" /f

:: Add Sublime Text to the list of programs to open files with (for setting as default)
set SUBL_PATH="%HOME%\sublime_text\sublime_text.exe"
set KEY="HKEY_CLASSES_ROOT\Applications\sublime_text.exe\shell\open\command"

@reg add %KEY% /t REG_EXPAND_SZ /v "" /d "%SUBL_PATH% \"%%1\"" /f

:: Add "Edit with Sublime Text" to the right click menu
set ALL_FILE_TYPES_KEY=HKEY_CLASSES_ROOT\*\shell\Edit with Sublime Text

@reg add "%ALL_FILE_TYPES_KEY%" /t REG_SZ /v "" /d "Edit with Sublime Text"   /f
@reg add "%ALL_FILE_TYPES_KEY%" /t REG_EXPAND_SZ /v "Icon" /d "%SUBL_PATH%,0" /f
@reg add "%ALL_FILE_TYPES_KEY%\command" /t REG_SZ /v "" /d "%SUBL_PATH% \"%%1\"" /f

exit /b 0