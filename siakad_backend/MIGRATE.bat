@echo off
REM Simple batch file untuk run migration dengan Go

echo ========================================
echo Database Migration - SIAKAD
echo ========================================
echo.

REM Check if we're in the right directory
if not exist "database\migration.sql" (
    echo ERROR: migration.sql tidak ditemukan!
    echo Pastikan Anda menjalankan script ini dari folder siakad_backend
    pause
    exit /b 1
)

echo Checking Go installation...
go version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Go is not installed or not in PATH!
    pause
    exit /b 1
)

echo Go detected: OK
echo.

echo Installing dependencies if needed...
go mod tidy

echo.
echo Running migration...
go run database/migrate.go

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo Migration BERHASIL!
    echo ========================================
) else (
    echo.
    echo ========================================
    echo Migration GAGAL!
    echo ========================================
)

echo.
pause

