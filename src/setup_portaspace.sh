#!/usr/bin/env bash

# use this script to set up _everything_
# The goal is to make it mostly idempotent, so we can minimize the amount of manual setup



# Repo and git setup
ssh-keyscan github.com >> /tmp/githubKey
cat /tmp/githubKey >> ~/.ssh/known_hosts

#TODO: make these commands smarter...
mkdir -p /home/ubuntu/developer/mojaloop

cd /home/ubuntu/developer/mojaloop
git clone git@github.com:vessels-tech/central-ledger.git
cd central-ledger && git remote add mojaloop git@github.com:mojaloop/central-ledger.git

cd /home/ubuntu/developer/mojaloop
git clone git@github.com:vessels-tech/helm.git
cd helm && git remote add mojaloop git@github.com:mojaloop/helm.git
