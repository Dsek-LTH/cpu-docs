# SSH to beehive (future router)

First set up your `.ssh/config` according to [Setting up SSH](./../Setting%20up%20SSH.md).

Add the following:

```javascript
Host beehive.blossom
    HostName 192.168.7.246
    User admin
    KexAlgorithms +diffie-hellman-group-exchange-sha1
    HostKeyAlgorithms ssh-rsa
    MACs hmac-sha1
    ProxyJump <username>@bifrost.blossom.dsek.se
```

Also make sure to add `!beehive.blossom` to the `Host *.blossom` line. You should now be able to run `ssh beehive.blossom`, however to login you need the enable password. That is currently in sysPass (at [pass.dsek.se](https://pass.dsek.se))


## Ansible

The cisco configuration in `dumbo-m` is on the `cisco` branch. To connect with ansible, make sure to use the above configuration and specify `--ask-pass`. A complete example would be to go to the top level directory in dumbo-m and run `ansible-playbook -i ansible-scripts/inventory/ ansible-scripts/prepared_for_cisco_router/ping.yml --ask-pass`.


### Ansible troubleshooting

* Error messages are very peculiar, and unfortunately we can't do a lot to fix it. 
* A common issue is that ssh times out. This is because of the ssh issues with hyacinth. If this happens, just try again.
* If you get this fallback error, install ansible-pylibssh. The ssh connection will not work without it![](uploads/801cb204-c121-4af8-9d54-a1ed93f21a06/247b6483-60fc-485b-b7ee-5f14eb70636f/image.png)