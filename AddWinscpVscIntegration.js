(function() {
    // NOTE: This is a helper for AddVscWinscpIntegration.bat and must be called from inside that.
    // This script will modify WinSCP's WinSCP.ini file.

    var _fs = require('fs');
    var _queryString = require('querystring');
    var _readline = require('readline');

    const CMDER_ROOT = process.argv.slice(2)[0];
    const VSCODE_EXE = CMDER_ROOT + '\\personal\\vscode\\Code.exe';
    const WINSCP_INI_FILE = CMDER_ROOT + '\\personal\\winscp\\WinSCP.ini';
    const WINSCP_INI_FILE_BAK = WINSCP_INI_FILE + '.bak';
    const WINSCP_INI_FILE_TEMP = WINSCP_INI_FILE + '.tmp';
    const EXTERNAL_EDITOR_REGEX = /^(ExternalEditor=).*/g;

    try {
        // backup current .ini
        _fs.copyFileSync(WINSCP_INI_FILE, WINSCP_INI_FILE_BAK);

        var rl = _readline.createInterface({
            input: _fs.createReadStream(WINSCP_INI_FILE),
            output: null,
            console: false
        });

        // read the file line by line and change the specific setting
        rl.on('line', (line) => {
            if (line.match(EXTERNAL_EDITOR_REGEX))
                // format: "ExternalEditor=url%20encoded%location.exe%20!.!"
                line = _queryString.stringify({ExternalEditor: VSCODE_EXE + ' !.!'}).replace('%3A', ':');

            _fs.appendFileSync(WINSCP_INI_FILE_TEMP, line + '\n', {encoding: 'utf8'});
        })
        .on('close', () => {
            // copy created file back to original file
            _fs.copyFileSync(WINSCP_INI_FILE_TEMP, WINSCP_INI_FILE);

            // delete temp file
            _fs.unlinkSync(WINSCP_INI_FILE_TEMP);

            console.log('WinSCP settings updated successfully.');
        });

    }
    catch (e) {
        Error(e);
    }

    function Error(e) {
        console.log('There was an error: ' + e);
        process.exit(0);
    }
})();