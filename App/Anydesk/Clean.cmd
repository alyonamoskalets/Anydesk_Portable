@echo off
REM Main
call :RemoveSymlink
goto :eof

REM Functions
REM 1
:RemoveSymlink
if not exist "%appdataDir%" ( exit /b 0 )
rd /Q /S "%appdataDir%" || exit /b 311
call :restore || exit /b 321
exit /b 0

REM 2
:restore
if not exist "%appdataDir%.bk" ( exit /b 0 )
ren "%appdataDir%.bk" "AnyDesk"
exit /b %errorlevel%
