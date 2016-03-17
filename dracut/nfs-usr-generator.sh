#!/bin/bash

type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh


generator_mount_usrfs()
{
    local _type=$2
    local _flags=$3
    local _name

    [ -z "$1" ] && return 0

    _name=$(dev_unit_name "$1")
    [ -d "$GENERATOR_DIR" ] || mkdir -p "$GENERATOR_DIR"
    if ! [ -f "$GENERATOR_DIR"/sysroot-usr.mount ]; then
        {
            echo "[Unit]"
            echo "Before=initrd-root-fs.target"
            echo "After=sysroot.mount"
            echo "[Mount]"
            echo "Where=/sysroot/usr"
            echo "What=$1"
            echo "Options=${_flags}"
            echo "Type=${_type}"
        } > "$GENERATOR_DIR"/sysroot-usr.mount
    fi
    if ! [ -L "$GENERATOR_DIR"/initrd-root-fs.target.requires/sysroot-usr.mount ]; then
        [ -d "$GENERATOR_DIR"/initrd-root-fs.target.requires ] || mkdir -p "$GENERATOR_DIR"/initrd-root-fs.target.requires
        ln -s ../sysroot-usr.mount "$GENERATOR_DIR"/initrd-root-fs.target.requires/sysroot-usr.mount
    fi
}


[ -z "$mount_usr" ] && mount_usr=$(getarg mount.usr=)
[ -z "$mount_usrfstype" ] && mount_usrfstype=$(getarg mount.usrfstype=)
[ -z "$mount_usrflags" ] && mount_usrflags=$(getarg mount.usrflags=)

case "$mount_usrfstype" in
    nfs|nfs4|nfs4)
        usrok=1 ;;
esac


GENERATOR_DIR="$1"


if [ "$usrok" = "1"  ]; then
   strstr "$(cat /proc/cmdline)" 'mount.usr=' && generator_mount_usrfs "${mount_usr}" "${mount_usrfstype}" "${mount_usrflags}"
fi


exit 0
