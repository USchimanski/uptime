# Uptime

In der Linux Welt gibt es das Kommandozeilen Tool "uptime". Mit diesem Tool kann man sich die Startzeit des Rechners sich ausgeben lassen. Auch ist es Möglich, sich die Vergangene Zeit sich anzeigen zu lassen. Dieses Tool wurde nun als PowerShell Programm erstellt.
## Installation
Die "uptime.ps1" Datei in das Verzeichnis C:\Windows\System32 kopieren und es steht dann Systemweit zu Verfügung. Oder man erstellt ein neues Verzeichnis und kopiert die Datei dort hinein. Im Anschluss sollte die Path Variable mit dem neuen Verzeichnis ergänzt werden.
## Syntax

uptime [-p] [-s] [-h] [-v]

-v &emsp; Zeigt die Version an

-h &emsp; Anzeige der Hilfe

-p &emsp; Pretty Anzeige

-s &emsp; Abgelaufene Zeit anzeigen

