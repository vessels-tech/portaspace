#!/usr/bin/env bash

# Repo and git setup
mkdir -p /home/ubuntu/developer/mojaloop
cd /home/ubuntu/developer/mojaloop
git clone git@github.com:vessels-tech/central-ledger.git
cd central-ledger && git remote add mojaloop git@github.com:mojaloop/central-ledger.git


