(function() {
    // NOTE: This is a helper for AddWindowsTerminalCmderIntegration.bat and must be called from inside that.
    // This script will modify Windows 11 Terminal's settings.json file.

    var _fs = require('fs');
    var _path = require('path');

    const CMDER_ROOT = process.argv.slice(2)[0];
    const USER_PROFILE = process.argv.slice(2)[1];
    const TERMINAL_SETTINGS_FILE = USER_PROFILE + '\\AppData\\Local\\Packages\\Microsoft.WindowsTerminal_8wekyb3d8bbwe\\LocalState\\settings.json';
    const TERMINAL_SETTINGS_FILE_BAK = TERMINAL_SETTINGS_FILE + '.bak';
    const GUID = "{f1ee065c-1a26-4339-b01d-661e4fda94e5}";

    // these profile names will be modified to have their start directory be the working directory of Terminal
    const NULL_STARTING_DIR_PROFILE_NAMES = ['Windows PowerShell', 'Command Prompt'];

    // run cmder init.bat as administrator
    const PROFILE_JSON = {
        "commandline": "%SystemRoot%\\System32\\cmd.exe /k \"" + CMDER_ROOT + "\\vendor\\init.bat\"",
        "elevate": true,
        "guid": GUID,
        "hidden": false,
        "icon": CMDER_ROOT + "\\icons\\cmder.ico",
        "name": "Cmder",
        "startingDirectory": CMDER_ROOT
    }

    // Is Terminal installed? (Are we on Windows 11?)
    if (!_fs.existsSync(_path.dirname(TERMINAL_SETTINGS_FILE))) {
        console.log('Windows Terminal does not exist, aborting.');
        process.exit(0);
    }

    // see if a backup exists, create one if it doesn't
    try {
        if (!_fs.existsSync(TERMINAL_SETTINGS_FILE_BAK)) {
            _fs.copyFileSync(TERMINAL_SETTINGS_FILE, TERMINAL_SETTINGS_FILE_BAK);
        }
        else {
            // we can assume that the file was already modified
            console.log('Windows Terminal has already been modified, aborting.');
            process.exit(0);
        }
    }
    catch (err) {
        Error(err);
    }

    // modify the file
    _fs.readFile(TERMINAL_SETTINGS_FILE, 'utf-8', (err, json) => {
        if (err) {
            Error(err);
        }
        else {
            try {
                json = JSON.parse(json);
            }
            catch (e) {
                Error(e);
            }

            // loop through all profiles, set "startingDirectory": null to make it the parent directory
            // if "open in Terminal" is used, that directory is where new windows will open
            json['profiles']['list'].filter((item) => {
                return NULL_STARTING_DIR_PROFILE_NAMES.includes(item['name']);
            }).forEach((item) => {
                item['startingDirectory'] = null;
            });

            // add the new profile
            json['profiles']['list'].push(PROFILE_JSON);

            // modify the default
            json['defaultProfile'] = GUID;

            // write the file back
            _fs.writeFile(TERMINAL_SETTINGS_FILE, JSON.stringify(json, null, 4), (err) => {
                if (err) {
                    Error(err);
                }
                else {
                    console.log('Windows Terminal settings updated successfully.');
                }
            });
        }
    });

    function Error(e) {
        console.log('There was an error: ' + e);
        process.exit(0);
    }
})();