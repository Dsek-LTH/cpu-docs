# ✏️ Discord-synk

Linker som kopplar ihop discord konton med dsek konton heter [Janus](https://github.com/Dsek-LTH/Janus/).

Boten som körs på discord heter [Råsa Pantern](https://github.com/Dsek-LTH/rasa-pantern).


Vi behöver en Discord bot för att kunna lägger till roller för användare.

Den behöver veta:


1. Vilka roller har användare X?
2. Vem är användare X?


---

### Alternativ 1 :white_check_mark:


1. Logga in i på dsek.se Discord via linked roles system.
2. När dom loggas in så sparas koppling mellan Discord ID och stil-id någonstans.
3. Och sen används stil-id för att kolla upp roller någonstans.

* Isolerad tjänst vilket ger separat underhåll, failure isolation
* Smidig log-in

### Alternativ 2

Logga in i Discord på dsek.se

### Alternativ 3

Skriv in Discord ID på hemsidan.

### Alternativ 4

Köra ett kommando i en Discord kanal.


\