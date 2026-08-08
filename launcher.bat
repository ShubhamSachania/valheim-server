@echo off
title Valheim Sync & Play

:: Set your folder paths here
set "WorldFolder=%USERPROFILE%\AppData\LocalLow\IronGate\Valheim\worlds_local"
set "GameExe=D:\Games\007\Valheim\Valheim\valheim.exe" 

:: 1. Pull latest saves from GitHub
echo [1/5] Pulling latest saves from GitHub...
git pull origin main

:: 2. Copy saves from this Git folder to Valheim's local saves
echo [2/5] Copying saves to Valheim...
copy /Y "*.db" "%WorldFolder%\"
copy /Y "*.fwl" "%WorldFolder%\"

:: 3. Start Valheim and wait for you to close it
echo [3/5] Starting Valheim... (Script will wait here until you exit the game)
start /WAIT "" "%GameExe%"

:: 4. You closed the game! Copy updated saves back to this Git folder
echo [4/5] Game closed. Copying updated saves back...
copy /Y "%WorldFolder%\*.db" ".\"
copy /Y "%WorldFolder%\*.fwl" ".\"

:: 5. Upload to GitHub
echo [5/5] Uploading to GitHub...
git add .
git commit -m "Auto-save after playing"
git push origin main

echo Done! Everything is synced.
pause