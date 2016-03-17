#!/bin/sh


# called by dracut
depends() {
    # We depend on network modules being loaded
    echo network nfs
}

install() {
    inst_multiple -o \
        $systemdutildir/systemd-tmpfiles-setup \
        $systemdutildir/systemd-sysusers \
        /usr/lib/sysusers.d/basic.conf \
        /usr/lib/sysusers.d/systemd.conf

    inst_hook cmdline 95 "${moddir}/parse-stateless.sh"
    inst_script "$moddir/nfs-usr-generator.sh" $systemdutildir/system-generators/stateless-nfs-usrfs-generator
    inst_script "$moddir/network-generator.sh" $systemdutildir/system-generators/stateless-network-generator
    inst_script "$moddir/stateless-network.sh" /bin/stateless-network
}
