# ENVS := dev prod
# env := dev
# PREFIX := $(shell echo $(env) |shasum -a 256|cut -c 1-12)
# KEY := $(shell pwd | xargs basename)
# TF_ENV_VARS := 
# AWS_ENV :=
# S3_PATH :=

TF_DIR := "./src"

help:
	@echo "make [plan|apply|pause|destroy|setup]"

###
# Infrastructure
### 

check-mfa:
	aws-mfa

plan: check-mfa
	cd ${TF_DIR} && terraform plan

apply: check-mfa
	cd ${TF_DIR} && terraform apply

pause: check-mfa
	@echo 'Not implemented'

destroy: check-mfa
	cd ${TF_DIR} && terraform destroy


###
# Login and Configure the Instance
### 

setup:
	# make sure the old portaspace isn't still in our known_hosts
	sed '/^portaspace.mojaloop/d' ~/.ssh/known_hosts > ~/.ssh/known_hosts

	# copy in our key
	scp  ~/.ssh/id_rsa ubuntu@portaspace.mojaloop.live:~/.ssh/id_rsa

	# Run the setup script
	# ssh ubuntu@portaspace.mojaloop.live "git clone git@github.com:vessels-tech/portaspace.git && chmod 755 ./portaspace/src/setup_portaspace.sh && ./portaspace/src/setup_portaspace.sh"
	ssh ubuntu@portaspace.mojaloop.live "curl -s https://raw.githubusercontent.com/vessels-tech/portaspace/master/src/setup_portaspace.sh | bash"

	./scripts/_setup_ssh_config.sh







.PHONY: help
