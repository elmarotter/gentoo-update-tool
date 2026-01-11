# Gentoo Update Tool

Een minimalistisch en betrouwbaar update‑script voor Gentoo Linux.  
Dit script automatiseert de volledige Gentoo‑onderhoudscyclus, maar houdt alles transparant en onder jouw controle.  
Het is bedoeld voor gebruikers die Gentoo goed kennen en een voorspelbare, reproduceerbare workflow willen zonder onnodige complexiteit.

---

## Clonen & Uitvoeren

```bash
git clone https://github.com/elmarotter/gentoo-update-tool.git
cd gentoo-update-tool
sudo ./update_new.sh
```

---

## Functionaliteit

- Portage synchroniseren  
- @world updaten  
- Reverse dependencies opnieuw bouwen  
- Ongebruikte pakketten opruimen  
- Preserved libraries controleren  
- Configuratiebestanden bijwerken  
- Optioneel: ongebruikte USE‑flags detecteren  
- Optioneel: verouderde taal‑targets (PHP, Python, etc.) detecteren  
- Heldere, gestructureerde output  
- Geen verborgen magie — elke stap is expliciet  

---

## Waarom dit script bestaat

Gentoo geeft maximale controle, maar de update‑routine is vaak repetitief.  
Dit script vangt de best‑practice volgorde die ervaren Gentoo‑gebruikers handmatig uitvoeren en maakt er een consistente workflow van.

Het verbergt geen complexiteit — het verwijdert alleen de herhaling.

---

## Gebruik

Voer uit als root:

```bash
./update_new.sh
```

Het script voert achtereenvolgens uit:

1. Portage sync  
2. @world update  
3. Revdep‑rebuild  
4. Preserved libs check  
5. Depclean  
6. Config updates toepassen  
7. Optioneel: ongebruikte USE‑flags detecteren  

Je behoudt volledige controle over USE‑flag wijzigingen en config‑merges.

---

## Vereisten

- Gentoo Linux  
- Portage  
- Standaard systeemtools (bash, diff, etc.)  

---

## Licentie (MIT)

```text
MIT License

Copyright (c) 2024 Elmar Otter

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the “Software”), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
IN THE SOFTWARE.
```
