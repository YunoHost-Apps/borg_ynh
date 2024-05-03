## Testing that backup work as expected

At this step your backup should run at the scheduled time. Note that the first backup can take very long, as much data has to be copied through ssh. Following backups are incremental: only newly generated data since last backup will be copied.

If you want to test correct Borg Apps setup before scheduled time, you can start a backup manually from the command line:

```bash
systemctl start borg
```

Once the backup completes, you can check that a backup is listed in the webadmin > Applications > Borg > 'Last backups list'.

## Check regularly your backup

If you want to be sure to be able to restore your server, you should try to restore regularly the archives. But this process is quite time consumming.

You should at least:

* Keep your apps up to date (if apps are too old, they could be difficult to restore on a more recent recent version)
* Check regularly the presence of `info.json` and `db.sql` or `dump.sql` in your apps archives

```bash
borg list ./::ARCHIVE_NAME | grep info.json
borg list ./::ARCHIVE_NAME | grep db.sql
borg list ./::ARCHIVE_NAME | grep dump.sql
```

* Be sure to have your passphrase available even if your server is completely broken




## How to restore a complete system

*For infos on restoring process, check [this yunohost forum thread](https://forum.yunohost.org/t/restoring-whole-yunohost-from-borg-backups/12705/3) and [that one](https://forum.yunohost.org/t/how-to-properly-backup-and-restore/12583/3), also [using Borg with sshkeys](https://thisiscasperslife.wordpress.com/2017/11/28/using-borg-backup-across-ssh-with-sshkeys/), the [`borg extract` documentation](https://borgbackup.readthedocs.io/en/stable/usage/extract.html), and this [general tutorial on Borg Backup](https://practical-admin.com/blog/backups-using-borg/).*

In the following explanations:

* the server to backup/restore will be called: `yuno`
* the remote server that receives and store the back will be called: `rem`
* `rem` is accessible at the domain `rem.tld`
* the remote user on `rem` which owns the Borg backups will be called `yurem`
* backup files will be stored in `rem` in the directory: `/home/yurem/backup`

### Overview

If you need to restore a whole yunohost system:

1. Setup a new Debian system
2. Install YunoHost the usual way
3. Go through YunoHost's postinstall (parameters you will supply are not crucial, as they will be replaced by the restore)
4. Install Borg
5. Setup `rem` to accept ssh connections from `yuno`
6. Use Borg to import backups from `rem` to `yuno`
7. Restore Borg backups with the `yunohost backup restore` command, first config, then data, then each app one at a time
8. Remove the Borg app and restore it

### Make it possible for `yuno` to connect to `rem` with Borg

At this stage, we will assume that `yuno` is a freshly installed YunoHost (based on Buster in my case). You should also have performed the YunoHost postinstall.

If you don't want to restore the whole system, just some apps, you can skip some of the steps below.

#### Install the Borg YunoHost app in `yuno`

The idea here is just to install Borg, not in order to create backups, but only to use Borg commands to import remote backups.

So for example, you can install it doing the following:

```bash
sudo yunohost app install borg -a "server=rem.tld&ssh_user=yurem&conf=0&data=0&apps=hextris&on_calendar=2:30"
```

#### Make sure that `rem` accepts ssh connections from `yuno`

In `yuno` you will need to get the ssh key that borg just created while installing: `sudo cat /root/.ssh/id_borg_ed25519.pub`, copy it to clipboard.

Connect via ssh to `rem`, go to `/home/yurem/.ssh/authorized_keys`, and past the Borg public key you got at previous step.

Now to make sure this worked, you can try to SSH from `yuno` to `rem`.
In `yuno` : `ssh -i /root/.ssh/id_borg_ed25519 yurem@rem.tld` . If you can get into `rem` , without it prompting for a password, then you're good to continue :)

### Restore backups to `yuno`

⚠️ For the commands in the following section to work, you will need to be root in `yuno` (you can become root running `sudo su`).

⚠️ Restoration of backups can take quite a while, you'd better do them in a separate process, so that it doesn't stop if your terminal session gets closed. For this, you can for example use [tmux](https://www.howtogeek.com/671422/how-to-use-tmux-on-linux-and-why-its-better-than-screen/).

In `yuno` now, you should be able to list backups in `rem` with the following command:

```bash
SRV=yurem@rem.tld:/home/yurem/backup
BORG_RSH="ssh -i /root/.ssh/id_borg_ed25519 -oStrictHostKeyChecking=yes " borg list $SRV
```

You can then reimport one to `yuno` with:

```bash
BORG_RSH="ssh -i /root/.ssh/id_borg_ed25519 -oStrictHostKeyChecking=yes " borg export-tar $SRV::auto_BACKUP_NAME /home/yunohost.backup/archives/auto_BACKUP_NAME.tar.gz
```

And then restore the archive in `yuno` with:

```bash
yunohost backup restore auto_BACKUP_NAME --system # for config and data backups
yunohost backup restore auto_BACKUP_NAME --apps # for other backups (=apps)
```

### And Nextcloud? It's super heavy!!

For Nextcloud, the best is probably to reimport the backup without the data. And to import the data manually.

For that, you can do the following (as root):

```bash
SRV=yurem@rem.tld:/home/yurem/backup

# export the app without data
BORG_RSH="ssh -i /root/.ssh/id_borg_ed25519 -oStrictHostKeyChecking=yes " borg export-tar -e apps/nextcloud/backup/home/yunohost.app $SRV::auto_nextcloud_XX_XX_XX_XX:XX /home/yunohost.backup/archives/auto_nextcloud_XX_XX_XX_XX:XX.tar.gz

# extract the data from the backup to the nextcloud folder
cd /home/yunohost.app/nextcloud
BORG_RSH="ssh -i /root/.ssh/id_borg_ed25519 -oStrictHostKeyChecking=yes " borg extract $SRV::auto_nextcloud_XX_XX_XX_XX:XX apps/nextcloud/backup/home/yunohost.app/nextcloud/
mv apps/nextcloud/backup/home/yunohost.app/nextcloud/data data
rm -r apps

# now you can simply restore nextcloud app
yunohost backup restore auto_nextcloud_XX_XX_XX_XX:XX --apps
```

### Restore Borg

Once you've restored the whole system, you will probably want to restore the Borg app as well.

For that, remove the "dummy" Borg you installed to do the restoration, and restore Borg the same ways as for other apps:

```bash
sudo yunohost app remove borg
sudo yunohost backup restore auto_borg_XX_XX_XX_XX:XX --apps
```
