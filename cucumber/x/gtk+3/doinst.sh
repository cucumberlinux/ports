#!/bin/bash

chroot . gtk-query-immodules-3.0 --update-cache
chroot . glib-compile-schemas /usr/share/glib-2.0/schemas
