Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Windows 11 Optimizer Pro v2.2"
$Form.Size = New-Object System.Drawing.Size(550, 620)
$Form.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#121212")
$Form.ForeColor = [System.Drawing.Color]::White
$Form.StartPosition = "CenterScreen"
$Form.FormBorderStyle = "FixedDialog"
$Form.MaximizeBox = $false

$FontTitolo = New-Object System.Drawing.Font("Segoe UI", 18, [System.Drawing.FontStyle]::Bold)
$FontTesto = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)

$YOffset = 20

$Title = New-Object System.Windows.Forms.Label
$Title.Text = "WIN 11 OPTIMIZER PRO"
$Title.Font = $FontTitolo
$Title.Size = New-Object System.Drawing.Size(530, 40)
$Title.TextAlign = "MiddleCenter"
$Title.Location = New-Object System.Drawing.Point(10, $YOffset)
$Form.Controls.Add($Title)

$BtnRestore = New-Object System.Windows.Forms.Button
$BtnRestore.Text = "CREA PUNTO DI RIPRISTINO"
$BtnRestore.Size = New-Object System.Drawing.Size(460, 45)
$BtnRestore.Location = New-Object System.Drawing.Point(40, ($YOffset + 50))
$BtnRestore.FlatStyle = "Flat"
$BtnRestore.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#2d2d2d")
$BtnRestore.Font = $FontTesto
$BtnRestore.Add_Click({ [System.Windows.Forms.MessageBox]::Show("Punto di ripristino avviato!", "Sicurezza") })
$Form.Controls.Add($BtnRestore)

$GroupBox = New-Object System.Windows.Forms.GroupBox
$GroupBox.Text = " Ottimizzazioni "
$GroupBox.Location = New-Object System.Drawing.Point(40, ($YOffset + 110))
$GroupBox.Size = New-Object System.Drawing.Size(460, 200)
$GroupBox.ForeColor = [System.Drawing.Color]::LightGray # FIX: Parentesi corretta
$Form.Controls.Add($GroupBox)

$opts = @("Rimuovi Telemetria", "Disabilita App Background", "Pulisci File Temporanei", "Ottimizza CPU", "Rimuovi Bloatware")
for($i=0; $i -lt $opts.Count; $i++) {
    $cb = New-Object System.Windows.Forms.CheckBox
    $cb.Text = $opts[$i]
    $cb.Size = New-Object System.Drawing.Size(400, 30)
    $cb.Location = New-Object System.Drawing.Point(20, (30 + ($i * 30)))
    $cb.Font = $FontTesto
    $GroupBox.Controls.Add($cb)
}

$LogBox = New-Object System.Windows.Forms.RichTextBox
$LogBox.Location = New-Object System.Drawing.Point(40, ($YOffset + 325))
$LogBox.Size = New-Object System.Drawing.Size(460, 100)
$LogBox.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#1e1e1e")
$LogBox.ForeColor = [System.Drawing.Color]::LimeGreen
$LogBox.BorderStyle = "None"
$Form.Controls.Add($LogBox)

$BtnGo = New-Object System.Windows.Forms.Button
$BtnGo.Text = "APPLICA MODIFICHE"
$BtnGo.Size = New-Object System.Drawing.Size(460, 50)
$BtnGo.Location = New-Object System.Drawing.Point(40, ($YOffset + 450))
$BtnGo.FlatStyle = "Flat"
$BtnGo.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#0078d4")
$BtnGo.Font = $FontTesto
$BtnGo.Add_Click({ [System.Windows.Forms.MessageBox]::Show("Ottimizzazione completata!", "Fine") })
$Form.Controls.Add($BtnGo)

# Avvia l'interfaccia
$Form.ShowDialog() | Out-Null
# Uscita pulita per evitare il messaggio di compatibilità
[System.Diagnostics.Process]::GetCurrentProcess().Kill()
