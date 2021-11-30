#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================
# App package root directory should be the parent folder
PKG_DIR=$(cd ../; pwd)
BORG_VERSION=1.1.16

pkg_dependencies="python3-pip python3-dev libacl1-dev libssl-dev liblz4-dev python3-jinja2 python3-setuptools python3-venv virtualenv libfuse-dev pkg-config"

# Install borg with pip if borg is not here
install_borg_with_pip () {
    if [ -d /opt/borg-env ]; then
        /opt/borg-env/bin/python /opt/borg-env/bin/pip list | grep "borgbackup *$BORG_VERSION" || ynh_secure_remove /opt/borg-env
    fi
    if [ ! -d /opt/borg-env ]; then
        python3 -m venv /opt/borg-env
        /opt/borg-env/bin/python /opt/borg-env/bin/pip install pip -U
	/opt/borg-env/bin/python /opt/borg-env/bin/pip install setuptools -U
        /opt/borg-env/bin/python /opt/borg-env/bin/pip install wheel
        ynh_print_info --message="Installing/compiling borg, this may take some time..."
        /opt/borg-env/bin/python /opt/borg-env/bin/pip install borgbackup[fuse]==$BORG_VERSION
        echo "#!/bin/bash
    /opt/borg-env/bin/python /opt/borg-env/bin/borg \"\$@\"" > /usr/local/bin/borg
        touch "/opt/borg-env/$(ynh_get_debian_release)"
    fi
    # We need this to be executable by other borg apps
    chmod a+x /usr/local/bin/borg
}

#=================================================
# COMMON HELPERS
#=================================================
ynh_export () {
    local ynh_arg=""
    for var in $@;
    do
        ynh_arg=$(echo $var | awk '{print toupper($0)}')
        if [ "$var" == "path_url" ]; then
            ynh_arg="PATH"
        fi
        ynh_arg="YNH_APP_ARG_$ynh_arg"
        export $var="${!ynh_arg}"
    done
}
# Save listed var in YunoHost app settings 
# usage: ynh_save_args VARNAME1 [VARNAME2 [...]]
ynh_save_args () {
    for var in $@;
    do
        local setting_var="$var"
        if [ "$var" == "path_url" ]; then
            setting_var="path"
        fi
        ynh_app_setting_set $app $setting_var "${!var}"
    done
}

# Need also the helper https://github.com/YunoHost-Apps/Experimental_helpers/blob/master/ynh_handle_getopts_args/ynh_handle_getopts_args

# Send an email to inform the administrator
#
# usage: ynh_send_readme_to_admin app_message [recipients]
# | arg: -m --app_message= - The message to send to the administrator.
# | arg: -r, --recipients= - The recipients of this email. Use spaces to separate multiples recipients. - default: root
#	example: "root admin@domain"
#	If you give the name of a YunoHost user, ynh_send_readme_to_admin will find its email adress for you
#	example: "root admin@domain user1 user2"

# Send an email to inform the administrator
#
# usage: ynh_send_readme_to_admin app_message [recipients]
# | arg: app_message - The message to send to the administrator.
# | arg: recipients - The recipients of this email. Use spaces to separate multiples recipients. - default: root
#	example: "root admin@domain"
#	If you give the name of a YunoHost user, ynh_send_readme_to_admin will find its email adress for you
#	example: "root admin@domain user1 user2"
ynh_send_readme_to_admin() {
	local app_message="${1:-...No specific information...}"
	local recipients="${2:-root}"

	# Retrieve the email of users
	find_mails () {
		local list_mails="$1"
		local mail
		local recipients=" "
		# Read each mail in argument
		for mail in $list_mails
		do
			# Keep root or a real email address as it is
			if [ "$mail" = "root" ] || echo "$mail" | grep --quiet "@"
			then
				recipients="$recipients $mail"
			else
				# But replace an user name without a domain after by its email
				if mail=$(ynh_user_get_info "$mail" "mail" 2> /dev/null)
				then
					recipients="$recipients $mail"
				fi
			fi
		done
		echo "$recipients"
	}
	recipients=$(find_mails "$recipients")

	local mail_subject="☁️🆈🅽🅷☁️: \`$app\` was just installed!"

	local mail_message="This is an automated message from your beloved YunoHost server.
Specific information for the application $app.
$app_message
---
Automatic diagnosis data from YunoHost
$(yunohost tools diagnosis | grep -B 100 "services:" | sed '/services:/d')"

	# Define binary to use for mail command
	if [ -e /usr/bin/bsd-mailx ]
	then
		local mail_bin=/usr/bin/bsd-mailx
	else
		local mail_bin=/usr/bin/mail.mailutils
	fi

	# Send the email to the recipients
	echo "$mail_message" | $mail_bin -a "Content-Type: text/plain; charset=UTF-8" -s "$mail_subject" "$recipients"
}
