prefix ?= /usr
libdir ?= ${prefix}/lib
pkglibdir ?= ${libdir}/dracut
moduledir ?= ${pkglibdir}/modules.d/90stateless

scripts = network-generator.sh \
	  nfs-usr-generator.sh \
	  stateless-network.sh
sources = module-setup.sh \
	  parse-stateless.sh

all:

install:
	mkdir -p $(DESTDIR)$(moduledir)
	for i in $(scripts); do \
	    install -m 0755 $$i $(DESTDIR)$(moduledir)/$$i; \
	done
	for i in $(sources); do \
	    install -m 0644 $$i $(DESTDIR)$(moduledir)/$$i; \
	done

.PHONY: all install
