# Router (Beehive)

# Setup

## Återställning

För att ta bort all konfiguration, kör följande

```none
Beehive#delete nvram:startup-config       
Delete filename [startup-config]? 
Delete nvram:startup-config? [confirm]
Beehive#reload
Proceed with reload? [confirm]Connection to 192.168.7.246 closed by remote host.
Connection to 192.168.7.246 closed.
```

Non-volatile RAM innehåller startup-config. När vi tar bort den händer inget speciellt förrän vi startar om, då tas allt i (volatile) RAM bort.

## Komma åt routern (console)

Vi har en blå konsollsladd i lådan med `Cisco-kablar` som är USB-C till RJ45 (a.k.a. ethernet kabel). Den ska kopplas in till porten markerad `CON` (för console).

För att komma åt routern över sladden behöver vi hitta rätt USB-interface. I Linux kan man köra `ls /dev/tty* | grep -i usb` för att lista alla USB-relaterade devices.

Kör sedan t.ex. `screen /dev/ttyUSB0`, men ==detta behöver read-write access till device-noden==, så oftast kör man detta med `sudo`.

Man kan gå ut ur screen med `Ctrl-A + k` (kill).

# Konfigurering

## Manuell

Innan vi har ssh igång måste vi manuellt konfigurera några saker.

Om din prompt slutar med `>` är du i user mode, skriv `enable` för att gå in i privileged mode (kräver lösenord om det har konfigurerats).

För att börja konfigurera behöver du vara i configuration mode. Detta krävs för ssh:

```none
Router#configure terminal
Router(config)#hostname Beehive
Beehive(config)#ip route vrf Mgmt-intf 0.0.0.0 0.0.0.0 192.168.7.1 !TODO: ändra när hyacinth försvinner
Beehive(config)#interface GigabitEthernet0
Beehive(config-if)#ip address dhcp !TODO: ändra när routern är dhcp host
Beehive(config-if)#no ip redirects
Beehive(config-if)#no ip unreachables
Beehive(config-if)#no ip proxy-arp
Beehive(config-if)#no mop enabled 
Beehive(config-if)#no shutdown
Beehive(config-if)#exit
Beehive(config)#username admin privilege 15 secret <Password>
Beehive(config)#line vty 0 4
Beehive(config-line)#login local
Beehive(config-line)#transport input ssh
Beehive(config-line)#exit
Beehive(config)#ip domain name dsek.se
Beehive(config)#crypto key generate rsa
(välj 4096 bits)
Beehive(config)#end
Beehive#exit ! (du lär behöva Ctrl-a + k om du är i screen)
```

## Ansible

Nu när vi har fungerande ssh (se [SSH to beehive (future router)](./../../Guides/Setting%20up%20SSH/SSH%20to%20beehive%20(future%20router).md)) kan vi använda ansible

Klona repot `dumbo-m` och kör följande

`ansible-playbook -i ansible-scripts/inventory/ ansible-scripts/prepared_for_cisco_router/test_script.yml --ask-pass`