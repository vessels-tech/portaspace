#!/usr/bin/env bash


if [ $(cat ~/.ssh/config | grep 'Host portaspace' | wc -l) -eq 0 ]; then
  echo '
	Host portaspace
			HostName portaspace.mojaloop.live
			User ubuntu
			IdentityFile ~/.ssh/id_rsa' >> ~/.ssh/config
	fi