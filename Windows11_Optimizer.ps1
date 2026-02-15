# Windows 11 Optimizer - Applicazione Portabile
# Versione: 1.0
# Richiede PowerShell 5.1+ e diritti di amministratore

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Verifica privilegi amministratore
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    [System.Windows.Forms.MessageBox]::Show(
        "Questa applicazione richiede privilegi di amministratore.`n`nClicca OK per riavviare con privilegi elevati.",
        "Privilegi Richiesti",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Warning
    )
    
    # Riavvia come amministratore
    Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Funzione per mostrare messaggi con conferma
function Show-Confirmation {
    param(
        [string]$Title,
        [string]$Message
    )
    
    $result = [System.Windows.Forms.MessageBox]::Show(
        $Message,
        $Title,
        [System.Windows.Forms.MessageBoxButtons]::YesNo,
        [System.Windows.Forms.MessageBoxIcon]::Question
    )
    
    return $result -eq [System.Windows.Forms.DialogResult]::Yes
}

# Funzione per mostrare messaggi informativi
function Show-Info {
    param(
        [string]$Title,
        [string]$Message,
        [string]$Icon = "Information"
    )
    
    $iconType = switch ($Icon) {
        "Information" { [System.Windows.Forms.MessageBoxIcon]::Information }
        "Warning" { [System.Windows.Forms.MessageBoxIcon]::Warning }
        "Error" { [System.Windows.Forms.MessageBoxIcon]::Error }
        "Success" { [System.Windows.Forms.MessageBoxIcon]::Information }
    }
    
    [System.Windows.Forms.MessageBox]::Show(
        $Message,
        $Title,
        [System.Windows.Forms.MessageBoxButtons]::OK,
        $iconType
    )
}

# Funzione per aggiornare il log
function Add-Log {
    param([string]$Message)
    $timestamp = Get-Date -Format "HH:mm:ss"
    $logBox.AppendText("[$timestamp] $Message`r`n")
    $logBox.ScrollToCaret()
    [System.Windows.Forms.Application]::DoEvents()
}

# Funzioni di ottimizzazione
function Disable-VisualEffects {
    if (Show-Confirmation "Disabilita Effetti Visivi" "Vuoi disabilitare animazioni e trasparenza per migliorare le prestazioni?") {
        Add-Log "Disabilitazione effetti visivi..."
        try {
            Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value "0" -ErrorAction Stop
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0 -ErrorAction Stop
            Add-Log "[OK] Effetti visivi disabilitati"
            Show-Info "Completato" "Effetti visivi disabilitati con successo!" "Success"
        } catch {
            Add-Log "[ERROR] Errore: $($_.Exception.Message)"
            Show-Info "Errore" "Impossibile disabilitare effetti visivi: $($_.Exception.Message)" "Error"
        }
    } else {
        Add-Log "Operazione annullata dall'utente"
    }
}

function Enable-VisualEffects {
    if (Show-Confirmation "Riabilita Effetti Visivi" "Vuoi riabilitare animazioni e trasparenza?") {
        Add-Log "Riabilitazione effetti visivi..."
        try {
            Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value "1" -ErrorAction Stop
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 1 -ErrorAction Stop
            Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
            Add-Log "[OK] Effetti visivi riabilitati"
            Show-Info "Completato" "Effetti visivi riabilitati con successo!" "Success"
        } catch {
            Add-Log "[ERROR] Errore: $($_.Exception.Message)"
            Show-Info "Errore" "Impossibile riabilitare effetti visivi: $($_.Exception.Message)" "Error"
        }
    } else {
        Add-Log "Operazione annullata dall'utente"
    }
}

function Disable-UnnecessaryServices {
    $message = "Vuoi disabilitare questi servizi?`n`n" +
               "• Windows Search (indicizzazione)`n" +
               "• SysMain (Superfetch)`n" +
               "• DiagTrack (telemetria)`n" +
               "• Servizi Xbox (se non giochi)`n`n" +
               "NOTA: Alcuni servizi potrebbero essere utili per te."
    
    if (Show-Confirmation "Disabilita Servizi" $message) {
        Add-Log "Disabilitazione servizi non necessari..."
        
        $services = @("WSearch", "SysMain", "DiagTrack", "XblAuthManager", "XblGameSave", "XboxGipSvc", "XboxNetApiSvc")
        $disabled = 0
        
        foreach ($service in $services) {
            try {
                Stop-Service $service -Force -ErrorAction Stop
                Set-Service $service -StartupType Disabled -ErrorAction Stop
                Add-Log "[OK] $service disabilitato"
                $disabled++
            } catch {
                Add-Log "[WARN] $service - ($_.Exception.Message)"
            }
        }
        
        Show-Info "Completato" "$disabled servizi disabilitati con successo!" "Success"
    } else {
        Add-Log "Operazione annullata dall'utente"
    }
}

function Enable-UnnecessaryServices {
    if (Show-Confirmation "Riabilita Servizi" "Vuoi riabilitare i servizi precedentemente disabilitati?") {
        Add-Log "Riabilitazione servizi..."
        
        try {
            Set-Service "WSearch" -StartupType Automatic -ErrorAction Stop
            Start-Service "WSearch" -ErrorAction SilentlyContinue
            Add-Log "[OK] Windows Search riabilitato"
        } catch { Add-Log "[WARN] WSearch: $($_.Exception.Message)" }
        
        try {
            Set-Service "SysMain" -StartupType Automatic -ErrorAction Stop
            Start-Service "SysMain" -ErrorAction SilentlyContinue
            Add-Log "[OK] SysMain riabilitato"
        } catch { Add-Log "[WARN] SysMain: $($_.Exception.Message)" }
        
        try {
            Set-Service "DiagTrack" -StartupType Automatic -ErrorAction Stop
            Start-Service "DiagTrack" -ErrorAction SilentlyContinue
            Add-Log "[OK] DiagTrack riabilitato"
        } catch { Add-Log "[WARN] DiagTrack: $($_.Exception.Message)" }
        
        $xboxServices = @("XblAuthManager", "XblGameSave", "XboxGipSvc", "XboxNetApiSvc")
        foreach ($service in $xboxServices) {
            try {
                Set-Service $service -StartupType Manual -ErrorAction Stop
                Add-Log "[OK] $service riabilitato"
            } catch { Add-Log "[WARN] $service - Errore" }
        }
        
        Show-Info "Completato" "Servizi riabilitati con successo!" "Success"
    } else {
        Add-Log "Operazione annullata dall'utente"
    }
}

function Clean-TempFiles {
    $message = "Vuoi pulire i file temporanei?`n`n" +
               "Verranno eliminati:`n" +
               "• File temporanei utente`n" +
               "• File temporanei di sistema`n" +
               "• Cache Windows Update`n" +
               "• Cache DNS`n" +
               "• Cestino"
    
    if (Show-Confirmation "Pulizia File" $message) {
        Add-Log "Pulizia file temporanei in corso..."
        
        try {
            Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
            Add-Log "[OK] File temp utente eliminati"
        } catch { Add-Log "[WARN] Errore pulizia temp utente" }
        
        try {
            Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
            Add-Log "[OK] File temp sistema eliminati"
        } catch { Add-Log "[WARN] Errore pulizia temp sistema" }
        
        try {
            Stop-Service wuauserv -Force -ErrorAction SilentlyContinue
            Remove-Item -Path "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
            Start-Service wuauserv -ErrorAction SilentlyContinue
            Add-Log "[OK] Cache Windows Update pulita"
        } catch { Add-Log "[WARN] Errore pulizia cache update" }
        
        try {
            Clear-RecycleBin -Force -ErrorAction SilentlyContinue
            Add-Log "[OK] Cestino svuotato"
        } catch { Add-Log "[WARN] Errore svuotamento cestino" }
        
        try {
            Clear-DnsClientCache
            Add-Log "[OK] Cache DNS pulita"
        } catch { Add-Log "[WARN] Errore pulizia DNS" }
        
        Show-Info "Completato" "Pulizia file temporanei completata!" "Success"
    } else {
        Add-Log "Operazione annullata dall'utente"
    }
}

function Disable-BackgroundApps {
    if (Show-Confirmation "Disabilita App Background" "Vuoi disabilitare le app in background per risparmiare risorse?") {
        Add-Log "Disabilitazione app in background..."
        try {
            Get-AppxPackage | ForEach-Object {
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\$($_.PackageFamilyName)" -Name "Disabled" -Value 1 -ErrorAction SilentlyContinue
            }
            Add-Log "[OK] App in background disabilitate"
            Show-Info "Completato" "App in background disabilitate con successo!" "Success"
        } catch {
            Add-Log "[ERROR] Errore: $($_.Exception.Message)"
            Show-Info "Errore" "Impossibile disabilitare app: $($_.Exception.Message)" "Error"
        }
    } else {
        Add-Log "Operazione annullata dall'utente"
    }
}

function Enable-BackgroundApps {
    if (Show-Confirmation "Riabilita App Background" "Vuoi riabilitare le app in background?") {
        Add-Log "Riabilitazione app in background..."
        try {
            Get-AppxPackage | ForEach-Object {
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\$($_.PackageFamilyName)" -Name "Disabled" -Value 0 -ErrorAction SilentlyContinue
            }
            Add-Log "[OK] App in background riabilitate"
            Show-Info "Completato" "App in background riabilitate con successo!" "Success"
        } catch {
            Add-Log "[ERROR] Errore: $($_.Exception.Message)"
            Show-Info "Errore" "Impossibile riabilitare app: $($_.Exception.Message)" "Error"
        }
    } else {
        Add-Log "Operazione annullata dall'utente"
    }
}

function Disable-Widgets {
    if (Show-Confirmation "Disabilita Widget" "Vuoi disabilitare i widget e le news dalla barra delle applicazioni?") {
        Add-Log "Disabilitazione widget e news..."
        try {
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Value 0 -ErrorAction Stop
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Value 2 -ErrorAction Stop
            Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
            Add-Log "[OK] Widget disabilitati"
            Show-Info "Completato" "Widget disabilitati con successo!" "Success"
        } catch {
            Add-Log "[ERROR] Errore: $($_.Exception.Message)"
            Show-Info "Errore" "Impossibile disabilitare widget: $($_.Exception.Message)" "Error"
        }
    } else {
        Add-Log "Operazione annullata dall'utente"
    }
}

function Enable-Widgets {
    if (Show-Confirmation "Riabilita Widget" "Vuoi riabilitare i widget e le news?") {
        Add-Log "Riabilitazione widget e news..."
        try {
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Value 1 -ErrorAction Stop
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Value 0 -ErrorAction Stop
            Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
            Add-Log "[OK] Widget riabilitati"
            Show-Info "Completato" "Widget riabilitati con successo!" "Success"
        } catch {
            Add-Log "[ERROR] Errore: $($_.Exception.Message)"
            Show-Info "Errore" "Impossibile riabilitare widget: $($_.Exception.Message)" "Error"
        }
    } else {
        Add-Log "Operazione annullata dall'utente"
    }
}

function Set-HighPerformance {
    if (Show-Confirmation "Piano Alte Prestazioni" "Vuoi impostare il piano energetico su Alte Prestazioni?`n`nNOTA: Consuma più energia, non consigliato su laptop.") {
        Add-Log "Impostazione piano Alte Prestazioni..."
        try {
            powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
            Add-Log "[OK] Piano Alte Prestazioni attivato"
            Show-Info "Completato" "Piano energetico impostato su Alte Prestazioni!" "Success"
        } catch {
            Add-Log "[ERROR] Errore: $($_.Exception.Message)"
            Show-Info "Errore" "Impossibile impostare piano energetico: $($_.Exception.Message)" "Error"
        }
    } else {
        Add-Log "Operazione annullata dall'utente"
    }
}

function Set-Balanced {
    if (Show-Confirmation "Piano Bilanciato" "Vuoi ripristinare il piano energetico Bilanciato?") {
        Add-Log "Impostazione piano Bilanciato..."
        try {
            powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e
            Add-Log "[OK] Piano Bilanciato attivato"
            Show-Info "Completato" "Piano energetico impostato su Bilanciato!" "Success"
        } catch {
            Add-Log "[ERROR] Errore: $($_.Exception.Message)"
            Show-Info "Errore" "Impossibile impostare piano energetico: $($_.Exception.Message)" "Error"
        }
    } else {
        Add-Log "Operazione annullata dall'utente"
    }
}

function Disable-Hibernation {
    if (Show-Confirmation "Disabilita Ibernazione" "Vuoi disabilitare l'ibernazione?`n`nQuesto libera spazio su disco ma non potrai ibernare il PC.") {
        Add-Log "Disabilitazione ibernazione..."
        try {
            powercfg -h off
            Add-Log "[OK] Ibernazione disabilitata"
            Show-Info "Completato" "Ibernazione disabilitata con successo!" "Success"
        } catch {
            Add-Log "[ERROR] Errore: $($_.Exception.Message)"
            Show-Info "Errore" "Impossibile disabilitare ibernazione: $($_.Exception.Message)" "Error"
        }
    } else {
        Add-Log "Operazione annullata dall'utente"
    }
}

function Enable-Hibernation {
    if (Show-Confirmation "Riabilita Ibernazione" "Vuoi riabilitare l'ibernazione?") {
        Add-Log "Riabilitazione ibernazione..."
        try {
            powercfg -h on
            Add-Log "[OK] Ibernazione riabilitata"
            Show-Info "Completato" "Ibernazione riabilitata con successo!" "Success"
        } catch {
            Add-Log "[ERROR] Errore: $($_.Exception.Message)"
            Show-Info "Errore" "Impossibile riabilitare ibernazione: $($_.Exception.Message)" "Error"
        }
    } else {
        Add-Log "Operazione annullata dall'utente"
    }
}

function Optimize-Complete {
    $message = "OTTIMIZZAZIONE COMPLETA`n`n" +
               "Verranno applicate tutte le ottimizzazioni:`n" +
               "• Disabilita effetti visivi`n" +
               "• Disabilita servizi non necessari`n" +
               "• Pulisci file temporanei`n" +
               "• Disabilita app in background`n" +
               "• Disabilita widget`n" +
               "• Piano alte prestazioni`n" +
               "• Disabilita ibernazione`n`n" +
               "PROCEDERE?"
    
    if (Show-Confirmation "Ottimizzazione Completa" $message) {
        Add-Log "=== INIZIO OTTIMIZZAZIONE COMPLETA ==="
        
        # Effetti visivi
        Add-Log "1/7 - Effetti visivi..."
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value "0" -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0 -ErrorAction SilentlyContinue
        
        # Servizi
        Add-Log "2/7 - Servizi..."
        $services = @("WSearch", "SysMain", "DiagTrack", "XblAuthManager", "XblGameSave", "XboxGipSvc", "XboxNetApiSvc")
        foreach ($service in $services) {
            Stop-Service $service -Force -ErrorAction SilentlyContinue
            Set-Service $service -StartupType Disabled -ErrorAction SilentlyContinue
        }
        
        # Pulizia
        Add-Log "3/7 - Pulizia file..."
        Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
        Clear-RecycleBin -Force -ErrorAction SilentlyContinue
        Clear-DnsClientCache -ErrorAction SilentlyContinue
        
        # App background
        Add-Log "4/7 - App in background..."
        Get-AppxPackage | ForEach-Object {
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\$($_.PackageFamilyName)" -Name "Disabled" -Value 1 -ErrorAction SilentlyContinue
        }
        
        # Widget
        Add-Log "5/7 - Widget..."
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Value 0 -ErrorAction SilentlyContinue
        
        # Piano energetico
        Add-Log "6/7 - Piano energetico..."
        powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
        
        # Ibernazione
        Add-Log "7/7 - Ibernazione..."
        powercfg -h off
        
        Add-Log "=== OTTIMIZZAZIONE COMPLETA TERMINATA ==="
        
        $restartMsg = "Ottimizzazione completata!`n`nVuoi riavviare il computer ora per applicare tutte le modifiche?"
        if (Show-Confirmation "Riavvio Sistema" $restartMsg) {
            Add-Log "Riavvio del sistema in corso..."
            Restart-Computer -Force
        } else {
            Show-Info "Completato" "Ottimizzazione completata!`n`nRicorda di riavviare il PC per applicare tutte le modifiche." "Success"
        }
    } else {
        Add-Log "Ottimizzazione completa annullata dall'utente"
    }
}

function Restore-Complete {
    $message = "RIPRISTINO COMPLETO`n`n" +
               "Verranno annullate tutte le ottimizzazioni:`n" +
               "• Riabilita effetti visivi`n" +
               "• Riabilita servizi`n" +
               "• Riabilita app in background`n" +
               "• Riabilita widget`n" +
               "• Piano bilanciato`n" +
               "• Riabilita ibernazione`n`n" +
               "PROCEDERE?"
    
    if (Show-Confirmation "Ripristino Completo" $message) {
        Add-Log "=== INIZIO RIPRISTINO COMPLETO ==="
        
        # Effetti visivi
        Add-Log "1/6 - Effetti visivi..."
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value "1" -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 1 -ErrorAction SilentlyContinue
        
        # Servizi
        Add-Log "2/6 - Servizi..."
        Set-Service "WSearch" -StartupType Automatic -ErrorAction SilentlyContinue
        Start-Service "WSearch" -ErrorAction SilentlyContinue
        Set-Service "SysMain" -StartupType Automatic -ErrorAction SilentlyContinue
        Start-Service "SysMain" -ErrorAction SilentlyContinue
        Set-Service "DiagTrack" -StartupType Automatic -ErrorAction SilentlyContinue
        Start-Service "DiagTrack" -ErrorAction SilentlyContinue
        
        $xboxServices = @("XblAuthManager", "XblGameSave", "XboxGipSvc", "XboxNetApiSvc")
        foreach ($service in $xboxServices) {
            Set-Service $service -StartupType Manual -ErrorAction SilentlyContinue
        }
        
        # App background
        Add-Log "3/6 - App in background..."
        Get-AppxPackage | ForEach-Object {
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\$($_.PackageFamilyName)" -Name "Disabled" -Value 0 -ErrorAction SilentlyContinue
        }
        
        # Widget
        Add-Log "4/6 - Widget..."
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Value 1 -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Value 0 -ErrorAction SilentlyContinue
        
        # Piano energetico
        Add-Log "5/6 - Piano energetico..."
        powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e
        
        # Ibernazione
        Add-Log "6/6 - Ibernazione..."
        powercfg -h on
        
        # Riavvia explorer
        Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
        
        Add-Log "=== RIPRISTINO COMPLETO TERMINATO ==="
        
        $restartMsg = "Ripristino completato!`n`nVuoi riavviare il computer ora per applicare tutte le modifiche?"
        if (Show-Confirmation "Riavvio Sistema" $restartMsg) {
            Add-Log "Riavvio del sistema in corso..."
            Restart-Computer -Force
        } else {
            Show-Info "Completato" "Ripristino completato!`n`nRicorda di riavviare il PC per applicare tutte le modifiche." "Success"
        }
    } else {
        Add-Log "Ripristino completo annullato dall'utente"
    }
}

function Create-RestorePoint {
    if (Show-Confirmation "Punto di Ripristino" "Vuoi creare un punto di ripristino del sistema?`n`nQuesto ti permetterà di tornare indietro in caso di problemi.") {
        Add-Log "Creazione punto di ripristino..."
        try {
            Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
            Checkpoint-Computer -Description "Windows Optimizer - $(Get-Date -Format 'yyyy-MM-dd HH:mm')" -RestorePointType "MODIFY_SETTINGS"
            Add-Log "[OK] Punto di ripristino creato"
            Show-Info "Completato" "Punto di ripristino creato con successo!" "Success"
        } catch {
            Add-Log "[ERROR] Errore: $($_.Exception.Message)"
            Show-Info "Errore" "Impossibile creare punto di ripristino: $($_.Exception.Message)" "Error"
        }
    } else {
        Add-Log "Creazione punto di ripristino annullata"
    }
}

# Creazione Form principale
$form = New-Object System.Windows.Forms.Form
$form.Text = "Windows 11 Optimizer v1.0"
$form.Size = New-Object System.Drawing.Size(900, 700)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false
$form.BackColor = [System.Drawing.Color]::FromArgb(240, 240, 245)

# Titolo
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Location = New-Object System.Drawing.Point(20, 20)
$titleLabel.Size = New-Object System.Drawing.Size(860, 40)
$titleLabel.Text = "VELOCIZZAZIONE Windows 11 Optimizer"
$titleLabel.Font = New-Object System.Drawing.Font("Segoe UI", 24, [System.Drawing.FontStyle]::Bold)
$titleLabel.ForeColor = [System.Drawing.Color]::FromArgb(103, 126, 234)
$form.Controls.Add($titleLabel)

# Sottotitolo
$subtitleLabel = New-Object System.Windows.Forms.Label
$subtitleLabel.Location = New-Object System.Drawing.Point(20, 60)
$subtitleLabel.Size = New-Object System.Drawing.Size(860, 20)
$subtitleLabel.Text = "Ottimizza Windows 11 con un click - Ogni operazione richiede conferma"
$subtitleLabel.Font = New-Object System.Drawing.Font("Segoe UI", 11)
$subtitleLabel.ForeColor = [System.Drawing.Color]::FromArgb(100, 100, 100)
$form.Controls.Add($subtitleLabel)

# Panel Ottimizzazioni
$optPanel = New-Object System.Windows.Forms.Panel
$optPanel.Location = New-Object System.Drawing.Point(20, 100)
$optPanel.Size = New-Object System.Drawing.Size(420, 380)
$optPanel.BorderStyle = "FixedSingle"
$optPanel.BackColor = [System.Drawing.Color]::White
$optPanel.AutoScroll = $true
$form.Controls.Add($optPanel)

$optTitle = New-Object System.Windows.Forms.Label
$optTitle.Location = New-Object System.Drawing.Point(10, 10)
$optTitle.Size = New-Object System.Drawing.Size(400, 25)
$optTitle.Text = " OTTIMIZZAZIONI"
$optTitle.Font = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
$optTitle.ForeColor = [System.Drawing.Color]::FromArgb(103, 126, 234)
$optPanel.Controls.Add($optTitle)

# Bottoni Ottimizzazioni
$y = 45
$buttonWidth = 390
$buttonHeight = 35
$spacing = 10

function Create-Button {
    param($Text, $Y, $Parent, $Action)
    $btn = New-Object System.Windows.Forms.Button
    $btn.Location = New-Object System.Drawing.Point(10, $Y)
    $btn.Size = New-Object System.Drawing.Size($buttonWidth, $buttonHeight)
    $btn.Text = $Text
    $btn.Font = New-Object System.Drawing.Font("Segoe UI", 11)
    $btn.BackColor = [System.Drawing.Color]::FromArgb(103, 126, 234)
    $btn.ForeColor = [System.Drawing.Color]::White
    $btn.FlatStyle = "Flat"
    $btn.FlatAppearance.BorderSize = 0
    $btn.Cursor = "Hand"
    $btn.Add_Click($Action)
    $Parent.Controls.Add($btn)
    return $btn
}

Create-Button " Crea Punto di Ripristino" $y $optPanel { Create-RestorePoint }
$y += $buttonHeight + $spacing

Create-Button " Disabilita Effetti Visivi" $y $optPanel { Disable-VisualEffects }
$y += $buttonHeight + $spacing

Create-Button " Disabilita Servizi Non Necessari" $y $optPanel { Disable-UnnecessaryServices }
$y += $buttonHeight + $spacing

Create-Button " Pulisci File Temporanei" $y $optPanel { Clean-TempFiles }
$y += $buttonHeight + $spacing

Create-Button " Disabilita App in Background" $y $optPanel { Disable-BackgroundApps }
$y += $buttonHeight + $spacing

Create-Button " Disabilita Widget e News" $y $optPanel { Disable-Widgets }
$y += $buttonHeight + $spacing

Create-Button " Piano Alte Prestazioni" $y $optPanel { Set-HighPerformance }
$y += $buttonHeight + $spacing

Create-Button " Disabilita Ibernazione" $y $optPanel { Disable-Hibernation }
$y += $buttonHeight + $spacing + 10

# Bottone Ottimizzazione Completa
$btnOptAll = New-Object System.Windows.Forms.Button
$btnOptAll.Location = New-Object System.Drawing.Point(10, $y)
$btnOptAll.Size = New-Object System.Drawing.Size($buttonWidth, 45)
$btnOptAll.Text = "VELOCIZZAZIONE OTTIMIZZAZIONE COMPLETA"
$btnOptAll.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$btnOptAll.BackColor = [System.Drawing.Color]::FromArgb(40, 167, 69)
$btnOptAll.ForeColor = [System.Drawing.Color]::White
$btnOptAll.FlatStyle = "Flat"
$btnOptAll.FlatAppearance.BorderSize = 0
$btnOptAll.Cursor = "Hand"
$btnOptAll.Add_Click({ Optimize-Complete })
$optPanel.Controls.Add($btnOptAll)

# Panel Ripristino
$restorePanel = New-Object System.Windows.Forms.Panel
$restorePanel.Location = New-Object System.Drawing.Point(460, 100)
$restorePanel.Size = New-Object System.Drawing.Size(420, 380)
$restorePanel.BorderStyle = "FixedSingle"
$restorePanel.BackColor = [System.Drawing.Color]::White
$restorePanel.AutoScroll = $true
$form.Controls.Add($restorePanel)

$restoreTitle = New-Object System.Windows.Forms.Label
$restoreTitle.Location = New-Object System.Drawing.Point(10, 10)
$restoreTitle.Size = New-Object System.Drawing.Size(400, 25)
$restoreTitle.Text = "RIPRISTINO RIPRISTINO"
$restoreTitle.Font = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
$restoreTitle.ForeColor = [System.Drawing.Color]::FromArgb(220, 53, 69)
$restorePanel.Controls.Add($restoreTitle)

# Bottoni Ripristino
$y = 45

Create-Button " Riabilita Effetti Visivi" $y $restorePanel { Enable-VisualEffects }
$y += $buttonHeight + $spacing

Create-Button " Riabilita Servizi" $y $restorePanel { Enable-UnnecessaryServices }
$y += $buttonHeight + $spacing

Create-Button " Riabilita App in Background" $y $restorePanel { Enable-BackgroundApps }
$y += $buttonHeight + $spacing

Create-Button " Riabilita Widget e News" $y $restorePanel { Enable-Widgets }
$y += $buttonHeight + $spacing

Create-Button "⚖️ Piano Bilanciato" $y $restorePanel { Set-Balanced }
$y += $buttonHeight + $spacing

Create-Button " Riabilita Ibernazione" $y $restorePanel { Enable-Hibernation }
$y += $buttonHeight + $spacing + 50

# Bottone Ripristino Completo
$btnRestoreAll = New-Object System.Windows.Forms.Button
$btnRestoreAll.Location = New-Object System.Drawing.Point(10, $y)
$btnRestoreAll.Size = New-Object System.Drawing.Size($buttonWidth, 45)
$btnRestoreAll.Text = "RIPRISTINO RIPRISTINO COMPLETO"
$btnRestoreAll.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$btnRestoreAll.BackColor = [System.Drawing.Color]::FromArgb(220, 53, 69)
$btnRestoreAll.ForeColor = [System.Drawing.Color]::White
$btnRestoreAll.FlatStyle = "Flat"
$btnRestoreAll.FlatAppearance.BorderSize = 0
$btnRestoreAll.Cursor = "Hand"
$btnRestoreAll.Add_Click({ Restore-Complete })
$restorePanel.Controls.Add($btnRestoreAll)

# Log Panel
$logLabel = New-Object System.Windows.Forms.Label
$logLabel.Location = New-Object System.Drawing.Point(20, 495)
$logLabel.Size = New-Object System.Drawing.Size(860, 20)
$logLabel.Text = " Log Operazioni"
$logLabel.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$form.Controls.Add($logLabel)

$logBox = New-Object System.Windows.Forms.RichTextBox
$logBox.Location = New-Object System.Drawing.Point(20, 520)
$logBox.Size = New-Object System.Drawing.Size(860, 120)
$logBox.Font = New-Object System.Drawing.Font("Consolas", 10)
$logBox.ReadOnly = $true
$logBox.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 30)
$logBox.ForeColor = [System.Drawing.Color]::FromArgb(200, 200, 200)
$form.Controls.Add($logBox)

# Log iniziale
Add-Log "Windows 11 Optimizer avviato con privilegi di amministratore"
Add-Log "Pronto per l'uso - Seleziona un'operazione"

# Mostra form
$form.ShowDialog()
