@echo off
if not exist Config.xml ( goto :Error )
for /f "delims=" %%a in ('powershell -command "Select-Xml -Path '.\Config.xml' -XPath '/Paths/App' | ForEach-Object { $_.Node.InnerXml }"') do set appDir=%%a
for /f "delims=" %%d in ('powershell -command "Select-Xml -Path '.\Config.xml' -XPath '/Paths/Data' | ForEach-Object { $_.Node.InnerXml }"') do set dataDir=%%d
set appdataDir="%appdata%\AnyDesk"
if "%appDir%"=="" goto :Error
if "%appDir%"=="empty" goto :Error
if "%dataDir%"=="" goto :Error
if "%dataDir%"=="empty" goto :Error

REM Main
call "Data.cmd" || goto :Error
start /w "" "Anydesk.exe"
call "Clean.cmd" || goto :Error
exit

:Error
echo "ERROR: An error occured!"
if %errorlevel% equ 221 echo "ERROR: Cannot copy data from %appdata% to %dataDir%!"
if %errorlevel% equ 222 echo "ERROR: Cannot backup existing AnyDesk directory in %appdata%!"
if %errorlevel% equ 232 echo "ERROR: Cannot create a symlink in %appdata%!"
if %errorlevel% equ 311 echo "ERROR: Cannot clean a symlink in %appdata%!"
if %errorlevel% equ 321 echo "ERROR: Cannot restore a backup in %appdata%!"
pause
exit /b 1
