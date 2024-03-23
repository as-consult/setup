#!/usr/bin/bash

echo "----------------------------------------------------------"
echo "--- Ruby On Rails development environment setup - Part 1"
echo "----------------------------------------------------------"

# Adding Node.js repository
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -

# Adding Yarn repository (JavaScript dependency manager - commonly used on VPS)
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

# Refresh our packages list with the new repositories
sudo apt update

# Install our dependencies for compiiling Ruby along with Node.js and Yarn
sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev dirmngr gnupg apt-transport-https ca-certificates libvips tree nodejs yarn

echo `node -v` #v18.13.0
echo `yarn -v` #1.22.19

# Install Ruby
rm -rf ~/.rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(rbenv init -)"' >> ~/.zshrc
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.zshrc
exec zsh
