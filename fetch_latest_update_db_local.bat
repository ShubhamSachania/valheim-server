@echo off
title Valheim Sync & Play

:: ==========================================
:: SETTINGS
:: ==========================================
set "WorldName=12345ksnsad"
set "WorldFolder=%USERPROFILE%\AppData\LocalLow\IronGate\Valheim\worlds_local"
set "GameExe=..\valheim.exe" 
:: ==========================================

:: Lock the Git folder path to exactly where this .bat file is located
set "GitFolder=%~dp0"

:: Ensure the Valheim save folder exists
if not exist "%WorldFolder%" mkdir "%WorldFolder%"

:: 1. Pull latest saves from GitHub
echo [1/5] Pulling latest saves from GitHub...
git pull origin main

:: 2. Copy the SPECIFIC world from Git to Valheim's local saves
echo [2/5] Copying "%WorldName%" to Valheim...
copy /Y "%GitFolder%%WorldName%.db" "%WorldFolder%\"
copy /Y "%GitFolder%%WorldName%.fwl" "%WorldFolder%\"

echo Done! Everything is synced.
