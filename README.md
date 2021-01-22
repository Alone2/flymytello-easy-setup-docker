# flymytello-easy-setup-docker

## Setup

### Server mit 2 Netzerken Verbinden (Tello und Internet)
Die einfachste Möglichkeit das zu erreichen, ist das Pi an ein Ethernetkabel anzuschliessen und die Drohne per WLAN mit dem Pi zu verbinden.

Man kann sich über die Netzwerkeinstellungen mit dem WLAN der Drohne verbinden
```sudo raspi-config```


In ```/etc/wpa_supplicant/wpa_supplicant.conf``` sollte idealerweise nur das WLAN der Drohne angegeben sein.

## Installation

### Git installieren
Falls git noch nicht installiert ist und die Applikation auf einem Raspberry Pi installiert werden soll, kann es folgendermassen installiert werden:
```sudo apt update && sudo apt install git```

### Installiere Docker und Docker-Compose.
Docker sollte nach dem offiziellen [Anleitung](https://docs.docker.com/engine/install/ubuntu/) installiert werden.
Das gleiche gilt für [Docker-Compose](https://docs.docker.com/compose/install/)

### Certbot installieren
Falls die Applikation auf einem Raspberry Pi installiert werden sollte, muss 'certbot' noch installiert werden mit ```sudo apt update && sudo apt install certbot```

### Port öffnen
Die Ports 5001, 80 und 433 müssen gegen aussen geöffnet werden (TCP und UDP).
Wie ganau diese Ports geöffnet werden ist von Router zu Router unterschiedlich.

[Diese Webseite](https://portforward.com/router.htm) hat eine Liste von Routern und Anleitungen wie die Ports geöffnet werden können.

### Domain für SSL Verifizierung 
Damit wir eine sichere SSL Zertifizierung erhalten, brauchen wir eine Domain, weil LetsEncrypt keine Zertifizierungen für blanke Ip-Addressen ausstellt.

Falls man keine Domain kaufen will, gibt es eine kostenlose alternative: [duckdns](https://www.duckdns.org/) 
Flymytello-easy-setup-docker hat duckdns integriert; man kann sich auf der duckdns Webseite anmelden, eine subdomain erstellen und diese sowie den Nutzer-Token, welcher auch auf der Startseite von duckdns angezeigt wird, später beim Setupprozess angeben.

### Setup
Projekt herunterladen
```git clone https://github.com/Alone2/flymytello-easy-setup-docker``` 

Setup starten:
Achtung: Das Passwort welches man eingibt braucht man später um sich einzuloggen.
```sh setup.sh``` 

### Starten
Applikation starten:
ACHTUNG: Die Drohne muss vor eingabe dieses Commands mit dem Gerät verbunden sein!
```docker-compose up -d``` 

### Stopen
```docker-compose stop``` 
