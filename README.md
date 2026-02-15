
# 🚀 Windows 11 Optimizer - Applicazione Portatile

![Versione](https://img.shields.io/badge/versione-1.0-blue)
![Licenza](https://img.shields.io/badge/licenza-GPLv3-green)
![Windows](https://img.shields.io/badge/Windows-11-0078D6?logo=windows)

> Un'applicazione portatile con interfaccia grafica per ottimizzare Windows 11 in modo semplice e sicuro.

---

## 📋 Descrizione

Windows 11 Optimizer è un'applicazione portatile che permette di ottimizzare Windows 11 con un'interfaccia grafica intuitiva.

![Screenshot Interfaccia](images/screenshot.png)

### ✨ Caratteristiche

- ✅ Interfaccia grafica minimale e intuitiva
- ✅ Richiede conferma per ogni operazione
- ✅ Log dettagliato di tutte le operazioni
- ✅ Possibilità di ripristinare ogni modifica
- ✅ Non richiede installazione (portabile)
- ✅ Richiede privilegi di amministratore

---

## 🚀 Come Usare l'Applicazione

### Metodo 1 - Avvio Rapido (Consigliato)

1. Fai doppio click su `Avvia_Optimizer.bat`
2. Conferma l'elevazione dei privilegi (UAC)
3. L'applicazione si avvierà automaticamente

### Metodo 2 - Avvio Manuale

1. Fai click destro su `Windows11_Optimizer.ps1`
2. Seleziona "Esegui con PowerShell"
3. Se richiesto, conferma l'esecuzione
4. L'applicazione richiederà automaticamente i privilegi di amministratore

---

## 🎯 Funzionalità Disponibili

### 🔧 Sezione Ottimizzazioni (Pannello Sinistro)

| Funzione | Descrizione |
|----------|-------------|
| **Crea Punto di Ripristino** | Crea un backup del sistema |
| **Disabilita Effetti Visivi** | Rimuove animazioni e trasparenze |
| **Disabilita Servizi Non Necessari** | Disattiva servizi che consumano risorse |
| **Pulisci File Temporanei** | Elimina file temp, cache e cestino |
| **Disabilita App in Background** | Impedisce alle app di girare in background |
| **Disabilita Widget e News** | Rimuove widget dalla barra delle applicazioni |
| **Piano Alte Prestazioni** | Massime prestazioni (consuma più energia) |
| **Disabilita Ibernazione** | Libera spazio su disco |
| **OTTIMIZZAZIONE COMPLETA** | Applica tutte le ottimizzazioni insieme |

### ↩️ Sezione Ripristino (Pannello Destro)

| Funzione | Descrizione |
|----------|-------------|
| **Riabilita Effetti Visivi** | Ripristina animazioni e trasparenze |
| **Riabilita Servizi** | Riattiva i servizi disabilitati |
| **Riabilita App in Background** | Permette alle app di girare in background |
| **Riabilita Widget e News** | Ripristina i widget |
| **Piano Bilanciato** | Equilibrio tra prestazioni e consumo |
| **Riabilita Ibernazione** | Riattiva l'ibernazione |
| **RIPRISTINO COMPLETO** | Annulla tutte le ottimizzazioni |

---

## ⚙️ Funzionamento

### 1. 🔔 Conferma Richiesta
Ogni operazione richiede la tua conferma esplicita prima di procedere. Puoi sempre annullare cliccando "No".

### 2. 📊 Log Operazioni
Tutte le azioni vengono registrate nel log in basso. Il log mostra:
- ⏰ Timestamp di ogni operazione
- ✅ Stato di completamento (✓ successo, ✗ errore, ⚠ warning)
- 📝 Eventuali messaggi di errore

### 3. 🔔 Notifiche
Al completamento di ogni operazione riceverai una notifica che conferma il successo o segnala eventuali errori.

---

## ⚠️ Raccomandazioni Importanti

### ✅ Prima di Iniziare

- ✅ **CREA UN PUNTO DI RIPRISTINO** usando il pulsante dedicato
- ✅ Chiudi tutte le applicazioni aperte
- ✅ Salva il tuo lavoro
- ✅ Leggi le descrizioni delle operazioni prima di confermare

### ✅ Dopo l'Ottimizzazione

- ✅ Riavvia il computer per applicare tutte le modifiche
- ✅ Verifica che tutto funzioni correttamente
- ✅ Se qualcosa non va, usa i pulsanti di **RIPRISTINO**

### ❌ Non Consigliato

- ❌ Non usare su laptop l'opzione "Alte Prestazioni" (consuma batteria)
- ❌ Non disabilitare servizi se non sei sicuro di cosa facciano
- ❌ Non applicare l'ottimizzazione completa senza sapere cosa fa

---

## 🔧 Troubleshooting

### ❓ "Impossibile eseguire script su questo sistema"

**Soluzione:** Apri PowerShell come amministratore e digita:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```
Poi riavvia l'applicazione.

### ❓ L'applicazione non si avvia

**Soluzione:** Usa il file `Avvia_Optimizer.bat` oppure:
1. Click destro su `Windows11_Optimizer.ps1`
2. Apri con → PowerShell
3. Conferma l'elevazione privilegi

### ❓ Dopo l'ottimizzazione il PC è più lento

**Soluzione:** 
1. Usa il pulsante "Riabilita Servizi"
2. In particolare riabilita "SysMain" e "Windows Search"

### ❓ La ricerca di Windows non funziona

**Soluzione:** Usa il pulsante "Riabilita Servizi" per riattivare Windows Search

### ❓ Voglio annullare tutto

**Soluzione:** Usa il pulsante "**RIPRISTINO COMPLETO**" nel pannello destro

---

## 💾 Requisiti Sistema

- Windows 11 (qualsiasi versione)
- PowerShell 5.1 o superiore (già incluso in Windows 11)
- Privilegi di amministratore
- .NET Framework (già incluso in Windows 11)

---

## 📁 File Inclusi
```
Windows11-Optimizer/
├── Windows11_Optimizer.ps1  # Applicazione principale
├── Avvia_Optimizer.bat      # Launcher rapido
├── README.md                 # Questo file
└── images/
    └── screenshot.png        # Screenshot interfaccia
```

---

## 🔒 Sicurezza e Privacy

- 🔐 L'applicazione **NON** raccoglie dati
- 💻 Tutto viene eseguito localmente sul tuo PC
- 🌐 Non richiede connessione internet
- 📡 Non invia informazioni a server esterni
- 📖 Il codice è completamente trasparente e modificabile

---

## ❓ Domande Frequenti (FAQ)

<details>
<summary><strong>È sicuro usare questa applicazione?</strong></summary>

Sì, tutte le operazioni sono reversibili e l'applicazione richiede conferma per ogni azione. Crea sempre un punto di ripristino prima di iniziare.
</details>

<details>
<summary><strong>Devo riavviare dopo ogni operazione?</strong></summary>

Non è necessario, ma è consigliato riavviare dopo aver completato tutte le ottimizzazioni desiderate per applicare le modifiche.
</details>

<details>
<summary><strong>Posso usarla su laptop?</strong></summary>

Sì, ma evita il "Piano Alte Prestazioni" che consuma più batteria. Usa invece le altre ottimizzazioni.
</details>

<details>
<summary><strong>Quanto spazio su disco libererà?</strong></summary>

Dipende dal tuo sistema, ma tipicamente:
- Pulizia file temporanei: 500MB - 5GB
- Disabilita ibernazione: 4-16GB (dimensione della RAM)
</details>

<details>
<summary><strong>Posso eseguire solo alcune ottimizzazioni?</strong></summary>

Sì! Usa i pulsanti singoli invece dell'"Ottimizzazione Completa". Ogni pulsante esegue solo l'operazione indicata.
</details>

<details>
<summary><strong>L'applicazione modifica il registro di sistema?</strong></summary>

Sì, alcune operazioni modificano chiavi di registro per disabilitare funzioni. Tutte le modifiche sono reversibili con i pulsanti di ripristino.
</details>

---

## 🎯 Consigli per l'Uso Ottimale

### 🎮 Per PC Gaming

- ✅ Disabilita effetti visivi
- ✅ Piano alte prestazioni
- ✅ Disabilita app in background
- ❌ Non disabilitare servizi Xbox se giochi su Xbox Game Pass

### 💼 Per PC Ufficio

- ✅ Pulisci file temporanei (regolarmente)
- ✅ Piano bilanciato
- ✅ Disabilita widget se non li usi
- ⚠️ Valuta se disabilitare Windows Search (rallenta la ricerca file)

### 💻 Per Laptop

- ✅ Pulisci file temporanei
- ✅ Disabilita app in background
- ✅ Piano bilanciato (NON alte prestazioni)
- ❌ Non disabilitare ibernazione (utile per risparmiare batteria)

### 🐌 Per PC Vecchi/Lenti

- ✅ Ottimizzazione completa
- ✅ Pulisci regolarmente i file temporanei
- ✅ Disabilita tutto ciò che non usi

---

## 📞 Supporto

Per problemi o domande:
- 📖 Controlla la sezione **Troubleshooting** in questo README
- 📊 Consulta il log dell'applicazione per dettagli sugli errori
- 💾 Usa il punto di ripristino in caso di problemi gravi

---

## 📝 Note Legali

Questa applicazione viene fornita "così com'è" senza garanzie di alcun tipo. L'utente si assume la piena responsabilità dell'uso dell'applicazione. Si consiglia di creare un punto di ripristino prima di procedere.

---

## 🎉 Ringraziamenti

Grazie per aver usato **Windows 11 Optimizer**! 

Questa applicazione è stata creata per rendere più semplice e sicura l'ottimizzazione di Windows 11.

---

## 👤 Autore

**ilnanny** - 2026

---

## 📄 Licenza

Questo progetto è distribuito sotto licenza MIT - vedi il file [LICENSE](LICENSE) per maggiori dettagli.

---

<div align="center">

**⭐ Se ti è stato utile, lascia una stella! ⭐**

Made with ❤️ by ilnanny

</div>