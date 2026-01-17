@echo off
REM Main
call :RemoveSymlink
goto :eof

REM Functions
REM 1
:RemoveSymlink
dir /s /a "%appdata%" | find /i "Anydesk" | find /i "<JUNCTION>" || exit /b 0
rd /Q /S "%appdataDir%" || exit /b 311
exit /b 0
