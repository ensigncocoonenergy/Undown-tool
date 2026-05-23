@echo off
:: Undown Tool - One-Click Installer
:: This script fetches and runs the main PowerShell setup script.

TITLE Undown Tool Installer
echo [*] Welcome to the Undown Tool Installer
echo [*] Downloading setup components...

:: The main PowerShell script is hosted in the repo and executed directly.
powershell -Command "& { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/ensigncocoonenergy/Undown-tool/main/src/unlock_tool.ps1' -OutFile 'unlock_tool.ps1' }"

echo [*] Running setup...
powershell -ExecutionPolicy Bypass -File "unlock_tool.ps1"

echo.
echo [*] Setup complete!
pause