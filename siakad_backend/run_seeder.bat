@echo off
echo ========================================
echo Running Database Seeder
echo ========================================
echo.

cd database
go run seeder.go

pause

