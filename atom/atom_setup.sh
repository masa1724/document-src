#!/bin/bash

#http://qiita.com/nimusukeroku/items/21860ebd6b4cb075181a

sudo rm -rf $HOME/.atom
sudo ln -s $HOME/dotfiles/.atom $HOME/.atom

# manager
sudo apm install project-manager
sudo apm install open-recent
sudo apm install Save-Session

# editing support
sudo apm install highlight-line
sudo apm install highlight-column
sudo apm install highlight-selected
sudo apm install autocomplete-plus
sudo apm install autocomplete-paths
sudo apm install autocomplete-snippets
sudo apm install tabs-to-spaces
sudo apm install trailing-spaces
sudo apm install atom-beautify
sudo apm install editorconfig

# linter
sudo apm install linter
sudo apm install linter-php
sudo apm install linter-phpcs
sudo apm install linter-shellcheck

# extension view
sudo apm install minimap
sudo apm install minimap-autohide

# terminal
sudo apm install git-plus
sudo apm install term3
sudo apm install Script

# html
sudo apm install emmet
sudo apm install color-picker
sudo apm install pigments

# etc
sudo apm install file-icons
sudo apm install auto-encoding

# Asciidoc
sudo apm install language-asciidoc
sudo apm install asciidoc-preview

#php
sudo apm install language-apache


# dependent softwares
# linter-phpcs
sudo apt-get install -y php-pear
pear install PHP_CodeSniffer

# linter-shellcheck
sudo apt-get install -y shellcheck

sudo apm update
apm list
