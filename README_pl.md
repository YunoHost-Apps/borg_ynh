<!--
To README zostało automatycznie wygenerowane przez <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
Nie powinno być ono edytowane ręcznie.
-->

# Borg Backup dla YunoHost

[![Poziom integracji](https://apps.yunohost.org/badge/integration/borg)](https://ci-apps.yunohost.org/ci/apps/borg/)
![Status działania](https://apps.yunohost.org/badge/state/borg)
![Status utrzymania](https://apps.yunohost.org/badge/maintained/borg)

[![Zainstaluj Borg Backup z YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=borg)

*[Przeczytaj plik README w innym języku.](./ALL_README.md)*

> *Ta aplikacja pozwala na szybką i prostą instalację Borg Backup na serwerze YunoHost.*  
> *Jeżeli nie masz YunoHost zapoznaj się z [poradnikiem](https://yunohost.org/install) instalacji.*

## Przegląd

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


**Dostarczona wersja:** 1.4.0~ynh2
## Dokumentacja i zasoby

- Oficjalna strona aplikacji: <https://www.borgbackup.org>
- Oficjalna dokumentacja dla administratora: <https://borgbackup.readthedocs.io>
- Repozytorium z kodem źródłowym: <https://github.com/borgbackup/borg>
- Sklep YunoHost: <https://apps.yunohost.org/app/borg>
- Zgłaszanie błędów: <https://github.com/YunoHost-Apps/borg_ynh/issues>

## Informacje od twórców

Wyślij swój pull request do [gałęzi `testing`](https://github.com/YunoHost-Apps/borg_ynh/tree/testing).

Aby wypróbować gałąź `testing` postępuj zgodnie z instrukcjami:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/borg_ynh/tree/testing --debug
lub
sudo yunohost app upgrade borg -u https://github.com/YunoHost-Apps/borg_ynh/tree/testing --debug
```

**Więcej informacji o tworzeniu paczek aplikacji:** <https://yunohost.org/packaging_apps>
