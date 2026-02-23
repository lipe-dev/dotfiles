#Requires -RunAsAdministrator

$ErrorActionPreference = "Stop"

Set-Location "$PSScriptRoot\.."
$DOTFILES = (Get-Location).Path

Write-Host "==> chocolatey"
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

Write-Host "==> packages"
winget install Git.Git
winget install GitHub.cli
choco install autohotkey -y

Write-Host "==> gh auth"
gh auth login

Write-Host "==> symlinks"
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.glzr\glazewm" | Out-Null
New-Item -ItemType SymbolicLink -Force -Path "$env:USERPROFILE\.glzr\glazewm\config.yaml" `
  -Target "$DOTFILES\windows\.glzr\glazewm\config.yaml"

New-Item -ItemType Directory -Force -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup" | Out-Null
New-Item -ItemType SymbolicLink -Force -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\winmarchy.ahk" `
  -Target "$DOTFILES\windows\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\winmarchy.ahk"

Write-Host "==> done."
