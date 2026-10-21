@echo off
setlocal
cd /d "%~dp0"
title ReviewIQ AI - 1-Click Push to GitHub

echo ======================================================================
echo          ReviewIQ AI -- 1-Click Push Complete Project to GitHub
echo ======================================================================
echo.
echo This will push the COMPLETE full-stack application to your GitHub repository:
echo   - Complete React 19 Frontend (all 15 pages + Glassmorphism UI)
echo   - Complete FastAPI Backend + ABSA Natural Language Processing Pipeline
echo   - 205 Real Smartphones & Gadgets with Images, Amazon & Flipkart links
echo   - Pre-seeded SQLite database with 10,653 analyzed customer reviews
echo   - Pytest test suite (21 passing tests) & Docker deployment configs
echo.
echo (Node_modules and temporary cache are automatically excluded!)
echo ======================================================================
echo.

set "GIT_EXE=%~dp0tools\git\cmd\git.exe"
if not exist "%GIT_EXE%" (
    where git >nul 2>nul
    if %ERRORLEVEL% equ 0 (
        set "GIT_EXE=git"
    ) else (
        echo [ERROR] Git could not be found.
        pause
        exit /b 1
    )
)

echo [1/3] Checking Git repository status...
"%GIT_EXE%" branch -M main

echo.
echo [2/3] Connect your GitHub Repository
echo ----------------------------------------------------------------------
echo Go to https://github.com/new and create a new repository (e.g. reviewiq-ai).
echo Copy its URL (e.g. https://github.com/your-username/reviewiq-ai.git)
echo.
set /p REPO_URL="Paste your GitHub Repository URL here and press Enter: "

if "%REPO_URL%"=="" (
    echo [ERROR] No repository URL was provided.
    echo Please run this file again and paste your GitHub repository link.
    pause
    exit /b 1
)

echo.
echo [3/3] Pushing complete project to %REPO_URL%...
"%GIT_EXE%" remote remove origin >nul 2>nul
"%GIT_EXE%" remote add origin %REPO_URL%

"%GIT_EXE%" push -u origin main

if %ERRORLEVEL% equ 0 (
    echo.
    echo ======================================================================
    echo   [SUCCESS] Your complete ReviewIQ AI project is now live on GitHub!
    echo ======================================================================
) else (
    echo.
    echo [NOTE] If GitHub asked for authentication, sign in with your GitHub account
    echo or use a GitHub Personal Access Token (PAT).
)

echo.
pause
