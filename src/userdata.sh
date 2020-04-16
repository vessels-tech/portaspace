#!/usr/bin/env bash

echo 'starting...' >> /tmp/userdata_status

# Software Updates

apt update \
  && apt install apt-transport-https ca-certificates curl software-properties-common -y \
  && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
  && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" \
  && apt update \
  && apt install docker-ce -y \
  && systemctl enable docker \
  && systemctl start docker \
  && curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` \
            -o /usr/local/bin/docker-compose \
  && chmod +x /usr/local/bin/docker-compose


#turns out that changing this script forces replacement... damn

# Dynamic Setup Script

# TODO: we can't clone any repos with ssh until the ssh key is in here! Maybe we need to set up the key in userdata.sh
# TODO: this runs as root I think. so we need to be careful about permissions
curl -s https://raw.githubusercontent.com/vessels-tech/portaspace/master/src/setup_portaspace.sh | bash


echo 'DONE' >> /tmp/userdata_done

