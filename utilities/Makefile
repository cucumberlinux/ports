# Makefile for installing the ports utilities
DESTDIR=
PREFIX=/usr/local
BINDIR=$(PREFIX)/bin
MANDIR=$(PREFIX)/share/man
CONFDIR=/etc

DEFAULT_UTILITIES=portmake portsync portstrap

INSTALL=install

install: $(DEFAULT_UTILITIES)

directory_skel:
	$(INSTALL) -d -m 755 $(DESTDIR)$(PREFIX)
	$(INSTALL) -d -m 755 $(DESTDIR)$(BINDIR)
	$(INSTALL) -d -m 755 $(DESTDIR)$(MANDIR)/man8
	$(INSTALL) -d -m 755 $(DESTDIR)$(CONFDIR)

portmake: directory_skel
	$(INSTALL) -m 755 tools/portmake $(DESTDIR)$(BINDIR)/portmake
	$(INSTALL) -m 644 documentation/man/man8/portmake.8 $(DESTDIR)$(MANDIR)/man8/portmake.8
	$(INSTALL) -m 644 templates/portmake.conf $(DESTDIR)$(CONFDIR)/portmake.conf

portsync: directory_skel
	$(INSTALL) -m 755 tools/portsync $(DESTDIR)$(BINDIR)/portsync
	$(INSTALL) -m 644 templates/portsync.conf $(DESTDIR)$(CONFDIR)/portsync.conf

portstrap: directory_skel
	$(INSTALL) -m 755 tools/portstrap $(DESTDIR)$(BINDIR)/portstrap

