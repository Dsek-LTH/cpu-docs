# Mailsystemet

| **🌐 URL** | N/A |
|----|----|
| **💡 Purpose** | Postfix mail server |
| **👥 Stakeholders** | CPU, sektionens funktionärer och medlemmar, externa parter |
| **🏗️ Infrastructure** | mailmaster.blossom |
| **🔗 Dependencies** | [Web](./Web.md) |
| **🚦 Status** | active |
| **⚠️ Criticality** | high |
| **🗃️ Source** | !!repo!! |

### Postfix

```bash
# /etc/postfix/main.cf
### ALL NON-DEFAULT SETTINGS
append_at_myorigin = no
append_dot_mydomain = no
biff = no
bounce_template_file = /etc/postfix/bounce.cf
broken_sasl_auth_clients = yes
debugger_command = PATH=/bin:/usr/bin:/usr/local/bin; (strace -p $process_id 2>&1 | logger -p mail.info)
import_environment = KRB5_KTNAME=/etc/postfix/smtp.keytab
inet_protocols = ipv4
mailbox_size_limit = 999999999
mailq_path = /usr/bin/mailq.postfix
manpage_directory = /usr/share/man
message_size_limit = 256000000
milter_default_action = accept
mydestination = mailmaster.blossom.dsek.se # What domains to receive mail for
mydomain = localhost # My own domain name
myhostname = mailmaster.blossom.dsek.se # My own hostname
myorigin = dsek.se # What domain name to use in outbound mail
newaliases_path = /usr/bin/newaliases.postfix
non_smtpd_milters = $smtpd_milters
readme_directory = /usr/share/doc/postfix-2.10.1/README_FILES
recipient_canonical_maps = regexp:/etc/postfix/domain_rewrite
sample_directory = /usr/share/doc/postfix-2.10.1/samples
sendmail_path = /usr/sbin/sendmail.postfix

smtp_sasl_auth_enable = yes
smtp_sasl_mechanism_filter = gssapi, plain, login
smtpd_sasl_path = smtpd # default
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
smtp_sasl_tls_security_options = noanonymous
smtp_tls_cert_file = /etc/letsencrypt/live/mailmaster.blossom/fullchain.pem
smtp_tls_key_file = /etc/letsencrypt/live/mailmaster.blossom/privkey.pem
smtp_tls_loglevel = 1
smtp_tls_security_level = may
smtp_use_tls = yes
smtpd_client_restrictions = check_client_access hash:/etc/postfix/ban_list
smtpd_milters = inet:127.0.0.1:8891
smtpd_recipient_restrictions = permit_mynetworks, check_client_access hash:/etc/postfix/ban_list, permit_sasl_authenticated, reject_non_fqdn_sender, reject_non_fqdn_recipient reject_unauth_destination, reject_unknown_sender_domain, reject_unknown_recipient_domain, reject_unauth_pipelining, reject_unauth_destination
smtpd_relay_restrictions = permit_mynetworks, permit_sasl_authenticated, reject_authenticated_sender_login_mismatch, defer_unauth_destination
smtpd_sasl_auth_enable = yes
smtpd_sasl_authenticated_header = yes
smtpd_sender_login_maps = hash:/etc/postfix/authorized_senders
smtpd_sender_restrictions = reject_authenticated_sender_login_mismatch, reject_unlisted_sender, permit_sasl_authenticated, reject_unauth_destination
smtpd_tls_ask_ccert = yes
smtpd_tls_auth_only = yes
smtpd_tls_cert_file = /etc/letsencrypt/live/mailmaster.blossom/fullchain.pem
smtpd_tls_key_file = /etc/letsencrypt/live/mailmaster.blossom/privkey.pem
smtpd_tls_loglevel = 1
smtpd_tls_received_header = yes
smtpd_tls_security_level = may
smtpd_use_tls = yes

transport_maps = hash:/etc/postfix/transport_maps
virtual_alias_domains = dsek.se, snejk.dsek.lth.se, localhost.dsek.lth.se, dsek.lth.se, snejk.dsek.studorg.lu.se, dsek.studorg.lu.se, naringsliv.dsek.lth.se, dsek.se, naringsliv.dsek.se, localhost, nolla.nu, ge.mig.en.nolla.nu, ta.hand.om.en.nolla.nu, juble.se, mailmaster.dsek.se, teknikfokus.se
virtual_alias_maps = hash:/etc/postfix/virtual_aliases, hash:/etc/postfix/naringsliv_alias
```

```bash
# /etc/postfix/transport_maps
lu.se                   smtp:[smtp-relay.gmail.com]:587
.lu.se                  smtp:[smtp-relay.gmail.com]:587
lth.se                  smtp:[smtp-relay.gmail.com]:587
.lth.se                 smtp:[smtp-relay.gmail.com]:587
```

```bash
# /etc/postfix/bounce.cf
failure_template = <<EOF
Charset: us-ascii
From: system@dsek.se
Subject: Undelivered Mail Returned to Sender
Postmaster-Subject: Postmaster Copy: Undelivered Mail

This is the mail system at host dsek.se.

I'm sorry to have to inform you that your message could not be delivered to one or more recipients. It's attached below.

For further assistance, please send mail to root@dsek.se.

If you do so, please include this problem report. You can delete your own text from the attached returned message.

Regards,
The mail system
.
EOF
```

```bash
# /etc/postfix/sasl_passwd
[smtp-relay.gmail.com]:587 _postfixlthaccount@user.dsek.se:<redacted>
smtp-relay.gmail.com _postfixlthaccount@user.dsek.se:<redacted>
```

```bash
# /etc/sasl2/smtpd.conf
pwcheck_method: saslauthd
mech_list: PLAIN
log_level: 5
```

```bash
# Directory in which to place saslauthd's listening socket, pid file, and so
# on. This directory must already exist.
SOCKETDIR=/var/run/saslauthd

# Mechanism to use when checking passwords.  Run "saslauthd -v" to get a list
# of which mechanism your installation was compiled with the ablity to use.
MECH=pam

# Additional flags to pass to saslauthd on the command line.  See saslauthd(8)
# for the list of accepted flags.
FLAGS= -V

DAEMONOPTS=--user saslauth
```

```bash
# /etc/postfix/ban_list
91.240.118.159  REJECT STOP
62.127.187.26   REJECT
89.172.96.33    REJECT
89.172.98.14    REJECT
59.62.108.202 REJECT
prod.mesa1.secureserver.net     550 We do not accept mail from this host
*.icpbounce.com 550 Fuck off, spammers!
*.mtpk.ca.charter.com  REJECT
*.shodan.io REJECT
*.census.shodan.io REJECT
*.scanf.shodan.io REJECT
```

```bash
# /etc/postfix/authorized_senders
aktu@dsek.se ab1234cd-s, ef5678gh-s
root@dsek.se ij9123kl-s
....
```

```bash
# /etc/postfix/virtual_aliases
aktu@dsek.se adam.berta.1234@user.dsek.se, anna.axel.5678@user.dsek.se
root@dsek.se ada.lovelace.9123@user.dsek.se
....
```

```bash
#/etc/postfix/naringsliv_alias
naringsliv@dsek.se      naringsliv, naringsliv2019@gmail.com
```