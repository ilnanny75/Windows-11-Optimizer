@echo off
:: Windows 11 Optimizer - Launcher
:: Avvia l'applicazione PowerShell con privilegi di amministratore

title Windows 11 Optimizer - Launcher

echo.
echo =====================================================
echo    Windows 11 Optimizer - Avvio
echo =====================================================
echo.
echo Richiesta privilegi di amministratore...
echo.

:: Avvia PowerShell con tutti i parametri corretti
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell.exe -ArgumentList '-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File \"%~dp0Windows11_Optimizer.ps1\"' -Verb RunAs}"

exit
