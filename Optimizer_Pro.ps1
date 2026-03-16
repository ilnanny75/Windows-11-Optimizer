Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Windows 11 Optimizer Pro"
$Form.Size = New-Object System.Drawing.Size(600,450)
$Form.StartPosition = "CenterScreen"
$Form.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#1f1f1f")
$Form.ForeColor = [System.Drawing.Color]::White
$Form.FormBorderStyle = "FixedDialog"
$Form.MaximizeBox = $false

$Title = New-Object System.Windows.Forms.Label
$Title.Text = "System Optimization Console"
$Title.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$Title.Size = New-Object System.Drawing.Size(580,40)
$Title.TextAlign = "MiddleCenter"
$Title.Location = New-Object System.Drawing.Point(10,20)
$Form.Controls.Add($Title)

# Esempio di Bottone "Dark"
$BtnOptimize = New-Object System.Windows.Forms.Button
$BtnOptimize.Text = "AVVIA OTTIMIZZAZIONE"
$BtnOptimize.Size = New-Object System.Drawing.Size(250,50)
$BtnOptimize.Location = New-Object System.Drawing.Point(175,150)
$BtnOptimize.FlatStyle = "Flat"
$BtnOptimize.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#333333")
$BtnOptimize.FlatAppearance.BorderSize = 1
$BtnOptimize.Cursor = [System.Windows.Forms.Cursors]::Hand
$BtnOptimize.Add_Click({
    # Qui inseriremo le tue funzioni originali di ottimizzazione
    [System.Windows.Forms.MessageBox]::Show("Ottimizzazione completata!")
})
$Form.Controls.Add($BtnOptimize)

$Form.ShowDialog()
