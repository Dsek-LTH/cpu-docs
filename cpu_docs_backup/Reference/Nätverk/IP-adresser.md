# IP-adresser

## VLANs

| VLAN-id | Namn | Användning |
|----|----|----|
| 7 | IoT | Mojtar, saker på rootnet |
| 21 | Nat | VMs |
| 88 | Geekend | Geekend-nätverk, för portar i iDét.main() |
| 137 | Blossom | Fysiska maskiner |
| 90 | Switchar | (Ej sammankopplade) Anslutning till switch för management |
| 156 | Files | (Ej kopplat till router) Fildelning mellan noder över nfs |

## IP-ranges med betydelse

| VLAN-id | Range | Användning |
|----|----|----|
| 21 | 150-159 | Databas-servrar |
| 21 | 160-162 | Tids-servrar |
| 21 | 10-20 | Loadbalancers |
| 21 | 50-60 | Build-machines |
| 21 | 100-120 | Utility |

## IP-adresser i användning

Se `machines.yml` filen.

Vi har fått en allokering av IP-adresser från LU. Default gateway är 194.47.245.193. För våra publika IP-adresser gäller nedanstående

| IP | Nuvarande användning | .dsek.lth.se | Föreslagna nya dns records |
|----|----|----|----|
| 194.47.245.194 | bifrost | d001b-gw-190 | beehive |
| 194.47.245.195 | gjallarbron | d002b-gw-190 | pando |
| 194.47.245.196 | violet | rudolph | bifrost |
| 194.47.245.197 | N/A | 197 | gjallarbron |
| 194.47.245.198 | N/A | badgerbadger | badger |
| 194.47.245.199 | snejk.dsek.se | snejk | snejk |
| 194.47.245.200 | N/A | geekend | amaranth |
| 194.47.245.201 | N/A | trevor | primrose |
| 194.47.245.202 | N/A | mushroom | hyacinth |
| 194.47.245.203 | hyacinth | bajs | lavender |
| 194.47.245.204 | lavender (smtp2) | leatherwhip | magnolia |
| 194.47.245.205 | nightshade | argh | nightshade |
| 194.47.245.206 | lupine | itsa | lupine |
| 194.47.245.207 | pando | beans | waterlilly |
| 194.47.245.208 | waterlily | darwin | 208 |
| 194.47.245.209 | magnolia | sparky | 209 |
| 194.47.245.210 | N/A | sipper | 210 |
| 194.47.245.211 | N/A | portal | 211 |
| 194.47.245.212 | amaranth | 212 | 212 |
| 194.47.245.213 | primrose + gateway | 213 | 213 |


För filnätet gäller nedanstående.

| IP | Namn |
|----|----|
| 192.168.156.1 | pando |
| 192.168.156.2 | lavender |
| 192.168.156.3 | primrose |
| 192.168.156.4 | amaranth |
| 192.168.156.5 | magnolia |
| 192.168.156.6 | nightshade |
| 192.168.156.7 | lupine |
| 192.168.156.8 | waterlily |


\