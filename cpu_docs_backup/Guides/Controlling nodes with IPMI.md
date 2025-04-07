# Controlling nodes with IPMI

1. SSH to any node that is connected to the files network (192.168.156.X). Probably pando.
2. `ipmitool -I lanplus -U ADMIN -P ADMIN -H 192.168.156.10X help` (replacing X with number of the node 1-8)

## Some common commands

`ipmitool -I lanplus -U ADMIN -P ADMIN -H 192.168.156.108 power status`


\

\