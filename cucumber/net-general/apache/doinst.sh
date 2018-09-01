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
if [ -z "$(grep apache: etc/group)" ]; then
        echo "apache:x:25:apache" >> etc/group
fi
if [ -z "$(grep apache: etc/passwd)" ]; then
        echo "apache:x:25:25:Apache Daemon:/srv/www:/bin/false" >> etc/passwd
fi
if [ -z "$(grep apache: etc/shadow)" ]; then
        echo "apache:!:17149:0:::::" >> etc/shadow
fi

install_new_file etc/httpd/httpd.conf
install_new_file etc/httpd/extra/httpd-autoindex.conf
install_new_file etc/httpd/extra/httpd-dav.conf
install_new_file etc/httpd/extra/httpd-default.conf
install_new_file etc/httpd/extra/httpd-info.conf
install_new_file etc/httpd/extra/httpd-languages.conf
install_new_file etc/httpd/extra/httpd-manual.conf
install_new_file etc/httpd/extra/httpd-mpm.conf
install_new_file etc/httpd/extra/httpd-multilang-errordoc.conf
install_new_file etc/httpd/extra/httpd-ssl.conf
install_new_file etc/httpd/extra/httpd-userdir.conf
install_new_file etc/httpd/extra/httpd-vhosts.conf
install_new_file etc/httpd/extra/proxy-html.conf

if [ -e srv/www/html ]; then
	rm -r srv/www/html.new
else
	mv srv/www/html.new srv/www/html
fi

