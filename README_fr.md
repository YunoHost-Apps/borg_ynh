<!--
Nota bene : ce README est automatiquement généré par <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
Il NE doit PAS être modifié à la main.
-->

# Borg Backup pour YunoHost

[![Niveau d’intégration](https://dash.yunohost.org/integration/borg.svg)](https://dash.yunohost.org/appci/app/borg) ![Statut du fonctionnement](https://ci-apps.yunohost.org/ci/badges/borg.status.svg) ![Statut de maintenance](https://ci-apps.yunohost.org/ci/badges/borg.maintain.svg)

[![Installer Borg Backup avec YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=borg)

*[Lire le README dans d'autres langues.](./ALL_README.md)*

> *Ce package vous permet d’installer Borg Backup rapidement et simplement sur un serveur YunoHost.*  
> *Si vous n’avez pas YunoHost, consultez [ce guide](https://yunohost.org/install) pour savoir comment l’installer et en profiter.*

## Vue d’ensemble

A [Borg](https://borgbackup.readthedocs.io/en/stable/index.html#what-is-borgbackup) implementation to backup a YunoHost server.

This is the Borg Backup App to be installed on a server to backup. It works together with a [Borg Server App](https://github.com/YunoHost-Apps/borgserver_ynh) installed on a host server.


**Version incluse :** 1.1.16~ynh30
## Documentations et ressources

- Site officiel de l’app : <https://borgbackup.readthedocs.io>
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
