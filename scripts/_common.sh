#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================
# App package root directory should be the parent folder
PKG_DIR=$(cd ../; pwd)

pkg_dependencies="python3-pip python3-dev libacl1-dev libssl-dev liblz4-dev python3-jinja2 python3-setuptools python-virtualenv virtualenv"

# Install borg with pip if borg is not here
install_borg_with_pip () {
    if [ ! -d /opt/borg-env ]; then
        virtualenv --python=python3 /opt/borg-env
        /opt/borg-env/bin/python /opt/borg-env/bin/pip install borgbackup==1.1.13
        echo "#!/bin/bash
    /opt/borg-env/bin/python /opt/borg-env/bin/borg \"\$@\"" > /usr/local/bin/borg
        chmod u+x /usr/local/bin/borg
    fi
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
        ynh_app_setting_set $app $setting_var ${!var}
    done
}



ynh_configure () {
    ynh_backup_if_checksum_is_different $2
    ynh_render_template "${PKG_DIR}/conf/$1.j2" "$2"
    ynh_store_file_checksum $2
}



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



ynh_debian_release () {
	lsb_release --codename --short
}

is_buster () {
	if [ "$(ynh_debian_release)" == "buster" ]
	then
		return 0
	else
		return 1
	fi
}

is_stretch () {
	if [ "$(ynh_debian_release)" == "stretch" ]
	then
		return 0
	else
		return 1
	fi
}

is_jessie () {
	if [ "$(ynh_debian_release)" == "jessie" ]
	then
		return 0
	else
		return 1
	fi
}
