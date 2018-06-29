(function() {
    // NOTE: This is a helper for another batch script. Do not run on its own.
    // This file will take the VSCode user settings.json and modify it.

    var _fs = require('fs');

    const CMDER_ROOT = process.argv.slice(2)[0];
    const CMDER_INIT_FILE = CMDER_ROOT + '\\vendor\\init.bat';
    const VSCODE_SETTIGNS_FILE = CMDER_ROOT + '\\personal\\vscode\\Data\\code\\User\\settings.json';
    const JSON_KEY = "terminal.integrated.shellArgs.windows";
    const KEY_ARR_0 = "/K";

    _fs.readFile(VSCODE_SETTIGNS_FILE, 'utf8', (err, json) => {
        if (err)
            Error(err);
        else {
            json = JSON.parse(json);
            json[JSON_KEY] = [KEY_ARR_0, CMDER_INIT_FILE];
            var jsonString = JSON.stringify(json, null, 4);

            _fs.writeFile(VSCODE_SETTIGNS_FILE, jsonString, (err) => {
                if (err)
                    Error(err);
                else
                    console.log('The file was saved successfully.');
            });
        }
    });

    function Error(e) {
        console.log('There was an error: ' + e);
        process.exit(0);
    }
})();
