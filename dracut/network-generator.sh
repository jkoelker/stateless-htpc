#!/bin/bash

type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
type ip_to_var >/dev/null 2>&1 || . /lib/net-lib.sh

GENERATOR_DIR="$1"
BOOTDEV=$(getarg bootdev=)


info() {
   echo "<30>stateless-network-generator: $*" > /dev/kmsg
}


for p in $(getargs ip=); do
    ip_to_var $p

    # make first device specified the BOOTDEV
    if [ -z "$BOOTDEV" ] && [ -n "$dev" ]; then
        BOOTDEV="$dev"
        info "Setting bootdev to '$BOOTDEV'"
        break
    fi
done


[ -d "$GENERATOR_DIR" ] || mkdir -p "$GENERATOR_DIR"


{
    echo "[Unit]"
    echo "Before=initrd.target"
    echo "After=initrd-fs.target"
    echo "Requires=initrd-fs.target"
    echo "[Service]"
    echo "Environment=NETWORK_DIR=/sysroot/etc/systemd/network"
    echo "Environment=ETC_DIR=/sysroot/etc"
    echo "Type=oneshot"
    echo "ExecStart=-/bin/stateless-network $BOOTDEV"
    echo "StandardInput=null"
    echo "StandardOutput=syslog"
    echo "StandardError=syslog+console"
    echo "KillMode=process"
    echo "RemainAfterExit=yes"
    echo "KillSignal=SIGHUP"

} > "$GENERATOR_DIR"/stateless-network.service

if ! [ -L "$GENERATOR_DIR"/initrd.target.wants/stateless-network.service ]; then
    [ -d "$GENERATOR_DIR"/initrd.target.wants ] || mkdir -p "$GENERATOR_DIR"/initrd.target.wants
    ln -s ../stateless-network.service "$GENERATOR_DIR"/initrd.target.wants/stateless-network.service
fi

exit 0
