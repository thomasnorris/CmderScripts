(function() {
    // NOTE: This is a helper for RemoveWindowsTerminalCmderIntegration.bat and must be called from inside that.
    // This script will restore Windows 11 Terminal's settings.json.bak file from the backup that was created when it was modified.

    var _fs = require('fs');
    var _path = require('path');

    const USER_PROFILE = process.argv.slice(2)[0];
    const TERMINAL_SETTINGS_FILE = USER_PROFILE + '\\AppData\\Local\\Packages\\Microsoft.WindowsTerminal_8wekyb3d8bbwe\\LocalState\\settings.json';
    const TERMINAL_SETTINGS_FILE_BAK = TERMINAL_SETTINGS_FILE + '.bak';

    // Is Terminal installed? (Are we on Windows 11?)
    if (!_fs.existsSync(_path.dirname(TERMINAL_SETTINGS_FILE))) {
        console.log('Windows Terminal does not exist, aborting.');
        process.exit(0);
    }

    // does the .bak exist?
    try {
        if (_fs.existsSync(TERMINAL_SETTINGS_FILE_BAK)) {
            // restore the backup
            _fs.copyFileSync(TERMINAL_SETTINGS_FILE_BAK, TERMINAL_SETTINGS_FILE);

            // delete the backup
            _fs.unlinkSync(TERMINAL_SETTINGS_FILE_BAK);
            console.log('Windows terminal settings restored.');
        }
        else {
            // we can assume that the backup was already restored
            console.log('Windows Terminal has already been modified, aborting.');
            process.exit(0);
        }
    }
    catch (err) {
        Error(err);
    }

    function Error(e) {
        console.log('There was an error: ' + e);
        process.exit(0);
    }
})();