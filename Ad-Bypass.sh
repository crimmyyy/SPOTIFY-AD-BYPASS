@echo off
SET HOSTSFILE=C:\Windows\System32\drivers\etc\hosts
SET HEADER=:: Spotify Ad-ByPass Start
SET FOOTER=:: Spotify Ad-ByPass End

:: Check if script is running as Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrator privileges.
    pause
    exit
)

:: Find if ad-block entries already exist and remove them
findstr /c:"%HEADER%" "%HOSTSFILE%"
if %errorlevel% == 0 (
    echo Removing existing entries...
    findstr /v /c:"%HEADER%" /c:"%FOOTER%" /c:"0.0.0.0" "%HOSTSFILE%" > hosts.tmp
    find /v /c:"%FOOTER%" hosts.tmp > "%HOSTSFILE%"
    del hosts.tmp
)

:: Adding new entries
echo %HEADER% >> %HOSTSFILE%
for /F "tokens=*" %%A in (Blacklists.txt) do (
    echo %%A >> %HOSTSFILE%
)
echo %FOOTER% >> %HOSTSFILE%

echo Done. Spotify ads should be blocked.
pause
exit
