# Öppna portar

Jag har använt nmap för att kolla 7, 21, och 137 nätet 

tcp scan (03-03-2025)

```bash
$ nmap 192.168.7.0-255
Starting Nmap 7.95 ( https://nmap.org ) at 2025-03-03 21:08 CET
Nmap scan report for 192.168.7.1
Host is up (0.0037s latency).
Not shown: 991 closed tcp ports (conn-refused)
PORT     STATE    SERVICE
22/tcp   open     ssh
25/tcp   open     smtp
53/tcp   open     domain
80/tcp   open     http
111/tcp  open     rpcbind
6789/tcp open     ibm-db2-admin
7777/tcp filtered cbt
8080/tcp open     http-proxy
8443/tcp open     https-alt

Nmap scan report for boss.blossom.dsek.se (192.168.7.157)
Host is up (0.014s latency).
Not shown: 998 closed tcp ports (conn-refused)
PORT     STATE SERVICE
22/tcp   open  ssh
8080/tcp open  http-proxy

Nmap scan report for hugo.blossom.dsek.se (192.168.7.161)
Host is up (0.017s latency).
Not shown: 999 closed tcp ports (conn-refused)
PORT   STATE SERVICE
22/tcp open  ssh

Nmap scan report for screendump0.blossom.dsek.se (192.168.7.169)
Host is up (0.0071s latency).
Not shown: 998 closed tcp ports (conn-refused)
PORT     STATE SERVICE
22/tcp   open  ssh
3000/tcp open  ppp

Nmap scan report for sparkypie.blossom.dsek.se (192.168.7.198)
Host is up (0.0099s latency).
Not shown: 996 closed tcp ports (conn-refused)
PORT     STATE SERVICE
22/tcp   open  ssh
139/tcp  open  netbios-ssn
445/tcp  open  microsoft-ds
8000/tcp open  http-alt

Nmap scan report for 192.168.7.212
Host is up (0.0078s latency).
Not shown: 999 closed tcp ports (conn-refused)
PORT   STATE SERVICE
22/tcp open  ssh

Nmap scan report for pine.blossom.dsek.se (192.168.7.213)
Host is up (0.0078s latency).
Not shown: 999 closed tcp ports (conn-refused)
PORT   STATE SERVICE
22/tcp open  ssh

Nmap scan report for cone.blossom.dsek.se (192.168.7.224)
Host is up (0.0069s latency).
Not shown: 996 closed tcp ports (conn-refused)
PORT     STATE SERVICE
22/tcp   open  ssh
80/tcp   open  http
443/tcp  open  https
3000/tcp open  ppp

Nmap scan report for JuliasiPhone4S.blossom.dsek.se (192.168.7.227)
Host is up (0.0062s latency).
Not shown: 999 closed tcp ports (conn-refused)
PORT   STATE SERVICE
22/tcp open  ssh

Nmap scan report for screendump1.blossom.dsek.se (192.168.7.236)
Host is up (0.0072s latency).
Not shown: 999 closed tcp ports (conn-refused)
PORT   STATE SERVICE
22/tcp open  ssh

Nmap scan report for blajt.blossom.dsek.se (192.168.7.241)
Host is up (0.035s latency).
Not shown: 998 closed tcp ports (conn-refused)
PORT     STATE SERVICE
22/tcp   open  ssh
8080/tcp open  http-proxy

Nmap scan report for screendump2.blossom.dsek.se (192.168.7.242)
Host is up (0.0065s latency).
Not shown: 999 closed tcp ports (conn-refused)
PORT   STATE SERVICE
22/tcp open  ssh

Nmap done: 256 IP addresses (14 hosts up) scanned in 5.56 seconds

$ nmap 192.168.137.0-255
Starting Nmap 7.95 ( https://nmap.org ) at 2025-03-03 21:10 CET
Nmap scan report for hyacinth.blossom.dsek.se (192.168.137.129)
Host is up (0.0046s latency).
Not shown: 991 closed tcp ports (conn-refused)
PORT     STATE    SERVICE
22/tcp   open     ssh
25/tcp   open     smtp
53/tcp   open     domain
80/tcp   open     http
111/tcp  open     rpcbind
6789/tcp open     ibm-db2-admin
7777/tcp filtered cbt
8080/tcp open     http-proxy
8443/tcp open     https-alt

Nmap scan report for 192.168.137.163
Host is up (0.0046s latency).
Not shown: 994 filtered tcp ports (no-response)
PORT    STATE  SERVICE
80/tcp  open   http
88/tcp  closed kerberos-sec
389/tcp closed ldap
443/tcp open   https
464/tcp closed kpasswd5
636/tcp closed ldapssl

Nmap scan report for snejk (192.168.137.179)
Host is up (0.0040s latency).
Not shown: 994 filtered tcp ports (no-response)
PORT    STATE  SERVICE
80/tcp  open   http
88/tcp  closed kerberos-sec
389/tcp closed ldap
443/tcp open   https
464/tcp closed kpasswd5
636/tcp closed ldapssl

Nmap scan report for dimman.blossom.dsek.se (192.168.137.180)
Host is up (0.0048s latency).
Not shown: 998 filtered tcp ports (no-response)
PORT    STATE SERVICE
80/tcp  open  http
443/tcp open  https

Nmap scan report for 192.168.137.198
Host is up (0.0031s latency).
Not shown: 994 filtered tcp ports (no-response)
PORT    STATE  SERVICE
80/tcp  open   http
88/tcp  closed kerberos-sec
389/tcp closed ldap
443/tcp open   https
464/tcp closed kpasswd5
636/tcp closed ldapssl

Nmap scan report for waterlily.blossom.dsek.se (192.168.137.208)
Host is up (0.0034s latency).
Not shown: 994 filtered tcp ports (no-response)
PORT    STATE  SERVICE
80/tcp  open   http
88/tcp  closed kerberos-sec
389/tcp closed ldap
443/tcp open   https
464/tcp closed kpasswd5
636/tcp closed ldapssl

Nmap done: 256 IP addresses (6 hosts up) scanned in 33.32 seconds

$ nmap 192.168.21.0-255
Starting Nmap 7.95 ( https://nmap.org ) at 2025-03-03 21:12 CET
Nmap scan report for 192.168.21.1
Host is up (0.0039s latency).
Not shown: 991 closed tcp ports (conn-refused)
PORT     STATE    SERVICE
22/tcp   open     ssh
25/tcp   open     smtp
53/tcp   open     domain
80/tcp   open     http
111/tcp  open     rpcbind
6789/tcp open     ibm-db2-admin
7777/tcp filtered cbt
8080/tcp open     http-proxy
8443/tcp open     https-alt

Nmap scan report for ipa.dsek.se (192.168.21.105)
Host is up (0.0043s latency).
Not shown: 994 filtered tcp ports (no-response)
PORT    STATE SERVICE
80/tcp  open  http
88/tcp  open  kerberos-sec
389/tcp open  ldap
443/tcp open  https
464/tcp open  kpasswd5
636/tcp open  ldapssl

Nmap scan report for docker (192.168.21.205)
Host is up (0.0039s latency).
Not shown: 994 closed tcp ports (conn-refused)
PORT     STATE    SERVICE
22/tcp   open     ssh
80/tcp   open     http
111/tcp  open     rpcbind
443/tcp  open     https
7777/tcp filtered cbt
8008/tcp open     http

Nmap scan report for buildserver (192.168.21.207)
Host is up (0.0034s latency).
Not shown: 977 filtered tcp ports (no-response), 11 filtered tcp ports (host-unreach)
PORT      STATE SERVICE
22/tcp    open  ssh
80/tcp    open  http
443/tcp   open  https
3000/tcp  open  ppp
4000/tcp  open  remoteanything
5000/tcp  open  upnp
5050/tcp  open  mmcc
5432/tcp  open  postgresql
8080/tcp  open  http-proxy
8083/tcp  open  us-srv
9000/tcp  open  cslistener
50000/tcp open  ibm-db2

Nmap done: 256 IP addresses (4 hosts up) scanned in 10.81 seconds
```


## UDP

man ska kunna skanna efter UDP-portar med `nmap -sU <target>`, men det verkar ta mer tid. Vi får undersöka om det är värt att skanna alla 3 subnet. (kolla hur lång en enda adress tar, multiplicera med 762)