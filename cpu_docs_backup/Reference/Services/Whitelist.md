# Whitelist

| **🌐 URL** | whitelist.dsek.se |
|----|----|
| **💡 Purpose** | whitelist handler for minecraft server |
| **👥 Stakeholders** | Guild members of D and F |
| **🏗️ Infrastructure** | [magnolia](https://cpu.dsek.se./../Infrastructure/Blossom/Magnolia.md).blossom |
| **🔗 Dependencies** | [Minecraft](https://cpu.dsek.se./Minecraft.md) [Keycloak](https://cpu.dsek.se./Keycloak.md) |
| **🚦 Status** | active |
| **⚠️ Criticality** | low |
| **🗃️ Source** | <https://github.com/Dsek-LTH/whitelist> |


Whitelist is a svelte based website that allows users to log in with the D-sek accounts and add themselves to the whitelist. Further information can be found in the `/srv/whitelist`. The script to sync the whitelist to the server is located in `/srv/whitelist/copyoutfile.sh`. This command is run through the **minecraft** user's crontab (located at `/var/spool/cron/minecraft`).