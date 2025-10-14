#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

install_borg_with_pip () {
    # Install borg as root, to avoid privilege escalation as we run borg as root using sudo.
    # Assign the group to borg so it is able to execute the command but can't alter the binary.
    python3 -m venv --upgrade "$install_dir/venv"
    venvpy="$install_dir/venv/bin/python3"

    "$venvpy" -m pip install --upgrade setuptools wheel
    BORG_VERSION=$(ynh_app_upstream_version)
    "$venvpy" -m pip install borgbackup[pyfuse3]=="$BORG_VERSION"
    chown -R "root:$app" "$install_dir/venv"
    chmod -R g-w "$install_dir/venv"
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

    ynh_app_setting_set --key=public_key --value="$public_key"
}
