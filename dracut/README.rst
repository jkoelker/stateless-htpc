An NFS mounted /usr stateless system
====================================

This dracut module allows booting a completely diskless stateless machine.
After installing it, the initrd will accept mount.* options to mount ``/usr``
from an nfs server:

    .. code:: console
        ip=dhcp root=tmpfs rootfstype=tmpfs rootflags=rw \
        mount.usr=<server>:/path/to/usr mount.usrfstype=nfs mount.usrflags=ro

It will also generate a ``/sysroot/etc/systemd/network/$BOOTDEV.network`` file
with DHCP on and ``CriticalConnection=true`` to prevent ``systemd-networkd``
from dropping the connection when it starts.
