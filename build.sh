#!/bin/sh

if [ ! -f id_rsa ]; then
	ssh-keygen -f id_rsa -N '' -t rsa
fi
docker build -t linuzilla/alpine-sshd .
