#!/bin/sh

cd /etc/settings.d

if [ -f authorized_keys ]; then
	[ -d /root/.ssh ] || mkdir /root/.ssh
	chmod 700 /root/.ssh
	cp authorized_keys /root/.ssh
	chmod 600 /root/.ssh/authorized_keys
fi

for a in rsa dsa ecdsa ed25519; do
	f=ssh_host_${a}_key
	if [ -f $f ] && [ -f $f.pub ]; then
		cp -f $f /etc/ssh/$f
		cp -f $f.pub /etc/ssh/$f.pub
	else
    		ssh-keygen -f /etc/ssh/$f -N '' -t $a
	fi
done
