# Details about the backup process

This aims at documenting how backups happen, in order to help people
understand, and maybe trust the process, or troubleshoot in case of
issues.

The general YNH backup process is described in
https://doc.yunohost.org/en/backup .

What this **borg_ynh** app provides, is the integration of borg as a
"custom backup method" in way YNH [describes
it](https://doc.yunohost.org/en/backup/custom_backup_methods).

That backup method corresponds to a particular `backup_method` hook script
(see [`backup_method` hook
docs](https://doc.yunohost.org/en/packaging_apps_hooks#backup-method)
installed in
`/etc/yunohost/hooks.d/backup_method/05-borg_app`

That's the script which runs borg commands, like `borg create`, `borg
prune`, etc. (see the source in [conf/backup_method](/conf/backup_method)).

Note that the `borg` executable isn't installed through the standard
`borgbackup` Debian package, but from a Python venv providing a
selected version from upstream Borg backup project (hence present docs
explaining how to manually run the borg command).

In order to automate backups, the borg_ynh app integrates with systemd
to provide scheduling, etc (check `systemctl status borg`).

The command which systemd executes, when it's backup time, is
`/usr/bin/sudo /var/www/borg/backup-with-borg borg`.

Finally, this `/var/www/borg/backup-with-borg` script
([source](/conf/backup-with-borg)) will invoke 
`yunohost backup create --method "borg_app"` according to the borg_ynh 
settings, and notifies as needed.
