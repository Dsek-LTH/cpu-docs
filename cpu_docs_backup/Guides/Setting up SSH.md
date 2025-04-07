# Setting up SSH

# **How to setup SSH**


:::info
Are you using Windows? Please stop (use WSL)!

:::


1. Create an SSH key.

   
   1. Begin by checking if you already have a key in the default location. By default the key will be named `id_rsa.pub`, `id_ecdsa.pub` or `id_ed25519.pub`.

      ```bash
      ls -la ~/.ssh
      ```
   2. If nothing shows up, create a new key pair as follows.

      ```bash
      ssh-keygen -t ed25519
      ```
2. Create an SSH config file. You might already have one.

   ```bash
   touch ~/.ssh/config
   ```
3. Open the config in an editor of your choice, e.g `nano`.

   ```bash
   nano ~/.ssh/config
   ```
4. Add the following lines. Replace `<username>` with your dsek.se username, e.g. `ad2313ad-s`.

   ```bash
   Host bifrost.blossom.dsek.se gjallarbron.blossom.dsek.se
       User <username>
       IdentityFile ~/.ssh/id_ed25519
   
   Host bifrost.blossom gjallarbron.blossom 
       HostName %h.dsek.se
       User <username>
       IdentityFile ~/.ssh/id_ed25519
   
   Host *.blossom !bifrost.blossom !gjallarbron.blossom
       HostName %h.dsek.se
       ProxyJump bifrost.blossom.dsek.se
       User <username>
       IdentityFile ~/.ssh/id_ed25519
   ```
   * `IdentityFile` points to your SSH private key. SSH probably already defaults to using your key.
   * `Host bifrost.blossom.dsek.se`
     * Connects you to this host using your username, e.g. `ad2313ad-s`.
   * `Host *.blossom` 
     * Rewrites hostnames such as `wiki.blossom` to `wiki.blossom.dsek.se`
     * Adds an SSH proxy jump so you connect through bifrost
     * Connects you to this host using your username, e.g. `ad2313ad-s`.
5. Upload the SSH key to [FreeIPA](./../Reference/Services/FreeIPA.md).

   
   1. Go to <https://ipa.dsek.se/>. Ignore all the warnings and popups.
   2. Log in with your dsek.se username.
   3. Add a new key under `SSH public keys`.\nCopy the text in the public key you created earlier,  `id_ed25519.pub`, and paste it in the window that appears. Don't forget to scroll to the top of the site and ***save*** the changes.
      * Linux

        ```bash
        cat ~/.ssh/id_ed25519.pub
        # Then select and copy the contents of the id_ed25519.pub file
        # displayed in the terminal to your clipboard
        ```
      * Mac OS

        ```bash
        pbcopy < ~/.ssh/id_ed25519.pub
        ```
      * WSL

        ```bash
        clip < ~/.ssh/id_ed25519.pub
        ```
6. Check if it worked by connecting to one of our (virtual) machines!

   ```javascript
   ssh dwiki.blossom
   ```