# Podman

# Podman och systemd-tjänster


:::warning
Varning för Podman propaganda i följande artikel

:::

## Bakgrund

Ett av flera sett som vi kör tjänster är i containers som hanteras av podman genom systemd. Podman är samma sak som docker, ett sett att köra containers.

En sak som är bra med podman jämfört med docker är den utmärkta integrationen med systemd genom Quadlet-filer. [man-pages](https://docs.podman.io/en/latest/markdown/podman-systemd.unit.5.html) är en bra början för att förstå hur det funkar.

Red Hat har också skrivit en [introduktion till Quadlet](https://www.redhat.com/en/blog/quadlet-podman) (alltså kopplingen till systemd) om du fortfarande inte är övertygad. Den har inte med alla nya features, men är fortfarande bra som en pitch och för att förstå tankarna bakom.

## Hur man skapar en ny tjänst


1. Skapa mapp `/srv/<tjänst>`
2. Lägg till fil för containern som ska köras, `<tjänst>.container`. Några saker att tänka på:
   * Om flera containers behövs för att köra tjänsten görs det enklast med en pod och flera containerfiler.
   * Data som behöver vara persistent ska göras som bindmounts, alltså vanliga mappar/filer i filsystemet, hellre än podman volumes. Det blir enklare på alla sätt att jobba med filerna då.
   * Containers har ibland lång starttid när de behöver hämta en ny image. Det kan därför vara bra att lägga till `TimeoutStartSec=900` under `[Service]` på alla `.container`-filer
3. Symlinka alla quadlet-filer till `/etc/containers/systemd`, t.ex. `ln -s /srv/nginx/nginx.container /etc/containers/systemd/`
4. `systemctl daemon-reload` för att generera .service-filerna (filerna hamnar i `/run/systemd/generator`, men det behöver man oftast inte tänka på)
5. `systemctl start <tjänst>.service` eller `systemctl start <tjänst>-pod.service`

## Men alla guider är ju för docker/docker-compose!

Ja, tyvärr har inte alla fattat det underbara med Podman och Quadlet ännu. Lyckligtvis går det alltid att översätta docker-compose till Quadlet (tror jag iallafall), och ibland är det till och med ganska enkelt.

[Podlet](https://github.com/containers/podlet) är ett verktyg som försöker att automatiskt generera Quadletfiler utifrån antingen `docker-compose.yml` eller ett `docker run` kommando. Exempel: `podlet --file --install compose --pod docker-compose.yml`. Podlet är ganska kinkig när det gäller korrekthet, så composefiler som använder deprecated features brukar ge felmeddelanden. Ibland kan  man lösa det genom att ändra composefilen till podlet blir nöjd, ibland är det lättare att skriva egna quadletfiler från grunden.

Även om konverteringen lyckas kan det vara bra att kolla igenom filerna så det bara är det nödvändiga som är med. Var särskilt uppmärksam kring volumes och networks så de hanteras på det sätt du vill. Det är också vanligt att compose-filer specificerar images på kortform, utan att ange container registry, eftersom den då gissar dockerhub. Podman gissar inte, så se till att Image= börjar med `docker.io/`.

## Vanliga saker förklarat

### Vad är en pod och varför är det bra?

<https://www.redhat.com/en/topics/containers/what-is-podman>

För att få flera containers att samverka smidigt brukar podman rekommendera lösningen pods, snarare än networks som man måste dras med om man använder docker. Man kan säga att det är en gruppering av flera containers där de delar på vissa resurser, t.ex. nätverk.

Pods funkar förstås jättebra med systemd, bara starta din pod så startar den automatiskt alla containers som ingår däri. Quadlet ger automatisk tjänsten ett namn i stil med `<tjänst>-pod.service`, men om man inte gillar det går det att sätta `ServiceName=` i `[Pod]`-avsnittet.

Själva .pod-filen brukar vara ganska kort. Den kan innehålla några `PublishPort=` och kanske ett `[Install]`-avsnitt. Sedan måste alla containers som ska ingå ha raden `Pod=<tjänst>.pod`. Resten sker automagiskt.

Det är viktigt att tänka på att alla containers i en pod delar på samma `localhost`. Dett skiljer sig från docker, som ju brukar använda ett gemensamt network och hitta containers andra containers genom deras namn. Därför måste man tänka efter lite extra när man följer en guide eller konvererar en compose-fil så man inte försöker använda en containers hostname. Byt ut de förekomsterna mot `localhost` eller `127.0.0.1`. Två containers kan heller inte binda samma port.

### Mer om nätverk

`localhost` inuti en container betyder containerns (eller poddens) interna nätverk och är inte samma som datorns localhost. Om man vill komma åt datorns localhost, t.ex. för att kommunicera med en annan tjänst som maskinen kör, så ska man använda `host.containers.internal`. Om den andra tjänsten kan köras i en container kan man också överväga att skapa ett podman network istället.

### Automatiska uppdateringar

Det är busenkelt att få till automatiska uppdateringar av containers. Lägg till `AutoUpdate=registry` under `[Container]`-avsnittet och aktivera sedan systemd-timern `systemctl enable --now podman-auto-update.timer`.

### Autostart (motsvarande enable)

Om du har försökt göra `systemctl enable` på en containertjänst har du förmodligen fått ett argt felmeddelande. Det är inget att deppa över, för det finns andra sätt att uppnå automatisk start av dina tjänster. Lägg bara till det här avsnittet i container-filen eller pod-filen (inte båda):

```
[Install]
WantedBy=default.target
```

## Några exempel

I skrivande stund är valvet.blossom ett bra exempel att kolla på.

# Rootless podman

Ibland kan det vara användbart att köra podman som sin egen användare. Exempelvis kan man slippa installera packages om det är något verktyg som bara behövs en gång, eller för att bara testa något innan man gör en riktig systemd-tjänst av det. Våra IPA-användare har inte automatiskt subuid konfigurerat, något som är nödvändigt för hur rootless podman fungerar. För att fixa det, på valfri ipa-joinad maskin, kör `kinit` följt av `ipa subid-generate`.