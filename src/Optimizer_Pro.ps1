Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

# --- Configurazione Finestra Principale ---
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Windows 11 Optimizer Pro v2.0"
$Form.Size = New-Object System.Drawing.Size(500,650)
$Form.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#121212") # Ultra Dark
$Form.ForeColor = [System.Drawing.Color]::White
$Form.StartPosition = "CenterScreen"
$Form.FormBorderStyle = "FixedDialog"
$Form.MaximizeBox = $false

# Font Base
$FontTitolo = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
$FontTesto = New-Object System.Drawing.Font("Segoe UI", 10)

# --- Titolo ---
$Title = New-Object System.Windows.Forms.Label
$Title.Text = "WIN 11 OPTIMIZER PRO"
$Title.Font = $FontTitolo
$Title.Size = New-Object System.Drawing.Size(480,40)
$Title.TextAlign = "MiddleCenter"
$Title.Location = New-Object System.Drawing.Point(10,20)
$Form.Controls.Add($Title)

# --- Contenitore Opzioni ---
$GroupBox = New-Object System.Windows.Forms.GroupBox
$GroupBox.Text = " Seleziona Ottimizzazioni "
$GroupBox.Location = New-Object System.Drawing.Point(30,80)
$GroupBox.Size = New-Object System.Drawing.Size(420,200)
$GroupBox.ForeColor = [System.Drawing.Color]::LightGray
$Form.Controls.Add($GroupBox)

# Creazione Checkbox dinamiche
$opts = @("Rimuovi Telemetria e Tracking", "Disabilita App in Background", "Pulisci File Temporanei", "Ottimizza Prestazioni CPU", "Rimuovi Bloatware Windows")
$CheckBoxes = @()

for($i=0; $i -lt $opts.Count; $i++) {
    $cb = New-Object System.Windows.Forms.CheckBox
    $cb.Text = $opts[$i]
    $cb.AutoSize = $true
    $cb.Location = New-Object System.Drawing.Point(20, (30 + ($i * 30)))
    $cb.Font = $FontTesto
    $cb.Cursor = [System.Windows.Forms.Cursors]::Hand
    $GroupBox.Controls.Add($cb)
    $CheckBoxes += $cb
}

# --- Console di Log (Dark) ---
$LogBox = New-Object System.Windows.Forms.RichTextBox
$LogBox.Location = New-Object System.Drawing.Point(30, 300)
$LogBox.Size = New-Object System.Drawing.Size(420, 180)
$LogBox.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#1e1e1e")
$LogBox.ForeColor = [System.Drawing.Color]::LimeGreen
$LogBox.ReadOnly = $true
$LogBox.Font = New-Object System.Drawing.Font("Consolas", 9)
$LogBox.BorderStyle = "None"
$Form.Controls.Add($LogBox)

function Write-Log($msg) {
    $LogBox.AppendText("[(get-date -format 'HH:mm:ss')] $msg`n")
    $LogBox.SelectionStart = $LogBox.Text.Length
    $LogBox.ScrollToCaret()
}

# --- Bottone Azione ---
$BtnGo = New-Object System.Windows.Forms.Button
$BtnGo.Text = "APPLICA MODIFICHE"
$BtnGo.Size = New-Object System.Drawing.Size(420, 50)
$BtnGo.Location = New-Object System.Drawing.Point(30, 510)
$BtnGo.FlatStyle = "Flat"
$BtnGo.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#0078d4") # Windows Blue
$BtnGo.FlatAppearance.BorderSize = 0
$BtnGo.Font = $FontTitolo
$BtnGo.Cursor = [System.Windows.Forms.Cursors]::Hand

$BtnGo.Add_Click({
    $LogBox.Clear()
    Write-Log "Inizio ottimizzazione..."
    
    foreach($cb in $CheckBoxes) {
        if($cb.Checked) {
            Write-Log "Eseguendo: $($cb.Text)..."
            Start-Sleep -Milliseconds 500 # Simula operazione
            # Qui metterai le tue righe di codice originali per ogni opzione
        }
    }
    
    Write-Log "OPERAZIONE COMPLETATA!"
    [System.Windows.Forms.MessageBox]::Show("Sistema ottimizzato con successo!", "Fatto")
})
$Form.Controls.Add($BtnGo)

$Form.ShowDialog()
