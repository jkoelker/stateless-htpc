UNITSDIR=usr/lib/systemd/system
PRESETSDIR=usr/lib/systemd/system-preset
GENERATORSDIR=usr/lib/systemd/system-generators
FACTORYDIR=usr/share/factory
TMPFILESDIR=usr/lib/tempfiles.d
SYSUSERSDIR=usr/lib/sysusers.d

all:

install:
	install -Dm755 \
		local-fstab-generator \
		$(DESTDIR)/$(GENERATORSDIR)/local-fstab-generator
	install -Dm644 \
		50-htpc.preset \
		$(DESTDIR)/$(PRESETSDIR)/50-htpc.preset
	install -Dm644 \
		fstab \
		$(DESTDIR)/usr/local/etc/fstab
	install -Dm644 \
		firstboot.conf \
		$(DESTDIR)/$(UNITSDIR)/systemd-firstboot.service.d/firstboot.conf
	install -Dm644 \
		steam-bigpicture.service \
		$(DESTDIR)/$(UNITSDIR)/steam-bigpicture.service
	install -Dm600 \
		root.passwd \
		$(DESTDIR)/usr/local/etc/root.passwd
	install -Dm644 \
		/etc/netconfig \
		$(DESTDIR)/$(FACTORYDIR)/etc/netconfig
	install -Dm644 \
		/etc/protocols \
		$(DESTDIR)/$(FACTORYDIR)/etc/protocols
	install -Dm644 \
		/etc/services \
		$(DESTDIR)/$(FACTORYDIR)/etc/services
	install -Dm644 \
		/etc/conf.d/nfs-common.conf \
		$(DESTDIR)/$(FACTORYDIR)/etc/conf.d/nfs-common.conf
	install -Dm644 \
		/etc/conf.d/nfs-server.conf \
		$(DESTDIR)/$(FACTORYDIR)/etc/conf.d/nfs-server.conf
	install -Dm644 \
		/etc/conf.d/rpcbind \
		$(DESTDIR)/$(FACTORYDIR)/etc/conf.d/rpcbind
	install -Dm644 \
		nfs.sysusers \
		$(DESTDIR)/$(SYSUSERSDIR)/nfs.conf
	install -Dm644 \
		htpc.sysusers \
		$(DESTDIR)/$(SYSUSERSDIR)/htpc.conf
	install -Dm644 \
		nfs.tmpfiles \
		$(DESTDIR)/$(TMPFILESDIR)/nfs.conf

.PHONY: all install
