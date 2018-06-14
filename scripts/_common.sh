#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================
# App package root directory should be the parent folder
PKG_DIR=$(cd ../; pwd)

pkg_dependencies="python3-pip python3-dev libacl1-dev libssl-dev liblz4-dev"

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
        export $var=${!ynh_arg}
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

# Render templates with Jinja2
#
# Attention : Variables should be exported before calling this helper to be
# accessible inside templates.
#
# usage: ynh_render_template some_template output_path
# | arg: some_template - Template file to be rendered
# | arg: output_path   - The path where the output will be redirected to
ynh_render_template() {
   local template_path=$1
   local output_path=$2
   # Taken from https://stackoverflow.com/a/35009576
   python2.7 -c 'import os, sys, jinja2; sys.stdout.write(
                    jinja2.Template(sys.stdin.read()
                 ).render(os.environ));' < $template_path > $output_path
}

ynh_configure () {
    ynh_backup_if_checksum_is_different $2
    ynh_configure "${PKG_DIR}/conf/$1.j2" $2
    ynh_store_file_checksum $2
}
