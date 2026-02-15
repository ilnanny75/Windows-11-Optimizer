
================================================================================
                    WINDOWS 11 OPTIMIZER - APPLICAZIONE PORTATILE
================================================================================

VERSIONE: 1.0
AUTORE: ilnanny
DATA: 2026

================================================================================
📋 DESCRIZIONE
================================================================================

Windows 11 Optimizer è un'applicazione portatile con interfaccia grafica che
permette di ottimizzare Windows 11 in modo semplice e sicuro.

CARATTERISTICHE:
✓ Interfaccia grafica minimale e intuitiva
✓ Richiede conferma per ogni operazione
✓ Log dettagliato di tutte le operazioni
✓ Possibilità di ripristinare ogni modifica
✓ Non richiede installazione (portabile)
✓ Richiede privilegi di amministratore


================================================================================
🚀 COME USARE L'APPLICAZIONE
================================================================================

METODO 1 - AVVIO RAPIDO (Consigliato):
--------------------------------------
1. Fai doppio click su "Avvia_Optimizer.bat"
2. Conferma l'elevazione dei privilegi (UAC)
3. L'applicazione si avvierà automaticamente

METODO 2 - AVVIO MANUALE:
--------------------------
1. Fai click destro su "Windows11_Optimizer.ps1"
2. Seleziona "Esegui con PowerShell"
3. Se richiesto, conferma l'esecuzione
4. L'applicazione richiederà automaticamente i privilegi di amministratore


================================================================================
🎯 FUNZIONALITÀ DISPONIBILI
================================================================================

SEZIONE OTTIMIZZAZIONI (Pannello Sinistro):
-------------------------------------------
• Crea Punto di Ripristino - Crea un backup del sistema
• Disabilita Effetti Visivi - Rimuove animazioni e trasparenze
• Disabilita Servizi Non Necessari - Disattiva servizi che consumano risorse
• Pulisci File Temporanei - Elimina file temp, cache e cestino
• Disabilita App in Background - Impedisce alle app di girare in background
• Disabilita Widget e News - Rimuove widget dalla barra delle applicazioni
• Piano Alte Prestazioni - Massime prestazioni (consuma più energia)
• Disabilita Ibernazione - Libera spazio su disco
• OTTIMIZZAZIONE COMPLETA - Applica tutte le ottimizzazioni insieme

SEZIONE RIPRISTINO (Pannello Destro):
-------------------------------------
• Riabilita Effetti Visivi - Ripristina animazioni e trasparenze
• Riabilita Servizi - Riattiva i servizi disabilitati
• Riabilita App in Background - Permette alle app di girare in background
• Riabilita Widget e News - Ripristina i widget
• Piano Bilanciato - Equilibrio tra prestazioni e consumo
• Riabilita Ibernazione - Riattiva l'ibernazione
• RIPRISTINO COMPLETO - Annulla tutte le ottimizzazioni


================================================================================
⚙️ FUNZIONAMENTO
================================================================================

1. CONFERMA RICHIESTA:
   Ogni operazione richiede la tua conferma esplicita prima di procedere.
   Puoi sempre annullare cliccando "No".

2. LOG OPERAZIONI:
   Tutte le azioni vengono registrate nel log in basso.
   Il log mostra:
   - Timestamp di ogni operazione
   - Stato di completamento (✓ successo, ✗ errore, ⚠ warning)
   - Eventuali messaggi di errore

3. NOTIFICHE:
   Al completamento di ogni operazione riceverai una notifica che conferma
   il successo o segnala eventuali errori.


================================================================================
⚠️ RACCOMANDAZIONI IMPORTANTI
================================================================================

PRIMA DI INIZIARE:
-----------------
✓ CREA UN PUNTO DI RIPRISTINO usando il pulsante dedicato
✓ Chiudi tutte le applicazioni aperte
✓ Salva il tuo lavoro
✓ Leggi le descrizioni delle operazioni prima di confermare

DOPO L'OTTIMIZZAZIONE:
---------------------
✓ Riavvia il computer per applicare tutte le modifiche
✓ Verifica che tutto funzioni correttamente
✓ Se qualcosa non va, usa i pulsanti di RIPRISTINO

NON CONSIGLIATO:
---------------
✗ Non usare su laptop l'opzione "Alte Prestazioni" (consuma batteria)
✗ Non disabilitare servizi se non sei sicuro di cosa facciano
✗ Non applicare l'ottimizzazione completa senza sapere cosa fa


================================================================================
🔧 TROUBLESHOOTING
================================================================================

PROBLEMA: "Impossibile eseguire script su questo sistema"
SOLUZIONE: Apri PowerShell come amministratore e digita:
           Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
           Poi riavvia l'applicazione.

PROBLEMA: L'applicazione non si avvia
SOLUZIONE: Usa il file "Avvia_Optimizer.bat" oppure:
           1. Click destro su Windows11_Optimizer.ps1
           2. Apri con → PowerShell
           3. Conferma l'elevazione privilegi

PROBLEMA: Dopo l'ottimizzazione il PC è più lento
SOLUZIONE: 
           1. Usa il pulsante "Riabilita Servizi"
           2. In particolare riabilita "SysMain" e "Windows Search"

PROBLEMA: La ricerca di Windows non funziona
SOLUZIONE: Usa il pulsante "Riabilita Servizi" per riattivare Windows Search

PROBLEMA: Voglio annullare tutto
SOLUZIONE: Usa il pulsante "RIPRISTINO COMPLETO" nel pannello destro


================================================================================
💾 REQUISITI SISTEMA
================================================================================

• Windows 11 (qualsiasi versione)
• PowerShell 5.1 o superiore (già incluso in Windows 11)
• Privilegi di amministratore
• .NET Framework (già incluso in Windows 11)


================================================================================
📁 FILE INCLUSI
================================================================================

• Windows11_Optimizer.ps1 - Applicazione principale
• Avvia_Optimizer.bat - Launcher rapido
• README.txt - Questo file


================================================================================
🔒 SICUREZZA E PRIVACY
================================================================================

• L'applicazione NON raccoglie dati
• Tutto viene eseguito localmente sul tuo PC
• Non richiede connessione internet
• Non invia informazioni a server esterni
• Il codice è completamente trasparente e modificabile


================================================================================
❓ DOMANDE FREQUENTI (FAQ)
================================================================================

D: È sicuro usare questa applicazione?
R: Sì, tutte le operazioni sono reversibili e l'applicazione richiede conferma
   per ogni azione. Crea sempre un punto di ripristino prima di iniziare.

D: Devo riavviare dopo ogni operazione?
R: Non è necessario, ma è consigliato riavviare dopo aver completato tutte
   le ottimizzazioni desiderate per applicare le modifiche.

D: Posso usarla su laptop?
R: Sì, ma evita il "Piano Alte Prestazioni" che consuma più batteria.
   Usa invece le altre ottimizzazioni.

D: Quanto spazio su disco libererà?
R: Dipende dal tuo sistema, ma tipicamente:
   - Pulizia file temporanei: 500MB - 5GB
   - Disabilita ibernazione: 4-16GB (dimensione della RAM)

D: Posso eseguire solo alcune ottimizzazioni?
R: Sì! Usa i pulsanti singoli invece dell'"Ottimizzazione Completa".
   Ogni pulsante esegue solo l'operazione indicata.

D: L'applicazione modifica il registro di sistema?
R: Sì, alcune operazioni modificano chiavi di registro per disabilitare
   funzioni. Tutte le modifiche sono reversibili con i pulsanti di ripristino.


================================================================================
🎯 CONSIGLI PER L'USO OTTIMALE
================================================================================

PER PC GAMING:
-------------
✓ Disabilita effetti visivi
✓ Piano alte prestazioni
✓ Disabilita app in background
✗ Non disabilitare servizi Xbox se giochi su Xbox Game Pass

PER PC UFFICIO:
---------------
✓ Pulisci file temporanei (regolarmente)
✓ Piano bilanciato
✓ Disabilita widget se non li usi
⚠ Valuta se disabilitare Windows Search (rallenta la ricerca file)

PER LAPTOP:
----------
✓ Pulisci file temporanei
✓ Disabilita app in background
✓ Piano bilanciato (NON alte prestazioni)
✗ Non disabilitare ibernazione (utile per risparmiare batteria)

PER PC VECCHI/LENTI:
-------------------
✓ Ottimizzazione completa
✓ Pulisci regolarmente i file temporanei
✓ Disabilita tutto ciò che non usi


================================================================================
📞 SUPPORTO
================================================================================

Per problemi o domande:
• Controlla la sezione TROUBLESHOOTING in questo README
• Consulta il log dell'applicazione per dettagli sugli errori
• Usa il punto di ripristino in caso di problemi gravi


================================================================================
📝 NOTE LEGALI
================================================================================

Questa applicazione viene fornita "così com'è" senza garanzie di alcun tipo.
L'utente si assume la piena responsabilità dell'uso dell'applicazione.
Si consiglia di creare un punto di ripristino prima di procedere.


================================================================================
🎉 RINGRAZIAMENTI
================================================================================

Grazie per aver usato Windows 11 Optimizer!
Questa applicazione è stata creata per rendere più semplice e sicura
l'ottimizzazione di Windows 11.


================================================================================
Fine del README
Versione: 1.0 - 2026
================================================================================
