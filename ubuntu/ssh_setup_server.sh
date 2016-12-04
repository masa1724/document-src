# Server  SSH Setup

#edit sshconfig
sudo apt-get install vim
sudo vim /etc/ssh/sshd_config
#  -----------------------------------------------
#  PermitRootLogin no
#  PermitEmptyPasswords no
#  ChallengeResponseAuthentication no
#  PasswordAuthentication no
#  -----------------------------------------------

#deploy rsa_key
cd $HOME
mkdir -p .ssh
chmod 700 .ssh
cat [rsa_key_name].pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
sudo rm [rsa_key_name].pub

sudo service sshd restart
