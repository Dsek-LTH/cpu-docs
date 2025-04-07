# Kickstart

## Bakgrund

Kickstart är en fil som beskriver hur en Red Hat-kompatibel distro ska installeras så att installationen kan automatiseras. Då skapandet av sealed templates har stött på problem är detta ett bra alternativ.

## Skapa en kickstart-fil

[ReadTheDocs](https://pykickstart.readthedocs.io/en/latest/kickstart-docs.html#kickstart-documentation)

Exempelfil:

```ini
# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8

%packages
@^server-product-environment
@container-management
@domain-client
@guest-agents
@headless-management

%end

# Run the Setup Agent on first boot
firstboot --enable

# Generated using Blivet version 3.11.0
ignoredisk --only-use=sda
# Partition clearing information
clearpart --none --initlabel
# Disk partitioning information
# Set to make /var lvm partition around 8g and give the remaining size to / by specifying --grow
part /boot/efi --fstype="efi" --ondisk=sda --size=1024 --fsoptions="umask=0077,shortname=winnt"
part pv.728 --fstype="lvmpv" --ondisk=sda --size=15550 --grow
part /boot --fstype="xfs" --ondisk=sda --size=1024
volgroup fedora --pesize=4096 pv.728
logvol /var --fstype="xfs" --size=8192 --name=var --vgname=fedora
logvol / --fstype="xfs" --size=1 --grow --name=root --vgname=fedora

# System timezone
timezone Europe/Stockholm

#Root password
rootpw --lock
user --groups=wheel --name=stagrim --password=$y$j9T$qQRdJRVu7/6iJ13d1l9xYMUk$4UPS6ncutshjhYo3f1h9qPDDrjYtMg.LcNV7y2nQTyB --iscrypted --gecos="Esbjörn Stenberg"
```

Exempel på kickstart-fil med inställningar som skapar en lvm partition för enkel partitionering senare. LVM-partitionen och den logiska volymen root ovanpå är satta att växa så mycket som möjligt med `--grow` baserat på hur stor disken som installeras är. /var är statiskt satt till runt 8GB. Om tillväxten föredras vara procentuell gentemot /var kan `--percent` användas tillsammans med `--grow`.

TODO: Lägg till ett post-script efter installationen som stänger av maskinen för att markera att installationen är färdig?

### Lösenordshash

För att skapa en egen lösenordshash kan `mkpasswd -m yescrypt` användas för att skapa en med ett slumpmässigt SALT.

## Använda kickstart-filen vid installation

[Guide följd](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/installation_guide/sect-kickstart-howto#sect-kickstart-installation-starting)

För att ge filen vid installation skapar vi en disk i oVirt på 1GiB. Fäst den sedan på en existerande vm. Formatera disken valfritt linux-kompatibelt format (rekommenderar ext4 eller xfs), och lägg kickstart filen direkt på disken med namnet `ks.cfg`. Mounta disken på valfri existerande VM och ge sedan partitionen beteckningen `OEMDRV` med kommandot `e2label /dev/sdb1 OEMDRV` där /dev/sdb1 ska bytas ut mot partitionen som kickstart-filen ligger på. Unmounta sedan disken. Med rätt beteckning och filnamn ska installern kunna hitta och använda filen utan att detta behöver specificeras med boot-inställningen `inst.ks=`. Se sedan till att disken är fäst på vm:en som ska installeras.

Ta sedan bort kickstart-disken från vm:en efter installationen.

## Hostname

För att kickstart-filen ska kunna vara generell så specifiseras inte hostname. Detta görs enklast efter installationen istället. Ssh:a med hjälp av ip (via hyacinth) eller remote-consol:a in på maskinen för att sätta valt hostname. (Automatisera i framtiden med hjälp av Cloud-init eller liknande?)