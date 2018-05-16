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
	# Check if the files are identical, and remove the new one if they are.
	diff -q $1.new $1 && rm $1.new

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

# Add the shadow group if it doesn't already exist
if [ -z "$(grep shadow: etc/group)" ]; then
        echo "shadow:x:30:shadow" >> etc/group
fi

install_new_file etc/login.defs
install_new_file etc/default/useradd
install_new_file etc/login.access
install_new_file etc/limits

# Setup the /etc/shadow file
chroot . pwconv
chown root:30 etc/shadow
chmod 640 etc/shadow

# Setup the /etc/gshadow file
chroot . grpconv
chown root:30 etc/gshadow
chmod 640 etc/gshadow
