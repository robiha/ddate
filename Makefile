# ddate - hail Eris
.POSIX:

VERSION = 0.1
PREFIX = /usr/local
MANPREFIX = ${PREFIX}/share/man
CFLAGS = -std=99 -pedantic -Wall
CC = cc

all: options ddate


options:
	@echo ddate build options:
	@echo "CFLAGS = ${CFLAGS}"
	@echo "CC    = ${CC}"

ddate:
	@echo CC $@
	@${CC} ddate.c -o $@

clean:
	@echo cleaning
	@rm -f ddate ddate-${VERSION}.tar.gz

dist: clean
	@echo creating dist tarball
	@mkdir -p ddate-${VERSION}
	@ cp -R ddate.1 ddate.c Makefile README.org ddate-${VERSION}
	@tar -cf ddate-${VERSION}.tar ddate-${VERSION}
	@gzip ddate-${VERSION}.tar
	@rm -rf ddate-${VERSION}

install: all
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f ddate ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/ddate
	@echo installing manual page to ${DESTDIR}${MANPREFIX}/man1
	@mkdir -p ${DESTDIR}${MANPREFIX}/man1
	@cp -f ddate.1 ${DESTDIR}${MANPREFIX}/man1/ddate.1
	@chmod 644 ${DESTDIR}${MANPREFIX}/man1/ddate.1

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/ddate
	@echo removing manual page from ${DESTDIR}${MANPREFIX}/man1
	@rm -f ${DESTDIR}${MANPREFIX}/man1/ddate.1

.PHONY: all options clean dist install uinstall
