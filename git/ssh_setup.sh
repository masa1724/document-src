#!/bin/bash
source $MY_CONF

cd $HOME/.ssh
sudo ssh-keygen -t rsa -f ${GIT['rsa_key_name']}
sudo chmod 777 ${GIT['rsa_key_name']}
eval "$(ssh-agent)"
ssh-add ~/.ssh/${GIT['rsa_key_name']}
sudo chmod 600 ${GIT['rsa_key_name']}
sudo cat "${GIT['rsa_key_name']}.pub" | xsel --clipboard --input

google-chrome-stable --log-level=3 --new-window https://github.com/settings/ssh
