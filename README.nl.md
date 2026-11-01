# Gentoo Update Tool

Een minimalistisch en betrouwbaar update‑script voor Gentoo Linux.  
Dit script automatiseert de volledige Gentoo‑onderhoudscyclus, maar houdt alles transparant en onder jouw controle.  
Het is bedoeld voor gebruikers die Gentoo goed kennen en een voorspelbare, reproduceerbare workflow willen zonder onnodige complexiteit.

---

## Clonen & Uitvoeren

```bash
git clone https://github.com/elmarotter/gentoo-update-tool.git
cd gentoo-update-tool
chmod u+x update_new.sh
chmod u+x update_new_NL-NL.sh
./update_new.sh
```
Voor de Nederlandse versie:
```bash
./update_new_NL-NL.sh
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
- Functie om pakketgroepen om te zetten naar ~amd64 met een dropdown menu 
- Heldere, gestructureerde output  
- Geen verborgen magie — elke stap is expliciet  

---

## Waarom dit script bestaat

Gentoo geeft maximale controle, maar de update‑routine is vaak repetitief.  
Dit script vangt de best‑practice volgorde die ervaren Gentoo‑gebruikers handmatig uitvoeren en maakt er een consistente workflow van.

Het verbergt geen complexiteit — het verwijdert alleen de herhaling.

---

## Gebruik

Voer uit als gebruiker, het script gebruikt sudo daar waar nodig:

```bash
./update_new.sh
```

Het script voert achtereenvolgens uit:

1) Sync portage met eix-sync                 6) @preserved-rebuild                      11) Herbouw wereld                          16) Perl cleaner reallyall
2) Update                                    7) Check en herstel                        12) Herbouw systeem + wereld                17) Clean distfiles
3) Update met binaries                       8) Doe de eix-test-obsolete                13) Toon nieuws                             18) Toon geïnstalleerde pakketten
4) Clean                                     9) Update config-bestanden                 14) Toon al het nieuws                      19) Genereer ~amd64 keywords per categorie
5) Verwijder oude kernels                   10) Herbouw systeem                         15) Perl cleaner all                        20) Stoppen


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
