<!--
Nota bene : ce README est automatiquement généré par <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
Il NE doit PAS être modifié à la main.
-->

# Borg Backup pour YunoHost

[![Niveau d’intégration](https://apps.yunohost.org/badge/integration/borg)](https://ci-apps.yunohost.org/ci/apps/borg/)
![Statut du fonctionnement](https://apps.yunohost.org/badge/state/borg)
![Statut de maintenance](https://apps.yunohost.org/badge/maintained/borg)

[![Installer Borg Backup avec YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=borg)

*[Lire le README dans d'autres langues.](./ALL_README.md)*

> *Ce package vous permet d’installer Borg Backup rapidement et simplement sur un serveur YunoHost.*  
> *Si vous n’avez pas YunoHost, consultez [ce guide](https://yunohost.org/install) pour savoir comment l’installer et en profiter.*

## Vue d’ensemble

A [Borg](https://borgbackup.readthedocs.io/en/stable/index.html#what-is-borgbackup) integration to backup your YunoHost server to another remote server (e.g. one of your friends).

This app is the "client" part, meant to be installed on the server to be backed up. It works in combination with the [borg server app](https://apps.yunohost.org/app/borgserver) installed on a diffent machine.

### Features

- Backup on a remote machine, in combination with the [borg server app](https://apps.yunohost.org/app/borgserver)
- ... or on a [commercial borg service](https://www.borgbackup.org/support/commercial.html)
- Backups are encrypted (the remote server can't read the content) and deduplicated (optimize space)
- Backups are ran automatically, you can choose when and at which frequency
- You can choose what apps are backed up
- Receive email alerts if the backup fails (the [borg server app](https://apps.yunohost.org/app/borgserver) also checks that new content arrives and send an email to your friend otherwise)

### Install procedure

Maybe counter-intuitively, you should *first* install this app (`borg_ynh`) and *then* (`borgserver_ynh`) on the other machine. In fact, at the end of the install of `borg_ynh`, you will be provided with the info, in particular the SSH public key, to be used to setup `borgserver_ynh` on the other machine.


**Version incluse :** 1.4.0~ynh1
## Documentations et ressources

- Site officiel de l’app : <https://www.borgbackup.org>
- Documentation officielle de l’admin : <https://borgbackup.readthedocs.io>
- Dépôt de code officiel de l’app : <https://github.com/borgbackup/borg>
- YunoHost Store : <https://apps.yunohost.org/app/borg>
- Signaler un bug : <https://github.com/YunoHost-Apps/borg_ynh/issues>

## Informations pour les développeurs

Merci de faire vos pull request sur la [branche `testing`](https://github.com/YunoHost-Apps/borg_ynh/tree/testing).

Pour essayer la branche `testing`, procédez comme suit :

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/borg_ynh/tree/testing --debug
ou
sudo yunohost app upgrade borg -u https://github.com/YunoHost-Apps/borg_ynh/tree/testing --debug
```

**Plus d’infos sur le packaging d’applications :** <https://yunohost.org/packaging_apps>
