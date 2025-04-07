# oVirt

# En "kort" manual för oVirt

Tjo! Du undrar hur man når oVirt för att du vill stirra in i dimman.\nSom en sann student vet du att man inte når dimman enkelt.

## Att ens ta sig till UIn

Med det sagt så är målet att nå <https://dimman.blossom.dsek.se/ovirt-engine/>

För att kunna använda länken behöver du vara bakom gatewayen. Det kan du åstadkomma genom att sätta upp en SSH-tunnel till hyacinth.

Man gör detta genom att använda SSH via proxyjumps för att säga att all trafik till en sida (rimligen localhost) ska gå till hyacinth på en viss port. 

för att sätta upp en tunnel behöver du först redigera din /etc/hosts fil, och lägga till följande rad:

`127.0.0.1 localhost dimman.blossom.dsek.se`

detta gör att din browser skickar all traffik till localhost när du går in på dimman. Detta behövs för att certifikat ska fungera ordentligt.

kör sedan följande kommand **och lämna terminalen öppen.**

`sudo ssh -L 443:dimman.blossom.dsek.se:443 username@hyacinth.blossom.dsek.se`

Nu kan du gå till dimman.blossom.dsek.se i webbläsaren. Inloggningsuppgifter finns i [Syspass](https://cpu.dsek.se./../../Reference/Services/Syspass.md), kontot heter "ovirt-admin". Tryck sen på länken "Administration Portal", där finns allt man kan behöva göra.

## Att skapa en ny vm

Fedora Server används numera, och guiden är skriven för Fedora Server 41.

[Kickstart](/en/guides/Kickstart) används numera för att skapa vm:s då det varit problem med att skapa och använda Fedora Server som sealed templates.

## Att skapa en ny VM med kickstart

### Gå till oVirt

Så hur skapar man en ny VM? Logga in först! Välj admin view inte Vm view eller vad det heter.

På syspass finns admin lösen för ovirt (men detta kan komma att ändras när vi får bättre inlogg hit)

Gå till compute och sedan VMs

OBS! Att trycka enter någon gång under processen kommer skapa VM:en med de hittils inksrivna inställningarna utan att vänta på bekräftan!

### Tabbar under new

#### General

Välj New och sätt OS till Linux, samt ge den ett namn. Ge också en bra discription till din VM.

Vid Instance Images tryck på create för att skapa en disk till vm:en. välj ditt "storage domain" där du kan ta "bulk-" eller "fast-storage". Detta är vilka diskar som kommer att användas i vårt rack. Antingen vanliga hårddiskar eller SSD. Sen ok.

Attacha sedan kickstart disken.

Välj också "nat" som nic1 under network interface för att enheten ska kunna komma ut på internet.

#### System

Ge den ram. typ 2gb (det är det första fältet), 2 CPU kärnor, ställ in tiden.

#### Initial Run

OBS, detta steget gör inget nu, så kan skippa innan cloud-init är uppsatt under installationen.

Under "initial run" välj "cloud init" Välj hostname, man kan sätta detta till vad som men välj gärna [x.blossom.dsek.se](http://x.blossom.dsek.se)

Välj sedan användarnman och ett bra lösenord

#### High Availability

Tryck in highly available ("eller tänk själv you sheep" - Esbjörn). Välj också en passande prioritering.

#### Boot Options

Tryck i attach CD och välj passande fedora iso. Se till att first device är satt till CD-ROM, och second är satt till Hard Disk.

### Efter Skapandet

Kolla Nic på VMen för MAC-adressen. Denna ska man också lägga in tillsammans med IPn i hostname filen ~~Blossoms ipadresser ligger på xxx.xxx.21.yyy så bara ta nästa y om du väljer den.~~ Du hittar vilka mönster som du ska följa med ip adresserna i wiki artikeln för IPs I framtiden kommer detta att ersättas med dumbo-m :relaxed:

### Ta en paus från oVirt

Updatera också filen som ligger på blossomrepot (yml filen) Lägg den under virtual machine

Skriver man in den som virtual host så kan den ha en gateway om man kör ett skript men de kommer vi inte använda så ofta

Vi har också en fil som sätter ihop mac och ips på blossom (router/ethers.j2). Denna måste uppdateras så vi har våra statiska IPs

Man kan sedan köra ett fett ansible kommando för att uppdatera routern och branväggen

`ansible-playbook -bK --limit hyacinth.blossom.dsek.se -i hosts.yml router.yml`


:::warning
Hyacinth har en gammal version av python (3.6.8), vilket inte inkluderar lite funktioner som ansible-core vill ha (Future feature annotations specifikt). På grund av detta måste man använda en äldre version av hela ansible paketet för att kunna synca saker. Den nyaste versionen som vi kan använda på Hyacinth är ansible (4.10.0) med ansible-core (2.11.7). För att fixa detta kan man t.ex. skapa en venv för python, och installera rätt version med `pip install ansible==4.10.0`

:::

Glöm inte att pusha upp detta igen (och samma här om att det kommer att vara i dumbom istället i framtiden)

### Tillbaka till oVirt

Installationen ska vara automatisk, och vm:en ska stängas av när den är klar. Om den tar mycket lång tid bör man remote-consol:a in och kolla läget. När den är klar så måste boot order ändras till hårddisk och kickstart disken tas bort (radera bara inte den!!).

Starta VM:en när dhcp info för nya vm:en ligger på routern. I nuläget sätts inte hostname automatiskt, och detta måste göras manuellt. Ssh:a in via ip från någonstans i klustret (hyacinth) eller remote-consol:a in och sätt hostname. En omstart kan krävas.

#### Om du gör fel (som Oskar)

Om du gör som Oskar dvs fel och satte VM leasen på en annan lagring än VMen ligger på. VM lease berättar att en vm är igång och denna måste vara på samma disk som VM använder. Man kan också sätta caps på för mängden storage VMarna använder här.

Detta kan man skippa om man inte gör fel

### Sätt upp konto för enheten

In på ipa och skapa ett sjukt långt lösenord som man inte behöver spara (utöver nästa steg!!!!!1!one!). Detta kommer att skicka alla mail för updates. Lägg till det under mailalias på hemsidan och lägg till det som special sender. Logga också in på mailmaster och kör följande kommando som root: `ipa user-mod <mailkonto> --password-expiration 20300730115110Z`, för att uppdatera password expiration för kontot som skapades.


:::warning
Om detta kommandot har körts på alla våra servrar kommer alla våra lösenord för våra automatiska mail sluta vara giltiga 30/7 2030 kl 11:51

:::

### Kör scripts


:::info
Pröva att använda `ssh-copy-id` för att kopiera över ssh nycklar till användaren på den nya vm:en om Ansible klagar på `Permission denied` när scripten körs

:::

I dumbo-m repot så det finns det sen ett par scripts som man ska köra typ

`ansible-playbook -i inventory/ -u username -bK --limit file-server new_vms/autoUpdate_cron.yml` där username är en användare på enheten. Här behöver man också det långa lösenordet som du troligtvis skapade och kastade tidigare

`ansible-playbook -i inventory/ -u username -bK --limit file-server new_vms/initial_setup.yml` där man sen joinar med ett sudokonto med hens ipa password. Om den klagar, kör `ansible-galaxy collection install freeipa.ansible_freeipa`

ntp körs enkelt

## Extend the VM disk size after installing from template

### Extend/enlarge the partition


1. Unless freshly installed, create snapshot to avoid data loss
2. Open cfdisk
3. Use the resize on the lvm installed partition (most likely /dev/sda3) to use the unused space.
4. Use Write to apply changes

### Resize physical volume (PV) in LVM

`pvresize /dev/sda3`

### Resize logical volumes (LV) in LVM

use `lvdisplay` to display information about the LVs

#### Extend logical volumes

Use `lvextend` to extend LVs

Give som space for /var... `lvextend -L 100G /dev/cs/var`

...something reasonable for swap... `lvextend -L 32G /dev/cs/swap`

...and the rest for root `lvextend -l +100%FREE /dev/cs/root`

#### Extend file systems on the logical volumes

Extend var and root (might take a while)

```
xfs_growfs /dev/cs/var
xfs_growfs /dev/cs/root
```

Remove, partition and enable swap

```
swapoff -a
mkswap /dev/cs/swap
swapon -a
```

## Att ansluta till remote-console för en VM

### Gå till oVirt

Redigera den VM som du vill titta på konsollen för. Gå till "Console" och välj grafiktyp QXL, sedan grafikprotokoll SPICE. Om det inte var gjort redan måste du sedan starta om VMen.

Spara inställningarna, och klicka på "console". Denna fil du får ner är giltig i två minuter. Redigera filen och ersätt IP-adressen i filen med exempelvis "[primrose.blossom.dsek.se](http://primrose.blossom.dsek.se)"

### SSH-forwarding

Du måste lägga in hosten som VMen kör på i din /etc/hosts-fil för att kunna forwarda korrekt.

Lägg in detta: `127.0.0.1 localhost primrose.blossom.dsek.se` om din VM kör på primrose Ersätt primrose med rätt hostname och kör `for i in $(seq -w 0 20); do printf "\-L 59$i:primrose:59$i "; done | sed 's;\\;;g'`. Kopiera resultatet. Kör sedan `ssh användarnamn@hyacinth.blossom.dsek.se <resultat från förra kommandot>` Glöm inte att ta bort allt du lade till i /etc/hosts när du är klar!

### Öppna konsollen

Installera programmet som heter remote-viewer (Paketet heter virt-viewer på Arch btw). Öppna sedan det genom att köra `remote-viewer console.vv` i mappen där du laddat ned console-filen till.

### ???

### Profit