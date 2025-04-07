# Dethoven

| **🌐 URL** | <https://music.dsek.se/> |
|----|----|
| **💡 Purpose** | Spela musik i iDét |
| **👥 Stakeholders** | Sektionens funktionärer |
| **🏗️ Infrastructure** | [uffe](./../Infrastructure/Uffe.md) |
| **🔗 Dependencies** | [Keycloak](./Keycloak.md) |
| **🚦 Status** | !!active/maintenance/deprecated!! |
| **⚠️ Criticality** | low |
| **🗃️ Source** | [Steindt/musicserver](https://github.com/Steindt/musicserver) |


# How to change / set up user.


1. Give up and curse spotify :middle_finger:
2. Make sure you have a spotify premium account that is a [developer account](https://developer.spotify.com). (you just need the free version, and don't need to sign up for anything, just create one)
3. Create an app, fill in whatever username and description, and make sure the callbacks are the following:

   ```
   https://music.dsek.se/admin
   https://music.dsek.se/login/callback
   ```

   Make sure you use these two APIs:

   ```
   Web API
   Web Playback SDK
   ```
4. ssh into uffe.blossom and modify our web service to use your new client ID and secret (from your spotify app) by updating the fields .env.local file at `/home/ta7116st-s/Documents/musicserver/.env.local`.
5. Next is to turn off the librespot service by running `systemctl stop librespot`. Then run the following command as root:\n`/home/ta7116st-s/.cargo/bin/librespot --cache /home/ta7116st-s/.cache/librespot --enable-oauth --oauth-port 0`\nBrowse to the provided link on your own pc (copy and paste is your friend) and log in if required. Paste the return link back into the terminal and press enter.\nYou can then terminate the process (Ctrl+C works great), and start the service again by running `systemctl start librespot`.
6. Restart the music server by running `systemctl restart musicserver`. Note that this step might take a pretty good while.