#!/bin/bash
source $MY_CONF

git config --global user.name ${GIT['user.name']}
git config --global user.email ${GIT['user.email']}

git config --global core.editor "/usr/bin/vim"
git config --global color.ui true
