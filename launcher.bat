@echo off
title Valheim Sync & Play

:: ==========================================
:: SETTINGS
:: ==========================================
set "WorldName=YOUR_WORLD_NAME"
set "WorldFolder=%USERPROFILE%\AppData\LocalLow\IronGate\Valheim\worlds_local"
set "GameExe=D:\Games\007\Valheim\Valheim\valheim.exe" 
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

:: 3. Start Valheim and wait for you to close it
echo [3/5] Starting Valheim... (Script will wait here until you exit the game)
start /WAIT "" "%GameExe%"

:: 4. You closed the game! Copy updated world back to this Git folder
echo [4/5] Game closed. Copying "%WorldName%" back...
copy /Y "%WorldFolder%\%WorldName%.db" "%GitFolder%"
copy /Y "%WorldFolder%\%WorldName%.fwl" "%GitFolder%"

:: 5. Upload to GitHub
echo [5/5] Uploading to GitHub...
cd /d "%GitFolder%"
git add .
git commit -m "Auto-save world: %WorldName%"
git push origin main

echo Done! Everything is synced.