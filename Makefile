prefix ?= /usr
libdir ?= ${prefix}/lib
datadir ?= ${prefix}/share
factorydir ?= ${datadir}/factory
localetcdir ?= ${prefix}/local/etc
systemddir ?= ${libdir}/systemd
systemunitdir ?= ${systemddir}/system
systempresetdir ?= ${systemddir}/system-preset
systemgeneratordir ?= ${systemddir}/system-generators
sysusersdir ?= ${libdir}/sysusers.d
tmpfilesdir ?= ${libdir}/tmpfiles.d
xsessionsdir ?= ${datadir}/xsessions

generators = systemd/system-generators/stateless-local-fstab-generator \
	     systemd/system-generators/stateless-firstboot-generator
presets = systemd/system-preset/50-htpc.preset \
	  systemd/system-preset/80-nfs.preset
configs = local/etc/fstab \
	  local/etc/locale.conf
rootpasswd = local/etc/root.passwd
xsession = xsession/steam-bigpicture.desktop
vendorfiles = etc/netconfig \
	      etc/protocols \
	      etc/services \
	      etc/conf.d/rpcbind \
	      etc/conf.d/nfs-common.conf \
	      etc/conf.d/nfs-server.conf\
	      etc/dbus-1/session.conf \
	      etc/dbus-1/system.conf \
	      etc/dbus-1/system.d/avahi-dbus.conf \
	      etc/dbus-1/system.d/org.freedesktop.ColorManager.conf \
	      etc/dbus-1/system.d/org.freedesktop.DisplayManager.conf \
	      etc/dbus-1/system.d/org.freedesktop.GeoClue2.Agent.conf \
	      etc/dbus-1/system.d/org.freedesktop.GeoClue2.conf \
	      etc/dbus-1/system.d/org.freedesktop.PolicyKit1.conf \
	      etc/dbus-1/system.d/org.freedesktop.hostname1.conf \
	      etc/dbus-1/system.d/org.freedesktop.import1.conf \
	      etc/dbus-1/system.d/org.freedesktop.locale1.conf \
	      etc/dbus-1/system.d/org.freedesktop.login1.conf \
	      etc/dbus-1/system.d/org.freedesktop.machine1.conf \
	      etc/dbus-1/system.d/org.freedesktop.network1.conf \
	      etc/dbus-1/system.d/org.freedesktop.resolve1.conf \
	      etc/dbus-1/system.d/org.freedesktop.systemd1.conf \
	      etc/dbus-1/system.d/org.freedesktop.timedate1.conf \
	      etc/lightdm/keys.conf \
	      etc/lightdm/lightdm.conf \
	      etc/lightdm/users.conf \
	      etc/lightdm/Xsession \
	      etc/pam.d/htpc-autologin \
	      etc/polkit-1/rules.d/50-default.rules \
	      etc/ssh/sshd_config
sysusers = sysusers.d/dbus.conf \
	   sysusers.d/htpc.conf \
	   sysusers.d/lightdm.conf \
	   sysusers.d/nfs.conf \
	   sysusers.d/polkit.conf
tmpfiles = tmpfiles.d/dbus.conf \
	   tmpfiles.d/htpc.conf \
	   tmpfiles.d/nfs.conf \
	   tmpfiles.d/polkit.conf \
	   tmpfiles.d/ssh.conf \
	   tmpfiles.d/stateless-lightdm.conf
all:

install:
	$(MAKE) -C dracut install
	mkdir -p $(DESTDIR)$(systemgeneratordir)
	for i in $(generators); do \
	    install -m 0755 $$i $(DESTDIR)$(libdir)/$$i; \
	done
	mkdir -p $(DESTDIR)$(systempresetdir)
	for i in $(presets); do \
	    install -m 0644 $$i $(DESTDIR)$(libdir)/$$i; \
	done
	mkdir -p $(DESTDIR)$(localetcdir)
	for i in $(configs); do \
	    install -m 0644 $$i $(DESTDIR)$(prefix)/$$i; \
	done
	install -m 0600 $(rootpasswd) $(DESTDIR)$(prefix)/$(rootpasswd)
	mkdir -p $(DESTDIR)$(factorydir)/etc/conf.d
	for i in $(vendorfiles); do \
	    install -m 0644 $$i $(DESTDIR)$(factorydir)/$$i; \
	done
	mkdir -p $(DESTDIR)$(sysusersdir)
	for i in $(sysusers); do \
	    install -m 0644 $$i $(DESTDIR)$(libdir)/$$i; \
	done
	mkdir -p $(DESTDIR)$(tmpfilesdir)
	for i in $(tmpfiles); do \
	    install -m 0644 $$i $(DESTDIR)$(libdir)/$$i; \
	done
	mkdir -p $(DESTDIR)$(xsessionsdir)
	install -m 0644 $$i $(DESTDIR)$(xsessionsdir)/$(xsession)
	ln -s $(DESTDIR)$(xsessionsdir)/$(xsession) \
	      $(DESTDIR)$(xsessionsdir)/$(xsession)default.desktop

.PHONY: all install
