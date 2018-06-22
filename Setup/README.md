# Notes
- `Download.bat` file will download Cmder from their [GitHub page]("https://github.com/cmderdev/cmder") and config files stored in [Dropbox]("https://www.dropbox.com")
- `Remove.bat` batch file will remove Cmder and its related files

- If there is a path issue starting Cmder for the first time:
  - Copy this and paste it at the top of cmder_install_location\vendor\init.bat after @echo off:
    - `set PATH=%PATH:"=%`
  - Restart Cmder
