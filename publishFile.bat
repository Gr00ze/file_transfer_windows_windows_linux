@echo off
setlocal enabledelayedexpansion

set "linux_root_path=/linux/root/path"
set "user=user"
set "linux_host=linux_host"

if "%~1" equ "" (
    echo "Missing windows path as parameter 1 and linux path as parameter 2"
    exit /b 1
)
if "%~2" equ "" (
    echo "Missing linux path as parameter 2"
    exit /b 1
)




REM Read given parameters
set "windows_path=%1"
set "linux_path=%2"

REM remove first parent directory
for /f "tokens=1,* delims=/" %%a in ("%linux_path%") do set "linux_path_without_parent=%%b"


REM Add root path
set "linux_path=%linux_root_path%/%linux_path_without_parent%"

REM Get last subdirectory
set "last_subdirectory="
for %%i in (%linux_path:/= %) do set "last_subdirectory=%%~nxi"


REM Remove last subdirectory
set "linux_path=!linux_path:%last_subdirectory%=!"

REM Ask password with PowerSshell
set "password="
for /f %%i in ('powershell -command "$pword = read-host 'Insert password' -AsSecureString ; [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword))"') do set "password=%%i"

REM Copy windows folder or file in linuxfolder
echo pscp.exe -r -ssh -pw !password! %windows_path% %user%@%linux_host%:%linux_path%



endlocal
exit /b 0
