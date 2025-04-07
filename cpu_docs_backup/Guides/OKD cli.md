# OKD cli

# Getting started


1. Download `openshift-console` tar archive from <https://github.com/okd-project/okd/releases> and extract it
2. Place `oc` and `kubectl` in a location that is in your `PATH`, for example `/usr/local/bin`
3. Authenticate the cli

   
   1. Go to the web console ([okd.dsek.se](https://okd.dsek.se/))
   2. Click your username in the top right corner, then click **Copy login command**
   3. Log in with **keycloak**
   4. Click **Display Token**
   5. Copy the command under **Log in with this token**
4. Test that it works with `oc whoami`

This gives you a time limited authentication token. When it expires, renew it by running `oc login --web`.