<!--
NB: Deze README is automatisch gegenereerd door <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
Hij mag NIET handmatig aangepast worden.
-->

# Borg Backup voor Yunohost

[![Integratieniveau](https://dash.yunohost.org/integration/borg.svg)](https://ci-apps.yunohost.org/ci/apps/borg/) ![Mate van functioneren](https://ci-apps.yunohost.org/ci/badges/borg.status.svg) ![Onderhoudsstatus](https://ci-apps.yunohost.org/ci/badges/borg.maintain.svg)

[![Borg Backup met Yunohost installeren](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=borg)

*[Deze README in een andere taal lezen.](./ALL_README.md)*

> *Met dit pakket kun je Borg Backup snel en eenvoudig op een YunoHost-server installeren.*  
> *Als je nog geen YunoHost hebt, lees dan [de installatiehandleiding](https://yunohost.org/install), om te zien hoe je 'm installeert.*

## Overzicht

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


**Geleverde versie:** 1.4.0~ynh1
## Documentatie en bronnen

- Officiele website van de app: <https://www.borgbackup.org>
- Officiele beheerdersdocumentatie: <https://borgbackup.readthedocs.io>
- Upstream app codedepot: <https://github.com/borgbackup/borg>
- YunoHost-store: <https://apps.yunohost.org/app/borg>
- Meld een bug: <https://github.com/YunoHost-Apps/borg_ynh/issues>

## Ontwikkelaarsinformatie

Stuur je pull request alsjeblieft naar de [`testing`-branch](https://github.com/YunoHost-Apps/borg_ynh/tree/testing).

Om de `testing`-branch uit te proberen, ga als volgt te werk:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/borg_ynh/tree/testing --debug
of
sudo yunohost app upgrade borg -u https://github.com/YunoHost-Apps/borg_ynh/tree/testing --debug
```

**Verdere informatie over app-packaging:** <https://yunohost.org/packaging_apps>
