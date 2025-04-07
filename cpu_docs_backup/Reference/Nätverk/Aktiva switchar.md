# Aktiva switchar

# Att ansluta till Cisco-switchar


1. Anslut USB-kabeln i racket till din dator och till Console-porten (micro-usb) på switchen.
2. Om du använder Linux, ladda ner minicom.
3. Använd `sudo minicom -s` och gå till *Inställningar för serieport.* Sätt *Serieenhet* (A) till switchens tty (kan hittas genom att jämföra `ls /dev/tty*` med kabeln i- och urkopplad och undersöka vilken som försvinner, för mig var det `ttyACM0`). Sätt Bps/Par/Bitar (E) till 9600.
4. Spara din anslutning med *Spara konfiguration som dfl*.
5. Öppna en minicom-anslutning med `sudo minicom` (eventuellt behövs inte sudo), du ska nu vara ansluten till switchen.

Observera att switcharna kör Cisco IOS, deras egna operativsystem, och använder därför inte bash. Hjälpkommando körs genom att skriva `?`.


# Portkonfiguration på switchar

(2025-03-03)

Kan ses genom `show vlan brief` och `show interfaces trunk`.

## Kit

Kit (Cisco 2960X Series, 48 portar PoE) Kit håller alla kopplingar till PoE devices.

| Port | VLAN |
|----|----|
| 1 | Trunk VLANs 1, 7, 25 |
| 2 | 1 |
| 3 | 1 |
| 4 | 1 |
| 5 | 1 |
| 6 | 1 |
| 7 | 1 |
| 8 | 1 |
| 9 | 1 |
| 10 | 1 |
| 11 | 1 |
| 12 | 1 |
| 13 | 1 |
| 14 | 1 |
| 15 | 1 |
| 16 | 1 |
| 17 | 1 |
| 18 | 1 |
| 19 | 1 |
| 20 | 1 |
| 21 | 1 |
| 22 | 1 |
| 23 | 1 |
| 24 | 1 |
| 25 | trunk VLANs 1, 7, 25 |
| 26 | 7 |
| 27 | 7 |
| 28 | 7 |
| 29 | 7 |
| 30 | 7 |
| 31 | 7 |
| 32 | 7 |
| 33 | 7 |
| 34 | 7 |
| 35 | 7 |
| 36 | 7 |
| 37 | 7 |
| 38 | 7 |
| 39 | 7 |
| 40 | 7 |
| 41 | 7 |
| 42 | 7 |
| 43 | 7 |
| 44 | 7 |
| 45 | 7 |
| 46 | 7 |
| 47 | 7 |
| 48 | 7 |
| 49 | 1 |
| 50 | 1 |
| 51 | 1 |
| 52 | 1 |

## Rivet

Rivet (Cisco 2960X Series, 24 portar) Rivet sköter kopplingar till Geekend

| Port | VLAN |
|----|----|
| 1 | Trunk VLANs 1, 88, 90 |
| 2 | 88 |
| 3 | 88 |
| 4 | 88 |
| 5 | 88 |
| 6 | 88 |
| 7 | 88 |
| 8 | 88 |
| 9 | 90 |
| 10 | 90 |
| 11 | 90 |
| 12 | 90 |
| 13 | 90 |
| 14 | 90 |
| 15 | 90 |
| 16 | 90 |
| 17 | 1 |
| 18 | 1 |
| 19 | 1 |
| 20 | 1 |
| 21 | 1 |
| 22 | 1 |
| 23 | 1 |
| 24 | 1 |
| 25 |    |
| 26 |    |
| 27 |    |
| 28 |    |
| 29 |    |
| 30 |    |
| 31 |    |
| 32 |    |
| 33 |    |
| 34 |    |
| 35 |    |
| 36 |    |
| 37 |    |
| 38 |    |
| 39 |    |
| 40 |    |
| 41 |    |
| 42 |    |
| 43 |    |
| 44 |    |
| 45 |    |
| 46 |    |
| 47 |    |
| 48 |    |
| Te1 | 1 |
| Te2 | 1 |
| Te3 |    |
| Te4 |    |

## Ratchet

Ratchet (Cisco 2960X Series, 24 portar) Vår enhet som sköter kopplingarna till våra blommnoder samt Kit och Rivet.

| Port | VLAN |
|----|----|
| 1 | Trunk VLANs 1, 2, 7, 21, 88, 137 |
| 2 | Trunk VLANs 1, 2, 7, 21, 88, 137 |
| 3 | Trunk VLANs 1, 2, 7, 21, 88, 137 |
| 4 | 21 |
| 5 | 21 |
| 6 | 21 |
| 7 | Trunk VLANs 1, 2, 7, 21, 88, 137 |
| 8 | Trunk VLANs 1, 2, 7, 21, 88, 137 |
| 9 | 7 |
| 10 | 21 |
| 11 | 7 |
| 12 | 21 |
| 13 | 1 |
| 14 | Trunk VLANs 1, 2, 7, 21, 88, 137 |
| 15 | Trunk VLANs 1, 2, 7, 21, 88, 137 |
| 16 | Trunk VLANs 1, 2, 7, 21, 88, 137 |
| 17 | 1 |
| 18 | 1 |
| 19 | 1 |
| 20 | 1 |
| 21 | 1 |
| 22 | 1 |
| 23 | 21 |
| 24 | 21 |
| 25 |    |
| 26 |    |
| 27 |    |
| 28 |    |
| 29 |    |
| 30 |    |
| 31 |    |
| 32 |    |
| 33 |    |
| 34 |    |
| 35 |    |
| 36 |    |
| 37 |    |
| 38 |    |
| 39 |    |
| 40 |    |
| 41 |    |
| 42 |    |
| 43 |    |
| 44 |    |
| 45 |    |
| 46 |    |
| 47 |    |
| 48 |    |
| Te1 | 1 |
| Te2 | 1 |
| Te3 |    |
| Te4 |    |

## Clank

Clank (Cisco 2960X Series, 24 portar) Clank sköter filöverföring till Pando, vår filserver. Den har kopplingar till alla blommor men inte utåt

| Port | VLAN |
|----|----|
| 1 | 1 |
| 2 | 1 |
| 3 | 1 |
| 4 | 1 |
| 5 | 1 |
| 6 | 1 |
| 7 | 1 |
| 8 | 1 |
| 9 | 1 |
| 10 | 1 |
| 11 | 1 |
| 12 | 1 |
| 13 | 1 |
| 14 | 1 |
| 15 | 1 |
| 16 | 1 |
| 17 | 1 |
| 18 | 1 |
| 19 | 1 |
| 20 | 1 |
| 21 | 1 |
| 22 | 1 |
| 23 | 1 |
| 24 | 1 |
| 25 |    |
| 26 |    |
| 27 |    |
| 28 |    |
| 29 |    |
| 30 |    |
| 31 |    |
| 32 |    |
| 33 |    |
| 34 |    |
| 35 |    |
| 36 |    |
| 37 |    |
| 38 |    |
| 39 |    |
| 40 |    |
| 41 |    |
| 42 |    |
| 43 |    |
| 44 |    |
| 45 |    |
| 46 |    |
| 47 |    |
| 48 |    |
| Te1 | 1 |
| Te2 | 1 |
| Te3 |    |
| Te4 |    |