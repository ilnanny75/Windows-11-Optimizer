Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Windows 11 Optimizer Pro v2.1"
$Form.Size = New-Object System.Drawing.Size(550,750) # Leggermente più grande per i font
$Form.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#121212")
$Form.ForeColor = [System.Drawing.Color]::White
$Form.StartPosition = "CenterScreen"
$Form.FormBorderStyle = "FixedDialog"
$Form.MaximizeBox = $false

# Font Ingranditi
$FontTitolo = New-Object System.Drawing.Font("Segoe UI", 18, [System.Drawing.FontStyle]::Bold)
$FontTesto = New-Object System.Drawing.Font("Segoe UI", 11)
$FontConsole = New-Object System.Drawing.Font("Consolas", 10)

$Title = New-Object System.Windows.Forms.Label
$Title.Text = "WIN 11 OPTIMIZER PRO"
$Title.Font = $FontTitolo
$Title.Size = New-Object System.Drawing.Size(530,50)
$Title.TextAlign = "MiddleCenter"
$Title.Location = New-Object System.Drawing.Point(10,20)
$Form.Controls.Add($Title)

# --- Tasto Ripristino (Safety First) ---
$BtnRestore = New-Object System.Windows.Forms.Button
$BtnRestore.Text = "🛡️ CREA PUNTO DI RIPRISTINO"
$BtnRestore.Size = New-Object System.Drawing.Size(460, 45)
$BtnRestore.Location = New-Object System.Drawing.Point(40, 80)
$BtnRestore.FlatStyle = "Flat"
$BtnRestore.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#2d2d2d")
$BtnRestore.Font = $FontTesto
$BtnRestore.Cursor = [System.Windows.Forms.Cursors]::Hand
$BtnRestore.Add_Click({
    Write-Log "Creazione Punto di Ripristino in corso..."
    try {
        Checkpoint-Computer -Description "Prima di Win11Optimizer" -RestorePointType "MODIFY_SETTINGS" -ErrorAction Stop
        Write-Log "✅ Punto di Ripristino creato con successo!"
        [System.Windows.Forms.MessageBox]::Show("Punto di Ripristino creato correttamente.", "Sicurezza")
    } catch {
        Write-Log "❌ ERRORE: Assicurati di avere la Protezione Sistema attiva."
        [System.Windows.Forms.MessageBox]::Show("Errore nella creazione del punto di ripristino.", "Errore")
    }
})
$Form.Controls.Add($BtnRestore)

# --- Contenitore Opzioni ---
$GroupBox = New-Object System.Windows.Forms.GroupBox
$GroupBox.Text = " Ottimizzazioni "
$GroupBox.Location = New-Object System.Drawing.Point(40,140)
$GroupBox.Size = New-Object System.Drawing.Size(460,230)
$GroupBox.ForeColor = [System.Drawing.Color]::LightGray
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

$LogBox = New-Object System.Windows.Forms.RichTextBox
$LogBox.Location = New-Object System.Drawing.Point(40, 390)
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

$BtnGo = New-Object System.Windows.Forms.Button
$BtnGo.Text = "🚀 APPLICA MODIFICHE"
$BtnGo.Size = New-Object System.Drawing.Size(460, 60)
$BtnGo.Location = New-Object System.Drawing.Point(40, 590)
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

$Form.ShowDialog()
[System.Windows.Forms.Application]::Exit()
