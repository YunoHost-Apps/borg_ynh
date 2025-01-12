<!--
Ohart ongi: README hau automatikoki sortu da <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>ri esker
EZ editatu eskuz.
-->

# Borg Backup YunoHost-erako

[![Integrazio maila](https://apps.yunohost.org/badge/integration/borg)](https://ci-apps.yunohost.org/ci/apps/borg/)
![Funtzionamendu egoera](https://apps.yunohost.org/badge/state/borg)
![Mantentze egoera](https://apps.yunohost.org/badge/maintained/borg)

[![Instalatu Borg Backup YunoHost-ekin](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=borg)

*[Irakurri README hau beste hizkuntzatan.](./ALL_README.md)*

> *Pakete honek Borg Backup YunoHost zerbitzari batean azkar eta zailtasunik gabe instalatzea ahalbidetzen dizu.*  
> *YunoHost ez baduzu, kontsultatu [gida](https://yunohost.org/install) nola instalatu ikasteko.*

## Aurreikuspena

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


**Paketatutako bertsioa:** 1.4.0~ynh3
## Dokumentazioa eta baliabideak

- Aplikazioaren webgune ofiziala: <https://www.borgbackup.org>
- Administratzaileen dokumentazio ofiziala: <https://borgbackup.readthedocs.io>
- Jatorrizko aplikazioaren kode-gordailua: <https://github.com/borgbackup/borg>
- YunoHost Denda: <https://apps.yunohost.org/app/borg>
- Eman errore baten berri: <https://github.com/YunoHost-Apps/borg_ynh/issues>

## Garatzaileentzako informazioa

Bidali `pull request`a [`testing` abarrera](https://github.com/YunoHost-Apps/borg_ynh/tree/testing).

`testing` abarra probatzeko, ondorengoa egin:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/borg_ynh/tree/testing --debug
edo
sudo yunohost app upgrade borg -u https://github.com/YunoHost-Apps/borg_ynh/tree/testing --debug
```

**Informazio gehiago aplikazioaren paketatzeari buruz:** <https://yunohost.org/packaging_apps>
