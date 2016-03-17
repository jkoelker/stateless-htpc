#!/bin/bash
[ -d "$NETWORK_DIR" ] || mkdir -p "$NETWORK_DIR"
[ -d "$ETC_DIR" ] || mkdir -p "$ETC_DIR"
cp /proc/sys/kernel/hostname "$ETC_DIR"/hostname

BOOTDEV="$1"

{
    echo "[Match]"
    echo "Name=$BOOTDEV"
    echo "[Network]"
    echo "DHCP=true"
    echo "[DHCP]"
    echo "CriticalConnection=true"

} > "$NETWORK_DIR"/"$BOOTDEV".network
