(function() {
    // NOTE: This is a helper for AddVscCmderIntegration.bat and must be called from inside that.
    // This script will modify VSCode's user settings.json file.

    var _fs = require('fs');

    const CMDER_ROOT = process.argv.slice(2)[0];
    const VSCODE_SETTIGNS_FILE = CMDER_ROOT + '\\personal\\vscode\\Data\\code\\User\\settings.json';
    const CMDER_INIT_FILE = CMDER_ROOT + '\\vendor\\init.bat';
    const NODE_EXE = CMDER_ROOT + '\\personal\\nodejs\\node.exe';

    _fs.readFile(VSCODE_SETTIGNS_FILE, 'utf8', (err, json) => {
        if (err)
            Error(err);
        else {
            try {
                json = JSON.parse(json);
            }
            catch (e) {
                Error(e);
            }

            // Edit any "node" launch configurations to explicitly set path to "node.exe"
            json["launch"]["configurations"].filter((el) => {
                return el["type"] === "node";
            }).forEach((config) => {
                config["runtimeExecutable"] = NODE_EXE;
            });

            // Only change the 2nd element in the array
            json["terminal.integrated.shellArgs.windows"][1] = CMDER_INIT_FILE;

            _fs.writeFile(VSCODE_SETTIGNS_FILE, JSON.stringify(json, null, 4), (err) => {
                if (err)
                    Error(err);
                else
                    console.log('VSCode settings updated successfully.');
            });
        }
    });

    function Error(e) {
        console.log('There was an error: ' + e);
        process.exit(0);
    }
})();
