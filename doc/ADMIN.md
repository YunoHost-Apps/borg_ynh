## Reminder regarding the passphrase

The passphrase is the only way to decrypt your backups. You should make sure to keep it safe in some place "outside" your server to cover the scenario where your server is destroyed for some reason.

## Testing that backup work as expected

At this step your backup should run at the scheduled time. Note that the first backup can take very long, as much data has to be copied through ssh. Following backups are incremental: only newly generated data since last backup will be copied.

If you want to test correct Borg Apps setup before scheduled time, you can start a backup manually from the command line:

```bash
systemctl start borg
```

Once the backup completes, you can check that a backup is listed in the webadmin > Applications > Borg > 'Last backups list'.

## Manually running `borg` commands

The config panel has a "Last backup list" that allow to have quick look at the recently created backup archives.

However, you may want to manually inspect that the backups are indeed made regularly and contain the expected content.

First, prepare the environment with the appropriate borg variables, etc:

```bash
app=borg
PATH="/var/www/$app/venv/bin/:$PATH"
export BORG_PASSPHRASE="$(sudo yunohost app setting $app passphrase)" 
export BORG_RSH="ssh -i /root/.ssh/id_${app}_ed25519 -oStrictHostKeyChecking=yes"
repository="$(sudo yunohost app setting $app repository)"
```

If additional options are needed, like the *remote path* to the borg
executable (see *Support for remote-path* bellow), set them as well:
```bash
if [[ ! -z "$(sudo yunohost app setting $app remote_path)" ]]; then
    export BORG_REMOTE_PATH="$(sudo yunohost app setting $app remote_path)"
fi
```

Then run for example:

- List archives: `borg list "$repository" | less`
- List files from a specific archive: `borg list "$repository::ARCHIVE_NAME" | less`
- View archive info: `borg info "$repository::ARCHIVE_NAME"`
- Verify data integrity: `borg check "$repository::ARCHIVE_NAME" --verify-data`

## Restoring archives from Borg

A borg "archive" can be exported to a `.tar` which can then be restored using the classic Yunohost backup restore workflow:

**NB: this command assumes that you prepared the environment just like in the previous section**

```bash
borg export-tar "$repository::ARCHIVE_NAME" /home/yunohost/archives/ARCHIVE_NAME.tar
```

Then restore using the classic workflow: 
- from the command line: `yunohost backup restore ARCHIVE_NAME`
- or in the webadmin > Backups

### Restoring the "source+config" of the app, and its data separately

For apps containing a large amount of data, restoring *everything* all at once is not practical because of the space and time it will take. Instead you may want to first restore the "core" (the source, configuration, etc) of the app, - and *then* the data.

First, borg can export a .tar archive but ignore the path corresponding to the app's data. For example, to export a tar archive for Nextcloud, but without its data:

```bash
borg export-tar --exclude apps/nextcloud/backup/home/yunohost.app "$repository::ARCHIVE_NAME" /home/yunohost.backup/archives/ARCHIVE_NAME.tar
yunohost backup restore ARCHIVE_NAME
```

Then extract Nextcloud's data directly into the right location, **without** going through the classic YunoHost backup restore process:

```bash
cd /home/yunohost.app/
borg extract "$repository::ARCHIVE_NAME" apps/nextcloud/backup/home/yunohost.app/
mv apps/nextcloud/backup/home/yunohost.app/nextcloud ./
rm -r apps
```

## Support for remote-path (custom borg executable on remote server)

In particular cases, one may need to specify a custom borg executable to be run on the remote server (borg supports this through the `--remote-path` commandline option / `BORG_REMOTE_PATH` env variable - see https://borgbackup.readthedocs.io/en/stable/usage/general.html ).

If needed, the path to the borg executable can be configured by setting its value in the optional *Remote borg command (remote-path)* entry of the configuration panel.

