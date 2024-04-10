<!--
Ohart ongi: README hau automatikoki sortu da <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>ri esker
EZ editatu eskuz.
-->

# Borg Backup YunoHost-erako

[![Integrazio maila](https://dash.yunohost.org/integration/borg.svg)](https://dash.yunohost.org/appci/app/borg) ![Funtzionamendu egoera](https://ci-apps.yunohost.org/ci/badges/borg.status.svg) ![Mantentze egoera](https://ci-apps.yunohost.org/ci/badges/borg.maintain.svg)

[![Instalatu Borg Backup YunoHost-ekin](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=borg)

*[Irakurri README hau beste hizkuntzatan.](./ALL_README.md)*

> *Pakete honek Borg Backup YunoHost zerbitzari batean azkar eta zailtasunik gabe instalatzea ahalbidetzen dizu.*  
> *YunoHost ez baduzu, kontsultatu [gida](https://yunohost.org/install) nola instalatu ikasteko.*

## Aurreikuspena

A [Borg](https://borgbackup.readthedocs.io/en/stable/index.html#what-is-borgbackup) implementation to backup a YunoHost server.

This is the Borg Backup App to be installed on a server to backup. It works together with a [Borg Server App](https://github.com/YunoHost-Apps/borgserver_ynh) installed on a host server.


**Paketatutako bertsioa:** 1.2.8~ynh1
## Dokumentazioa eta baliabideak

- Aplikazioaren webgune ofiziala: <https://borgbackup.readthedocs.io>
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
