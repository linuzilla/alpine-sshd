#!/bin/sh

cd /etc/init-scripts

for x in $(for f in [0-9][0-9]*.sh; do echo $f; done | sort); do
	if [ -x "$x" ]; then
		./$x
	fi
done

supervisord -c /etc/supervisord.conf
