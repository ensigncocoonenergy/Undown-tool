# Undown Tool - Main Setup Script
# This script performs the setup for the Undown Tool.
# It checks for and installs PowerShell modules as needed.

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "       Undown Tool - Setup Script" -ForegroundColor Yellow
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Install NuGet provider if not present (required for PSGallery modules)
Write-Host "[1/4] Checking NuGet provider..." -ForegroundColor Gray
if ($null -eq (Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue)) {
    Write-Host "       NuGet not found. Installing..." -ForegroundColor Yellow
    Install-PackageProvider -Name NuGet -Force -Scope CurrentUser | Out-Null
}

# Step 2: Set PSGallery as trusted to avoid prompts
Write-Host "[2/4] Configuring PowerShell Gallery..." -ForegroundColor Gray
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted

# Step 3: Install required modules
Write-Host "[3/4] Installing required PowerShell modules..." -ForegroundColor Gray
$requiredModules = @("Microsoft.Win32.Registry", "Microsoft.PowerShell.Management")
foreach ($module in $requiredModules) {
    if ($null -eq (Get-Module -ListAvailable -Name $module)) {
        Write-Host "       Installing module: $module" -ForegroundColor Yellow
        Install-Module -Name $module -Force -Scope CurrentUser
    } else {
        Write-Host "       Module $module is already present." -ForegroundColor Green
    }
}

# Step 4: Finalize setup
Write-Host "[4/4] Finalizing setup..." -ForegroundColor Gray
# Creating a flag file to indicate successful installation
$installDir = Join-Path -Path $env:LOCALAPPDATA -ChildPath "UndownTool"
New-Item -ItemType Directory -Path $installDir -Force | Out-Null
Set-Content -Path (Join-Path -Path $installDir -ChildPath "installed.flag") -Value (Get-Date)

Write-Host ""
Write-Host "================================================" -ForegroundColor Green
Write-Host "  Setup completed successfully!" -ForegroundColor Green
Write-Host "  You can now use the Undown Tool." -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green

# Self-delete the script
# Remove-Item $MyInvocation.MyCommand.Path -Force