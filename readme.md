# Portaspace

A portable cloud-hosted workspace managed by terraform.

Useful when the internet is bad, or we need extra performance.

## Config


## Up and Running

```bash

#sign in with 2fa to command line
aws-mfa 

# deploy the infrastructure
cd src
terraform plan
terraform apply

# make sure the old portaspace isn't still in our known_hosts
sed '/^portaspace.mojaloop/d' ~/.ssh/known_hosts > ~/.ssh/known_hosts

# copy in our key
scp  ~/.ssh/id_rsa ubuntu@portaspace.mojaloop.live:~/.ssh/id_rsa

# ssh in
ssh ubuntu@portaspace.mojaloop.live

# run the setup script
curl -s https://raw.githubusercontent.com/vessels-tech/portaspace/master/src/setup_portaspace.sh | bash

# update the ssh config
if [ $(cat ~/.ssh/config | grep 'alias gs' | wc -l) -eq 0 ]; then
  echo '
Host portaspace
    HostName portaspace.mojaloop.live
    User ubuntu
    IdentityFile ~/.ssh/id_rsa' >> ~/.ssh/config
fi


# From vscode, open a new session
vscode
SHIFT + CMD + P > "ssh" > Select "Remote-SSH Connect to Host..." > Select "portaspace"
```


## TODO
- figure out how configure public ips and ssh (we need to get our private key in there...)
- scripts to get git repos up and running etc.
- scripts to configure fish, byobu etc. how we like it
- vscode simple config
- tool for hibernating (and maybe auto-hibernating) instance


## Vars

export PUBLIC_IP=13.251.114.30


## Steps for environment setup
> TODO: automate this or something with terraform...

```bash
# when prompted, make the name: /Users/ldaly/.ssh/id_ld_cloud10
ssh-keygen -t ed25519

# copy this key
cat ~/.ssh/id_ld_cloud9.pub | pbcopy

#in the env
echo 'PASTE CONTENTS' >> ~/.ssh/authorized_keys

# manual step: open up security groups for all tcp from your ip

# back on local
ssh -i ~/.ssh/id_ld_cloud9 ubuntu@$PUBLIC_IP

byobu


# copy ssh key (a little dangerous, but that's what we have github configured with...)
scp -i ~/.ssh/id_ld_cloud9 ~/.ssh/id_rsa ubuntu@$PUBLIC_IP:/~.ssh/id_rsa
```


## Installing tools

```bash
DOCKER_COMPOSE_VERSION=1.25.4
sudo curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version


git config --global user.name "Lewis Daly"
git config --global user.email lewis@vesselstech.com

```



## Downloading code

```bash

```


## Configure byobu:
```bash
Ctrl+a set to emacs mode

ctrl+s, then | or % to split panes
fn + F7 for scrollback mode
```


## TODO:
- set up VSCode (local only)
- set up on MBA
- install a bunch of Mojaloop repos and test npm installs etc
- set up fish, fish config and colors
- maybe set up byobu shortcuts?


## Outstanding issues:
- scrolling back is really hard in byobu
- option + arrows to get around words not working
- not enough space by default...
- networking (e.g. downloading docker images) still kinda slow...
- `atom .` or similar shortcuts won't work... 
- public IP changed on startup... that's kinda a pain
  - also seems to have affeced security groups - I can't ssh in now :(


## Other notes:

M5DN Extra Large 	m5dn.xlarge 	16.0 GiB 	4 vCPUs 	150 GiB NVMe SSD 	Up to 25 Gigabit
$0.272000 hourly

5 hours/day, 5 days/week
= $6.8/week
* 50 weeks
= $340/annually

Not bad for a beefy machine that can be upgraded on the fly I suppose...
- I could also free up almost 100gb of docker stuff across my machines

So far networking seems pretty good... would be good to run a speed test

The real question here is:
- Can we truly get comfortable on a remote-only environment?
  - I think the answer is yes, but we need:
    - to invest time in automating what can be automated: both from a set up and login point of view
    - figure out byobu or tmux or whatever and set up the right keyboard shortcuts
    