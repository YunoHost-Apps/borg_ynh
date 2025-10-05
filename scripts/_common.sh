#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

private_key_filename="id_${app}_ed25519"
public_key_filename="id_${app}_ed25519.pub"

#=================================================
# PERSONAL HELPERS
#=================================================

install_borg_with_pip () {
    ynh_exec_as "$app" python3 -m venv --upgrade "$install_dir/venv"
    venvpy="$install_dir/venv/bin/python3"

    ynh_exec_as "$app" "$venvpy" -m pip install --upgrade setuptools wheel
    BORG_VERSION=$(ynh_app_upstream_version)
    ynh_exec_as "$app" "$venvpy" -m pip install borgbackup[pyfuse3]=="$BORG_VERSION"
}

make_ssh_dir() {
    install -o $app -g $app -m 0700 -d "$data_dir/.ssh"
}

_gen_and_save_public_key() {
    public_key=""

    if [[ -n "$server" ]]; then
        make_ssh_dir
        private_key="$data_dir/.ssh/$private_key_filename"
        if [ ! -f "$private_key" ]; then
            ynh_exec_as "$app" ssh-keygen -q -t ed25519 -N "" -f "$private_key"
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
