@echo off
if not exist Config.xml ( goto :Error )
for /f "delims=" %%a in ('powershell -NoProfile -ExecutionPolicy bypass -Command "Select-Xml -Path '.\Config.xml' -XPath '/Paths/App' | ForEach-Object { $_.Node.InnerXml }"') do set appDir=%%a
for /f "delims=" %%d in ('powershell -NoProfile -ExecutionPolicy bypass -Command "Select-Xml -Path '.\Config.xml' -XPath '/Paths/Data' | ForEach-Object { $_.Node.InnerXml }"') do set dataDir=%%d
set appdataDir="%appdata%\AnyDesk"
set logfile="%dataDir%\error.log"
if "%appDir%"=="" goto :Error
if "%appDir%"=="empty" goto :Error
if "%dataDir%"=="" goto :Error
if "%dataDir%"=="empty" goto :Error

REM Main (1. creates symlink in AppData dir; 2. actually starts Anydesk; 3. after Anydesk terminates, removes the created symlink for portability)
call "Data.cmd" || goto :Error
start /w "" "Anydesk.exe"
call "Clean.cmd" || goto :Error
goto :eof

:Error
echo "%date% %time% - ERROR: An error occured!" >> "%logfile%"
if %errorlevel% equ 211 echo "%date% %time% - ERROR: Cannot move data from %appdata% to %dataDir%!" >> "%logfile%"
if %errorlevel% equ 212 echo "%date% %time% - ERROR: Cannot remove old %appdataDir% directory!" >> "%logfile%"
if %errorlevel% equ 221 echo "%date% %time% - ERROR: Cannot create a symlink in %appdata%!" >> "%logfile%"
if %errorlevel% equ 311 echo "%date% %time% - ERROR: Cannot remove a symlink in %appdata%!" >> "%logfile%"
exit /b 1
