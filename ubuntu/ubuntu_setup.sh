#!/bin/bash

sudo apt-get update
sudo apt-get upgrade

env LANGUAGE=C LC_MESSAGES=C xdg-user-dirs-gtk-update


# install packages
sudo apt-get install -y ibus mozc
sudo add-apt-repository ppa:git-core/ppa
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo add-apt-repository ppa:webupd8team/sublime-text-3

sudo apt-get install -y git google-chrome-stable vim sublime-text-installer

# delete packages
sudo rm -R /usr/bin/firefox


sudo apt-get update

