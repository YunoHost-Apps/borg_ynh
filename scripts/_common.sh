#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

#=================================================
# PERSONAL HELPERS
#=================================================

# Install borg with pip if borg is not here
install_borg_with_pip () {
    BORG_VERSION=$(ynh_app_upstream_version)

    if [ -d /opt/borg-env ]; then
        /opt/borg-env/bin/python /opt/borg-env/bin/pip list | grep "borgbackup *$BORG_VERSION" || ynh_secure_remove /opt/borg-env
    fi
    if [ ! -d /opt/borg-env ]; then
        python3 -m venv /opt/borg-env
        /opt/borg-env/bin/python /opt/borg-env/bin/pip install pip -U
        /opt/borg-env/bin/python /opt/borg-env/bin/pip install setuptools -U
        /opt/borg-env/bin/python /opt/borg-env/bin/pip install wheel -U
        ynh_print_info --message="Installing/compiling borg, this may take some time..."
        /opt/borg-env/bin/python /opt/borg-env/bin/pip install borgbackup[pyfuse3]==$BORG_VERSION
        echo "#!/bin/bash
    /opt/borg-env/bin/python /opt/borg-env/bin/borg \"\$@\"" > /usr/local/bin/borg
        touch "/opt/borg-env/$(ynh_get_debian_release)"
    fi
    # We need this to be executable by other borg apps
    chmod a+x /usr/local/bin/borg
}

_gen_and_save_public_key() {
    public_key=""

    if [[ -n "$server" ]]; then
        private_key="/root/.ssh/id_${app}_ed25519"
        if [ ! -f "$private_key" ]; then
            ssh-keygen -q -t ed25519 -N "" -f "$private_key"
        fi
        public_key=$(cat "$private_key.pub")
    fi

    ynh_app_setting_set --app="$app" --key=public_key --value="$public_key"
}

#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
