@echo off
REM Main
call :checkAppdata && ( goto :eof )
call :AppdataToData || goto :eof
call :SymlinkToAppdata || goto :eof
goto :eof

REM Functions
REM 1
:checkAppdata
if not exist "%appdataDir%" ( exit /b 1 )
dir /A %appdata% | find /i "<JUNCTION>"
exit /b %errorlevel%

REM 2
:AppdataToData
call :copy || exit /b 221
call :backup || exit /b 222
exit /b 0

REM 2.1
:copy
copy "%appdataDir%\*" "%dataDir%"
exit /b %errorlevel%

REM 2.2
:backup
ren "%appdataDir%" "AnyDesk.bk"
exit /b %errorlevel%

REM 3
:SymlinkToAppdata
MKlink /j "%appdataDir%" "%dataDir%" || exit /b 231
exit /b 0
