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

# D-Bus needs the user and group messagebus to exist for the messagebus daemon
# Add them if they don't already exist
if [ -z "$(grep messagebus: etc/group)" ]; then
        echo "messagebus:x:18:apache" >> etc/group
fi
if [ -z "$(grep messagebus: etc/passwd)" ]; then
        echo "messagebus:x:18:18:D-Bus Message Daemon:/var/run/dbus:/bin/false" >> etc/passwd
fi
if [ -z "$(grep messagebus: etc/shadow)" ]; then
        echo "messagebus:!:17149:0:::::" >> etc/shadow
fi

install_new_file etc/dbus-1/session.conf
install_new_file etc/dbus-1/system.conf

