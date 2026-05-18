@echo off
setlocal

set "SCRIPT=%~dp0Uninstall-Biobot-UroSoftware.ps1"

if not exist "%SCRIPT%" (
    echo Cannot find "%SCRIPT%".
    echo Please keep Run-Uninstall-Biobot-UroSoftware.cmd and Uninstall-Biobot-UroSoftware.ps1 in the same folder.
    exit /b 1
)

REM Check Administrator rights.
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting Administrator permission...
    powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath 'cmd.exe' -ArgumentList '/c ""%~f0"" %*' -Verb RunAs"
    exit /b 0
)

echo Running Biobot Uro software uninstall utility...
powershell.exe -ExecutionPolicy Bypass -NoProfile -File "%SCRIPT%" %*
set "RC=%ERRORLEVEL%"

echo.
echo Finished with exit code %RC%.
echo Log file: C:\ProgramData\BiobotUroSoftware\Uninstall-Biobot-UroSoftware.log

exit /b %RC%
