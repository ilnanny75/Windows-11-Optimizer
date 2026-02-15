@echo off
:: Launcher Alternativo - Più Semplice

powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Start-Process PowerShell.exe -ArgumentList '-NoProfile -ExecutionPolicy Bypass -NoExit -File \"%~dp0Windows11_Optimizer.ps1\"' -Verb RunAs"
