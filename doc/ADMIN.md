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

- Keep your apps up to date (if apps are too old, they could be difficult to restore on a more recent recent version)
- Check regularly the presence of `info.json` and `db.sql` or `dump.sql` in your apps archives

```bash
borg list ./::ARCHIVE_NAME | grep info.json
borg list ./::ARCHIVE_NAME | grep db.sql
borg list ./::ARCHIVE_NAME | grep dump.sql
```

- Be sure to have your passphrase available even if your server is completely broken
