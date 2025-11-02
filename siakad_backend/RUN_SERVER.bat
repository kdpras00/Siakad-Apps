@echo off
REM Script untuk menjalankan backend Go server

echo ========================================
echo Starting SIAKAD Backend Server
echo ========================================
echo.

REM Check Go installation
go version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Go is not installed or not in PATH!
    pause
    exit /b 1
)

echo Go detected: OK
echo.

REM Install dependencies if needed
echo Installing/updating dependencies...
go mod tidy

echo.
echo ========================================
echo Starting server on port 8080...
echo ========================================
echo.
echo API will be available at:
echo   http://localhost:8080/api
echo.
echo Press Ctrl+C to stop the server
echo ========================================
echo.

REM Run server
go run main.go

