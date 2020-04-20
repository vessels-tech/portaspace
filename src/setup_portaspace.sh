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
cat ${TMP_DIR}/githubKey >> ~/.ssh/known_hosts

cd ${WORKDIR}
git clone git@github.com:vessels-tech/central-ledger.git
cd central-ledger && git remote add mojaloop git@github.com:mojaloop/central-ledger.git

cd ${WORKDIR}
git clone git@github.com:vessels-tech/helm.git
cd helm && git remote add mojaloop git@github.com:mojaloop/helm.git

cd ${WORKDIR}
git clone git@github.com:vessels-tech/postman.git
cd helm && git remote add mojaloop git@github.com:mojaloop/postman.git

cd ${WORKDIR}
git clone git@github.com:tdaly61/laptop-mojo.git

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


if ! [ -x "$(command -v nvm)" ]; then
  echo 'installing nvm'
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \.   "$NVM_DIR/bash_completion"
  # TODO: configure with fish...
  nvm install v12
fi

nvm --version || echo '[WARN] nvm install failed'


# TODO:
# Add below options to ~/.byobu/.tmux.conf:
# set -g mouse on


# Install node tools
npm install -g newman


rm -rf ${TMP_DIR}