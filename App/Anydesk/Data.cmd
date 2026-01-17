@echo off

REM Main
::if symnlink already exists, do nothing
dir /s /a "%appdata%" | find /i "Anydesk" | find /i "<JUNCTION>" && exit /b 0
::if symlink or dir does not exist, then proceed
call :MoveData
call :CreateSymlink
goto :eof

REM Functions

REM 1
:MoveData
::if dir exists (even if it is empty), then proceed. if dir does not exist, do nothing
dir /s /a "%appdata%" | find /i "Anydesk" || exit /b 0
::if dir is not empty, move data
dir /b /s /a "%appdata%\Anydesk" | findstr . && ( move /Y "%appdataDir%\*" "%dataDir%" || exit /b 211 )
rd /S /Q "%appdataDir%" || exit /b 212
exit /b 0

REM 2
:CreateSymlink
MKlink /j "%appdataDir%" "%dataDir%" || exit /b 221
exit /b 0
