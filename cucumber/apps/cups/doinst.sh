#!/bin/bash

# Installs the configuration file specified by $1 ($1 should be the filename
# WITHOUT the .new extension). The behavior of this function can be controlled
# by setting the NEW_FILE_ACTION variable in the environment to one of the
# following:
#
# OVERWRITE: blindly overwrites any existing files.
# KEEP (DEFAULT): keep the old files in place, leaving the new files as .new.
# REPLACE: replace any existing files, but save a copy of the old files as .old.
install_new_file () {
	if [ -z "$NEW_FILE_ACTION" -o "$NEW_FILE_ACTION" == "KEEP" ]; then
		if [ ! -e $1 ]; then
			mv $1.new $1
		fi
	elif [ "$NEW_FILE_ACTION" == "OVERWRITE" ]; then
		mv $1.new $1
	elif [ "$NEW_FILE_ACTION" == "REPLACE" ]; then
		if [ -e $1 ]; then
			mv $1 $1.old
		fi
		mv $1.new $1
	fi
}

# Apache needs the user and group apache to exist for the httpd daemon
# Add them if they don't already exist
if [ -z "$(grep lpadmin: etc/group)" ]; then
        echo "lpadmin:x:19:lp" >> etc/group
fi
if [ -z "$(grep lp: etc/passwd)" ]; then
        echo "lp:x:9:9:Print Service:/var/spool/cups:/bin/false" >> etc/passwd
fi
if [ -z "$(grep lp: etc/shadow)" ]; then
        echo "lp:!:17149:0:::::" >> etc/shadow
fi

install_new_file etc/cups/cups-files.conf
install_new_file etc/cups/cupsd.conf
install_new_file etc/cups/snmp.conf
install_new_file etc/cups/client.conf

chroot . gtk-update-icon-cache > /dev/null 2> /dev/null
