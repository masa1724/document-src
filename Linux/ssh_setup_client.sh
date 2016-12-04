# Client SSH Setup
#create rsa_key
cd ~/.ssh
ssh-keygen -t rsa -f [hoge]
chmod 600 [hoge].pub
sudo scp ~/.ssh/[hoge].pub [username]@[host]:.

#connect server
sudo ssh [user]@[host]   # default
sudo ssh -i ~/.ssh/[rsa_key_name] [user]@[host]   # After PasswordAuthentication no  
