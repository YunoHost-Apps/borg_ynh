## Allowing borg to connect to remote server via SSH

If you selected a remote borg server as backup target (*starting with `ssh://`*), borg will connect to it with SSH using a SSH public key that was generated for that purpose during this app installation.

In principle, you'll only need to provide that SSH public key to the remote server administrator so that remote backups can be performed.

### Installing "Borg server" on a remote yunohost server

Chances are you wish to use the "Borg server" app if the remote server runs Yunohost.

You should then install the "Borg Server" app there, with the following credentials (you may need to send this to your friend):

- Remote user: *the USER, as set in `ssh://USER@DOMAIN.TLD:PORT/~/backup`*
- SSH Public key: *as displayed in the config panel above*

Or directly using command line on the remote server:

`yunohost app install https://github.com/YunoHost-Apps/borgserver_ynh -a "ssh_user=USER&public_key=PUBLIC_KEY"`

NB: the SSH user is not meant to pre-exist on the server on which borgserver is installed!

### Configuring SSH access on other remote Borg servers

Alternatively, any remote Borg repository could be used, even if not running on yunohost, provided the local borg is able to connect via SSH.

You'll then need to make sure the corresponding SSH public key (*as displayed in the config panel above*) is installed on the remote account (adding this public key to `~USER/.ssh/authorized_keys` on the remote server).

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
