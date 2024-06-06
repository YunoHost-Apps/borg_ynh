You should check out the admin documentation of this app after installation for more info!

If you selected a remote borg server as backup target, you should now install the "Borg Server" app on `__SERVER__` and with the following credentials (you may need to send this to your friend):

- User: `__SSH_USER__`
- Public key: `__PUBLIC_KEY__`

Or directly using command line:

`yunohost app install https://github.com/YunoHost-Apps/borgserver_ynh -a "ssh_user=__SSH_USER__&public_key=__PUBLIC_KEY__"`

NB: the SSH user is not meant to pre-exist on the server on which borgserver is installed!
