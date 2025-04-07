# Hugo

Matrix display hanging above the entrance to Shäraton. Pronounced "y'gå". Is powered by a Raspberry Pi which interfaces with it. Currently runs Game of Life, but has an interface for sending HTTP requests with text.

OS is Raspian. Login information found in [Syspass](https://cpu.dsek.se./../../Services/Syspass.md) under "IoT pis".

On Hugo there is a service called \`hugo-udp\` that is for sending messages to display on the screen. As far as I (@[Tomas Kamsäter](mention://195987c8-3016-4395-b4fe-6739e37b9c54/user/801cb204-c121-4af8-9d54-a1ed93f21a06)) am aware, this functionality is broken and I have turned it off on 31/3-25.

There is an application called life (located in the home directory of the pi user). This application is currently running in a tmux instance (which can be accessed by running `tmux a` asd the pi user). In order to detach from this instance once attached use the tmux command \[ctrl+b\] + d.