# Test Script - Verifica Funzionamento
# Esegui questo per verificare se ci sono problemi

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  TEST WINDOWS 11 OPTIMIZER" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Test 1: Verifica PowerShell Version
Write-Host "[TEST 1] Versione PowerShell..." -ForegroundColor Yellow
Write-Host "Versione: $($PSVersionTable.PSVersion)" -ForegroundColor Green
Write-Host ""

# Test 2: Verifica Privilegi Admin
Write-Host "[TEST 2] Privilegi Amministratore..." -ForegroundColor Yellow
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if ($isAdmin) {
    Write-Host "OK - Eseguito come amministratore" -ForegroundColor Green
} else {
    Write-Host "ERRORE - Non sei amministratore!" -ForegroundColor Red
    Write-Host "Fai click destro e 'Esegui come amministratore'" -ForegroundColor Yellow
}
Write-Host ""

# Test 3: Verifica Assembly
Write-Host "[TEST 3] Caricamento Assembly Windows.Forms..." -ForegroundColor Yellow
try {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
    Write-Host "OK - Assembly caricati correttamente" -ForegroundColor Green
} catch {
    Write-Host "ERRORE - Impossibile caricare assembly" -ForegroundColor Red
    Write-Host "Errore: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

# Test 4: Test Finestra
Write-Host "[TEST 4] Test Finestra di Dialogo..." -ForegroundColor Yellow
try {
    $result = [System.Windows.Forms.MessageBox]::Show(
        "Se vedi questo messaggio, l'applicazione può funzionare!`n`nClicca OK per continuare.",
        "Test Riuscito",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Information
    )
    Write-Host "OK - Finestra di dialogo funziona" -ForegroundColor Green
} catch {
    Write-Host "ERRORE - Problema con le finestre" -ForegroundColor Red
    Write-Host "Errore: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  TEST COMPLETATO" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

if ($isAdmin) {
    Write-Host "Tutto OK! Puoi usare l'applicazione." -ForegroundColor Green
    Write-Host ""
    Write-Host "Premi INVIO per avviare Windows 11 Optimizer..." -ForegroundColor Yellow
    Read-Host
    
    # Avvia l'applicazione principale
    $scriptPath = Join-Path $PSScriptRoot "Windows11_Optimizer.ps1"
    if (Test-Path $scriptPath) {
        & $scriptPath
    } else {
        Write-Host "ERRORE - File Windows11_Optimizer.ps1 non trovato!" -ForegroundColor Red
        Write-Host "Assicurati che sia nella stessa cartella di questo script." -ForegroundColor Yellow
        Read-Host "Premi INVIO per chiudere"
    }
} else {
    Write-Host "RIAVVIA COME AMMINISTRATORE!" -ForegroundColor Red
    Read-Host "Premi INVIO per chiudere"
}
