@echo off
REM MAIN
set "local_root_folder=W:\dows\root\path"
set "windows_host=hostname/ip"

if "%~1" equ "" (
    echo "Missing remote path"
    exit /b 1
)


REM Read first parameter as remote_path_string
set "remote_path_string=%1"
REM Converts slash to backslash
set "windows_remote_path=%remote_path_string:/=\%"
REM Complete remote_path with specified root path (example C:\root)
set "windows_local_path=%local_root_folder%%windows_remote_path%"

REM Execute the copy
echo "robocopy \\%windows_host%%windows_remote_path% %windows_local_path%"

echo "Copy completed"

REM Converts backslash to slash
set "linux_path=%remote_path_string:\=/%"

REM Suggestion execution
echo "Execute this command:"
echo .\publishFile.bat %windows_local_path% %linux_path%

exit /b 0
