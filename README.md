# borg_ynh
An experimental borg implementation for yunohost

## Usage
If you want to backup your server A onto the server B.

## Setup borg app on Server A
Firstly set up this app on the server A you want to backup:

```
$ yunohost app install https://github.com/YunoHost-Apps/borg_ynh
Indicate the server where you want put your backups: serverB.local
Indicate the ssh user to use to connect on this server: servera
Indicate a strong passphrase, that you will keep preciously if you want to be able to use your backups: N0tAW3akp4ssw0rdYoloMacN!guets
Would you like to backup your YunoHost configuration ? [0 | 1] (default: 1):
Would you like to backup mails and user home directory ? [0 | 1] (default: 1):
Which apps would you backup (list separated by comma or 'all') ? (default: all):
Indicate the backup frequency (see systemd OnCalendar format) (default: Daily):
```

You can schedule your backup by choosing an other frequency. Some example:

Monthly : 

Weekly : 

Daily : Daily at midnight

Hourly : Hourly o Clock

Sat *-*-1..7 18:00:00 : The first saturday of every month at 18:00

4:00 : Every day at 4 AM

5,17:00 : Every day at 5 AM and at 5 PM

See here for more info : https://wiki.archlinux.org/index.php/Systemd/Timers#Realtime_timer

At the end of the installation, the app display you the public_key and the user to give to the person who has access to the server B.
```
You should now install the "Borg Server" app on serverb.local and fill questions like this:
User: servera
Public key: ssh-ed25519 AAAA[...] root@servera.local
```

If you don't find the mail and you don't see the message in the log bar you can found the public_key with this command:
```
$ cat /root/.ssh/id_borg_ed25519.pub
ssh-ed25519 AAAA[...] root@servera.local
```

## Setup Borg Server app on Server B

```
$ yunohost app install https://github.com/YunoHost-Apps/borgserver_ynh
Indicate the ssh user to create: servera
Indicate the public key given by borg_ynh app: ssh-ed25519 AAAA[...] root@servera.local
```

## Test
At this step your backup should schedule.

If you want to be sure, you can test it by running on server A:
```
$ service borg start
```

Next you can check, your backup on server B
```
$ borg list /home/servera/backup
```

YOU SHOULD CHECK REGULARLY THAT YOUR BACKUP ARE STILL WORKING.

## Edit the apps list to backup

yunohost app setting borg apps -v "nextcloud,wordpress"

## Backup on different server, and apply distinct schedule for apps

You can setup the borg apps several times on the same server so you can backup on several server or manage your frequency backup differently for specific part of your server.
