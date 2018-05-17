# Notes
- Use these before using the batch files outside of this folder!
- The "Download" file will download Cmder and config files from Dropbox and Cmder's GitHub page.
- The "Remove" batch file will remove Cmder and its related files

- If there is a path issue starting Cmder for the first time:
  - Copy this and paste it at the top of cmder_install_location\vendor\init.bat after @echo off:
    - `set PATH=%PATH:"=%`
  - Restart Cmder
