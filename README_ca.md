<!--
N.B.: Aquest README ha estat generat automàticament per <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
NO s'ha de modificar manualment.
-->

# Borg Backup per YunoHost

[![Nivell d'integració](https://apps.yunohost.org/badge/integration/borg)](https://ci-apps.yunohost.org/ci/apps/borg/)
![Estat de funcionament](https://apps.yunohost.org/badge/state/borg)
![Estat de manteniment](https://apps.yunohost.org/badge/maintained/borg)

[![Instal·la Borg Backup amb YunoHosth](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=borg)

*[Llegeix aquest README en altres idiomes.](./ALL_README.md)*

> *Aquest paquet et permet instal·lar Borg Backup de forma ràpida i senzilla en un servidor YunoHost.*  
> *Si no tens YunoHost, consulta [la guia](https://yunohost.org/install) per saber com instal·lar-lo.*

## Visió general

A [Borg](https://borgbackup.readthedocs.io/en/stable/index.html#what-is-borgbackup) integration to backup your YunoHost server to another remote server (e.g. one of your friends).

This app is the "client" part, meant to be installed on the server to be backed up. It works in combination with the [borg server app](https://apps.yunohost.org/app/borgserver) installed on a different machine running YunoHost, or another borg service reachable by SSH.

### Features

- Backup on a remote machine, in combination with the [borg server app](https://apps.yunohost.org/app/borgserver)
- ... or on a [commercial borg service](https://www.borgbackup.org/support/commercial.html)
- Backups are encrypted (the remote server can't read the content) and deduplicated (optimize space)
- Backups are run automatically, you can choose when and at which frequency
- You can choose what apps are backed up
- Receive email alerts if the backup fails (the [borg server app](https://apps.yunohost.org/app/borgserver) also checks that new content arrives and send an email to your friend otherwise)

### Install procedure

Maybe counter-intuitively, you should *first* install this app (`borg_ynh`) and *then* (`borgserver_ynh`) on the other machine. In fact, at the end of the install of `borg_ynh`, you will be provided with the info, in particular the SSH public key, to be used to setup `borgserver_ynh` on the other machine.


**Versió inclosa:** 1.4.0~ynh3
## Documentació i recursos

- Lloc web oficial de l'aplicació: <https://www.borgbackup.org>
- Documentació oficial per l'administrador: <https://borgbackup.readthedocs.io>
- Repositori oficial del codi de l'aplicació: <https://github.com/borgbackup/borg>
- Botiga YunoHost: <https://apps.yunohost.org/app/borg>
- Reportar un error: <https://github.com/YunoHost-Apps/borg_ynh/issues>

## Informació per a desenvolupadors

Envieu les pull request a la [branca `testing`](https://github.com/YunoHost-Apps/borg_ynh/tree/testing).

Per provar la branca `testing`, procedir com descrit a continuació:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/borg_ynh/tree/testing --debug
o
sudo yunohost app upgrade borg -u https://github.com/YunoHost-Apps/borg_ynh/tree/testing --debug
```

**Més informació sobre l'empaquetatge d'aplicacions:** <https://yunohost.org/packaging_apps>
