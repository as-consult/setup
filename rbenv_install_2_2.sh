#!/usr/bin/bash

echo "----------------------------------------------------------"
echo "--- Ruby On Rails development environment setup - Part 2"
echo "----------------------------------------------------------"

echo `rbenv -v` #rbenv 1.2.0-52-g61747c0

echo "List available ruby versions:"
echo `rbenv install -l`
#rbenv install -L

# We install verion 3.2.2
rbenv install 3.2.2
rbenv global 3.2.2
echo `ruby -v` #uby 3.2.2 (2023-03-30 revision e51014f9c0) [x86_64-linux]

# This installs the latest Bundler, currently 2.x.
gem install bundler
echo `bundler -v`  #Bundler version 2.3.26

# We ensure everything is correctly upddated, cleaned
sudo apt update && sudo apt upgrade && sudo apt autoclean && sudo apt autoremove

# Install the offline docs
echo "Installing offline docs"
cd ~/Documents
curl https://ruby-doc.org/downloads/ruby_3_1_1_core_rdocs.tgz --output ruby_3_1_1_core.tgz
tar -xf ruby_3_1_1_core.tgz
rm -rf ruby_3_1_1_core.tgz

exec zsh
