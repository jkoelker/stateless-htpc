#!/bin/sh
type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh 

CMDLINE_CONF="/etc/cmdline.d/dracut-neednet.conf"

[ -z "usrfstype" ] && userfstype=$(getarg mount.usrfstype=)
[ "$usrfstype" = "nfs" ] && echo "rd.neednet=1" > $CMDLINE_CONF

[ -z "$rootfstype" ] && rootfstype=$(getarg rootfstype=)
[ "$rootfstype" = "tmpfs" ] && rootok=1
