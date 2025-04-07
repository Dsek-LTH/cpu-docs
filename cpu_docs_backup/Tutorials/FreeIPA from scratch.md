# FreeIPA from scratch

:::info
This tutorial is a work in progress! In the meantime you might want to check out the [SSSD documentation](https://sssd.io/docs/introduction.html) for a good overview of the [architecture](https://sssd.io/docs/architecture.html).

:::

# Introduction

We rely heavily on FreeIPA for managing our users and access to our (virtual) machines. FreeIPA is essentially a wrapper for lots of underlying projects, most relevant of which for our usage is [389 Directory Server](https://www.port389.org/), [SSSD](https://sssd.io/i), and [MIT Kerberos](https://web.mit.edu/kerberos/).

In this tutorial we will build the essential components of FreeIPA from scratch. This includes a directory server and a client application for controlling access to hosts. Along the way will encounter the overall architecture of FreeIPA and build an understanding of how it works under the hood.

# Table of contents

* Directory server

  
  1. CRUD users
  2. LDAP server
  3. User SSH keys
  4. User `sudoer` permission
* Client application

  
  1. Fetch users from directory server
  2. Fetch SSH keys using `AuthorizedKeysCommand`
  3. Set up `sudoers.ldap`
  * Extra: Cache locally
* Point out comparison to FreeIPA services where applicable:
  * 389 Directory Server
  * SSSD
  * Kerberos