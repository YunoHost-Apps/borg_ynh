<!--
N.B.: README ini dibuat secara otomatis oleh <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
Ini TIDAK boleh diedit dengan tangan.
-->

# Borg Backup untuk YunoHost

[![Tingkat integrasi](https://dash.yunohost.org/integration/borg.svg)](https://ci-apps.yunohost.org/ci/apps/borg/) ![Status kerja](https://ci-apps.yunohost.org/ci/badges/borg.status.svg) ![Status pemeliharaan](https://ci-apps.yunohost.org/ci/badges/borg.maintain.svg)

[![Pasang Borg Backup dengan YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=borg)

*[Baca README ini dengan bahasa yang lain.](./ALL_README.md)*

> *Paket ini memperbolehkan Anda untuk memasang Borg Backup secara cepat dan mudah pada server YunoHost.*  
> *Bila Anda tidak mempunyai YunoHost, silakan berkonsultasi dengan [panduan](https://yunohost.org/install) untuk mempelajari bagaimana untuk memasangnya.*

## Ringkasan

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


**Versi terkirim:** 1.4.0~ynh1
## Dokumentasi dan sumber daya

- Website aplikasi resmi: <https://www.borgbackup.org>
- Dokumentasi admin resmi: <https://borgbackup.readthedocs.io>
- Depot kode aplikasi hulu: <https://github.com/borgbackup/borg>
- Gudang YunoHost: <https://apps.yunohost.org/app/borg>
- Laporkan bug: <https://github.com/YunoHost-Apps/borg_ynh/issues>

## Info developer

Silakan kirim pull request ke [`testing` branch](https://github.com/YunoHost-Apps/borg_ynh/tree/testing).

Untuk mencoba branch `testing`, silakan dilanjutkan seperti:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/borg_ynh/tree/testing --debug
atau
sudo yunohost app upgrade borg -u https://github.com/YunoHost-Apps/borg_ynh/tree/testing --debug
```

**Info lebih lanjut mengenai pemaketan aplikasi:** <https://yunohost.org/packaging_apps>
