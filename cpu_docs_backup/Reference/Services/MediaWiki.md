# MediaWiki

| **🌐 URL** | [https://wiki.dsek.se](/doc/httpswikidsekse-0o9tkBAIhT) |
|----|----|
| **💡 Purpose** | Wiki för sektionens medlemmar |
| **👥 Stakeholders** | Sektionens medlemmar |
| **🏗️ Infrastructure** | dwiki.blossom |
| **🔗 Dependencies** | none |
| **🚦 Status** | active (unused) |
| **⚠️ Criticality** | low |
| **🗃️ Source** | <https://hub.docker.com/_/mediawiki> |

## About

The wiki consists of a [MediaWiki](https://mediawiki.org) instance containerized through Podman. (mediawiki-pod) The database is a MariaDB (MySQL-compatible) instance that runs in a separate container (mediawiki-database).

Authentication for users is handled through Keycloak, which is set up using the *OpenID Connect* extension for MediaWiki. Admin permissions are not synced, and is handled manually.

MediaWiki settings are located in `/srv/mediawiki/data/LocalSettings.php`. Since this is a php file, it gets cached and needs a restart of the web server (container) for it to be reloaded. (`systemctl restart mediawiki-pod`)

A system account with full privileges exists, but cannot be used without enabling local accounts first, otherwise the login page cannot be reached. This should not be left on, since it causes terrible UX. Local accounts are enabled using `$wgPluggableAuth_EnableLocalLogin` in `LocalSettings.php`. Account credentials are located ~~in Syspass.~~ (for now in `/srv/mediawiki/localcredentials.txt`.

File uploads are not yet working.

If a backup solution were to be set up, `/srv/mediawiki/data/db` and `/srv/mediawiki/data/images` contains all user-generated data.

## Todo

- [x] Fix uploads.
- [ ] Group syncing is possible through OpenID Connect, could be used to make dsek.cpu.utvcklare local administrators.
- [ ] Proper documentation and guiding on the wiki for end-users.