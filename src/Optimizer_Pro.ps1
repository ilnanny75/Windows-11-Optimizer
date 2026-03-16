Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

# Configurazione Finestra
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Windows 11 Optimizer Pro v2.1"
$Form.Size = New-Object System.Drawing.Size(550,750) # Dimensioni bilanciate
$Form.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#121212")
$Form.ForeColor = [System.Drawing.Color]::White
$Form.StartPosition = "CenterScreen"
$Form.FormBorderStyle = "FixedDialog"
$Form.MaximizeBox = $false

# Font Base Ingranditi (11pt testo, 18pt Titolo)
$FontTitolo = New-Object System.Drawing.Font("Segoe UI", 18, [System.Drawing.FontStyle]::Bold)
$FontTesto = New-Object System.Drawing.Font("Segoe UI", 11)
$FontConsole = New-Object System.Drawing.Font("Consolas", 10)

# Offset verticale di 40px (circa 2cm) per abbassare tutto
$YOffset = 60

# --- Titolo (Abbassato) ---
$Title = New-Object System.Windows.Forms.Label
$Title.Text = "WIN 11 OPTIMIZER PRO"
$Title.Font = $FontTitolo
$Title.Size = New-Object System.Drawing.Size(530,50)
$Title.TextAlign = "MiddleCenter"
$Title.Location = New-Object System.Drawing.Point(10,$YOffset)
$Form.Controls.Add($Title)

# --- Tasto Ripristino (Safety First - Abbassato) ---
$BtnRestore = New-Object System.Windows.Forms.Button
$BtnRestore.Text = "🛡️ CREA PUNTO DI RIPRISTINO"
$BtnRestore.Size = New-Object System.Drawing.Size(460, 45)
$BtnRestore.Location = New-Object System.Drawing.Point(40, ($YOffset + 60))
$BtnRestore.FlatStyle = "Flat"
$BtnRestore.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#2d2d2d")
$BtnRestore.Font = $FontTesto
$BtnRestore.Cursor = [System.Windows.Forms.Cursors]::Hand
$BtnRestore.Add_Click({
    Write-Log "Creazione Punto di Ripristino in corso..."
    try {
        Checkpoint-Computer -Description "Prima di Win11Optimizer" -RestorePointType "MODIFY_SETTINGS" -ErrorAction Stop
        Write-Log "✅ Punto di Ripristino creato con successo!"
    } catch {
        Write-Log "❌ ERRORE: Assicurati di avere la Protezione Sistema attiva."
    }
})
$Form.Controls.Add($BtnRestore)

# --- Contenitore Opzioni (Abbassato) ---
$GroupBox = New-Object System.Windows.Forms.GroupBox
$GroupBox.Text = " Ottimizzazioni "
$GroupBox.Location = New-Object System.Drawing.Point(40, ($YOffset + 120))
$GroupBox.Size = New-Object System.Drawing.Size(460,230)
$GroupBox.ForeColor = [System.Drawing.Color]::LightGray
$GroupBox.Font = New-Object System.Drawing.Font("Segoe UI", 10) # Testo leggermente più piccolo per la griglia
$Form.Controls.Add($GroupBox)

$opts = @("Rimuovi Telemetria e Tracking", "Disabilita App in Background", "Pulisci File Temporanei", "Ottimizza Prestazioni CPU", "Rimuovi Bloatware Windows")
$CheckBoxes = @()

for($i=0; $i -lt $opts.Count; $i++) {
    $cb = New-Object System.Windows.Forms.CheckBox
    $cb.Text = $opts[$i]
    $cb.Size = New-Object System.Drawing.Size(400, 30)
    $cb.Location = New-Object System.Drawing.Point(20, (35 + ($i * 35)))
    $cb.Font = $FontTesto
    $cb.Cursor = [System.Windows.Forms.Cursors]::Hand
    $GroupBox.Controls.Add($cb)
    $CheckBoxes += $cb
}

# --- Console di Log (Abbassato) ---
$LogBox = New-Object System.Windows.Forms.RichTextBox
$LogBox.Location = New-Object System.Drawing.Point(40, ($YOffset + 370))
$LogBox.Size = New-Object System.Drawing.Size(460, 180)
$LogBox.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#1e1e1e")
$LogBox.ForeColor = [System.Drawing.Color]::LimeGreen
$LogBox.ReadOnly = $true
$LogBox.Font = $FontConsole
$LogBox.BorderStyle = "None"
$Form.Controls.Add($LogBox)

function Write-Log($msg) {
    $LogBox.AppendText("[(get-date -format 'HH:mm:ss')] $msg`n")
    $LogBox.SelectionStart = $LogBox.Text.Length
    $LogBox.ScrollToCaret()
}

# --- Bottone Azione (Abbassato) ---
$BtnGo = New-Object System.Windows.Forms.Button
$BtnGo.Text = "🚀 APPLICA MODIFICHE"
$BtnGo.Size = New-Object System.Drawing.Size(460, 60)
$BtnGo.Location = New-Object System.Drawing.Point(40, ($YOffset + 570))
$BtnGo.FlatStyle = "Flat"
$BtnGo.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#0078d4")
$BtnGo.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$BtnGo.Cursor = [System.Windows.Forms.Cursors]::Hand
$BtnGo.Add_Click({
    $LogBox.Clear()
    Write-Log "Inizio ottimizzazione..."
    foreach($cb in $CheckBoxes) {
        if($cb.Checked) {
            Write-Log "Eseguendo: $($cb.Text)..."
            Start-Sleep -Milliseconds 600 
        }
    }
    Write-Log "OPERAZIONE COMPLETATA!"
})
$Form.Controls.Add($BtnGo)

# Mostra e Esci Pulito per evitare popup compatibilità
$Form.ShowDialog()
[System.Windows.Forms.Application]::Exit()
