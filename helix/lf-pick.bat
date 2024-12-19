@echo off
setlocal EnableDelayedExpansion

:: Create a temporary directory
set "TEMP_DIR=%TEMP%/lf_temp_%RANDOM%"
mkdir "%TEMP_DIR%"

:: Check if directory was created successfully
if not exist "%TEMP_DIR%" (
    echo Error: Could not create temporary directory
    exit /b 1
)

:: Create a temporary file inside the temporary directory
set "TEMP_FILE=%TEMP_DIR%\lf_selection.txt"
type nul > "%TEMP_FILE%"

:: Check if file was created successfully
if not exist "%TEMP_FILE%" (
    echo Error: Could not create temporary file
    rmdir /s /q "%TEMP_DIR%"
    exit /b 1
)


:: Run lf with selection path
lf -selection-path="%TEMP_FILE%"

:: Check if the temporary file exists and has content
if not exist "%TEMP_FILE%" (
    echo Error: Temporary file was lost during execution
    rmdir /s /q "%TEMP_DIR%"
    exit /b 1
)

:: Display contents of temp file, using forward slashes for Helix compatibility
for /f "delims=" %%i in (%TEMP_FILE%) do (
    set "line=%%i"
    set "line=!line:\=/!"
    echo !line!
)

:: Clean up temporary file and directory
rmdir /s /q "%TEMP_DIR%"

goto :eof
