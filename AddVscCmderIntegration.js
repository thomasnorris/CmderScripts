(function() {
    // NOTE: This is a helper for AddVscCmderIntegration.bat and must be called from inside that.
    // This script will modify VSCode's user settings.json file.

    var _fs = require('fs');

    const CMDER_ROOT = process.argv.slice(2)[0];
    const VSCODE_SETTIGNS_FILE = CMDER_ROOT + '\\personal\\vscode\\data\\user-data\\User\\settings.json';
    const CMDER_INIT_FILE = CMDER_ROOT + '\\vendor\\init.bat';
    const NODE_EXE = CMDER_ROOT + '\\personal\\nodejs\\node.exe';
    const GIT_EXE = CMDER_ROOT + '\\vendor\\git-for-windows\\cmd\\git.exe';

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

            // Only set the second element to the init.bat file
            json["terminal.integrated.shellArgs.windows"][1] = CMDER_INIT_FILE;

            // Specify git path
            json["git.path"] = GIT_EXE;

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
