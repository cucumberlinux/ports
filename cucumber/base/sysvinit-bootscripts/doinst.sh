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

install_new_file etc/clock
install_new_file etc/console
install_new_file etc/createfiles
install_new_file etc/modules
install_new_file etc/udev_retry
install_new_file etc/rc.d/rc.config
install_new_file etc/rc.d/init.d/checkfs
install_new_file etc/rc.d/init.d/cleanfs
install_new_file etc/rc.d/init.d/console
install_new_file etc/rc.d/init.d/halt
install_new_file etc/rc.d/init.d/hostname
install_new_file etc/rc.d/init.d/modules
install_new_file etc/rc.d/init.d/mountfs
install_new_file etc/rc.d/init.d/mountvirtfs
install_new_file etc/rc.d/init.d/rc
install_new_file etc/rc.d/init.d/reboot
install_new_file etc/rc.d/init.d/sendsignals
install_new_file etc/rc.d/init.d/setclock
install_new_file etc/rc.d/init.d/swap
install_new_file etc/rc.d/init.d/sysctl
install_new_file etc/rc.d/init.d/sysklogd
install_new_file etc/rc.d/init.d/template
install_new_file etc/rc.d/init.d/udev
install_new_file etc/rc.d/init.d/udev_retry

for file in etc/rc.d/rc.local{,_shutdown}; do
	if [ ! -e $file ]; then
		mv -v $file.new $file
	else
		rm -v $file.new
	fi
done

