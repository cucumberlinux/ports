#!/bin/bash

chroot . /usr/bin/gdk-pixbuf-query-loaders --update-cache 1> /dev/null 2> /dev/null
if [ -e usr/lib64 ]; then
	chroot . /usr/bin/gdk-pixbuf-query-loaders > /usr/lib64/gdk-pixbuf-*/*/loaders.cache
fi
chroot . /usr/bin/gdk-pixbuf-query-loaders > /usr/lib/gdk-pixbuf-*/*/loaders.cache
