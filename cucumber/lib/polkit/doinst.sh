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

# Polkit needs the user and group polkitd to exist for polkt to work
# Add them if they don't already exist
if [ -z "$(grep polkitd: etc/group)" ]; then
        echo "polkitd:x:17:polkitd" >> etc/group
fi
if [ -z "$(grep polkitd: etc/passwd)" ]; then
        echo "polkitd:x:17:17:PolicyKit Daemon Owner:/etc/polkit-1:/bin/false" >> etc/passwd
fi
if [ -z "$(grep polkitd: etc/shadow)" ]; then
        echo "polkitd:!:17149:0:::::" >> etc/shadow
fi

