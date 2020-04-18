# ENVS := dev prod
# env := dev
# PREFIX := $(shell echo $(env) |shasum -a 256|cut -c 1-12)
# KEY := $(shell pwd | xargs basename)
# TF_ENV_VARS := 
# AWS_ENV :=
# S3_PATH :=

TF_DIR := "./src"

help:
	@echo "make [plan|apply|pause|destroy]"

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

.PHONY: help
