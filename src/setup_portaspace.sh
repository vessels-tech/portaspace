#!/usr/bin/env bash

# use this script to set up _everything_
# The goal is to make it mostly idempotent, so we can minimize the amount of manual setup

WORKDIR=/home/ubuntu/developer/mojaloop
TMP_DIR=/home/ubuntu/developer/mojaloop/tmp

#TODO: make these commands smarter...
mkdir -p ${WORKDIR}
mkdir -p ${TMP_DIR}

# Repo and git setup
ssh-keyscan github.com >> ${TMP_DIR}/githubKey
cat /tmp/githubKey >> ~/.ssh/known_hosts

cd ${WORKDIR}
git clone git@github.com:vessels-tech/central-ledger.git
cd central-ledger && git remote add mojaloop git@github.com:mojaloop/central-ledger.git

cd ${WORKDIR}
git clone git@github.com:vessels-tech/helm.git
cd helm && git remote add mojaloop git@github.com:mojaloop/helm.git

cd ${WORKDIR}
git clone git@github.com:vessels-tech/moja-bench.git

git config --global user.name "lewisdaly"
git config --global user.email "lewis@vesselstech.com"

# TODO: this should be replaced with a proper bash/fish config etc.
if [ $(cat ~/.bashrc | grep 'alias gs' | wc -l) -eq 0 ]; then
  echo 'alias gs="git status"' > ~/.bashrc
fi

if [ $(cat ~/.bashrc | grep 'alias gp' | wc -l) -eq 0 ]; then
  echo 'alias gp="git push"' > ~/.bashrc
fi


#TODO:
#docker user config?, this requires a restart...

# Install K3s, Helm3
if ! [ -x "$(command -v k3s)" ]; then 
  echo 'Installing k3s'
  curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -s -
fi

k3s kubectl get node || echo '[WARN] k3s install failed'

if ! [ -x "$(command -v helm)" ]; then 
  echo 'Installing helm'
  curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
fi

helm version || echo '[WARN] Helm install failed'


rm -rf ${TMP_DIR}