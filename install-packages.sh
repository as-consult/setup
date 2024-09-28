#!/usr/bin/bash
#     _    ____  
#    / \  / ___|   Alexandre Stanescot
#   / _ \ \___ \   http://alexstan67.github.io/profile/
#  / ___ \ ___) |  https://github.com/alexstan67/
# /_/   \_\____/ 
#
# Date:	   23/03/2024
# Update:  02/06/2024
# Title: Installation script after Debian 12 fresh install for Devs

echo "####################################################################"
echo "----------- Installation General Packages"
echo "####################################################################"
sudo apt install -y vim vim-gtk3 tree gimp imagemagick libaio1 hardinfo  heif-gdk-pixbuf heif-thumbnailer libheif1:amd64 inkscape exfat-fuse gpick exiv2 libavcodec-extra easytag figlet mat2 kleopatra testdisk pdftk simplescreenrecorder neofetch qrencode font-manager xournal cifs-utils nautilus-nextcloud nextcloud-desktop openvpn network-manager-openvpn-gnome
# figlet    = big text generator
# mat2      = metadata removal
# testdisk  = recovery tool
# pdftk     = manage pdf (concat, ..) https://www.pdflabs.com/docs/pdftk-cli-examples/
# qrencode  = generate a qr code, c.f. qrencode -o "wef" -s 6 -l H -m 2 "https://weekend-fly.com"
# xournal   = pdf annotations
echo -e ">>>>>>>>>> End of General Packages Installation\n"
sleep 2

echo "####################################################################"
echo "----------- Uninstall General Packages"
echo "####################################################################"
sudo apt autoremove thunderbird

echo "####################################################################"
echo "-----------  Third Party Installations"
echo "####################################################################"

# DBeaver
echo "------------- Install DBeaver"
cd ~/Downloads
wget "https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb"
sudo dpkg -i dbeaver-ce_latest_amd64.deb
sleep 2

# QGIS Installation
echo "------------- Install QGIS"
sudo apt-get install python-software-properties
sudo add-apt-repository ppa:ubuntugis/ppa
sudo apt update && apt install qgis qgis-plugin-grass
sleep 2

echo -e ">>>>>>>>>> End of Third Party Installations\n"

echo "####################################################################"
echo "----------- Installation Developement Packages"
echo "####################################################################"
echo "----------- Installation of main libraries"
sudo apt install -y curl python3-pip xsddiagram pandoc gdb libcurl4-gnutls-dev libjson-c-dev git tig ncdu dia gh
sudo apt install -y autoconf patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev memcached
echo -e ">>>>>>>>>> End of main libraries\n"
sleep 2

# Installation GitHub - CLI
echo "----------- Installation Github - CLI - Choose SSH"
gh auth login -s 'user:email' -w
echo -e ">>>>>>>>>> End of Installation Github - CLI\n"
sleep 2

echo "####################################################################"
echo "----------- Installation Databases"
echo "####################################################################"
echo "----------- Installation of sqlite3"
sudo apt install -y sqlite3 libsqlite3-dev
echo -e ">>>>>>>>>>>> End of Installation sqlite3\n"
sleep 2
echo "----------- Installation PostgreSQL"
sudo apt install -y postgresql-14 libpq-dev postgresql-14-postgis-3 libproj-dev proj-bin osm2pgsql osmium-tool
sudo -u postgres psql --command "CREATE ROLE \"`whoami`\" LOGIN createdb;"
echo -e "Copy of pgpass in home directory..."
echo -e ">>>>>>>>>>>> End of Installation PostgreSQL\n"
sleep 2

echo "####################################################################"
echo "------------- Install of Hacking Packages"
echo "####################################################################"
sudo apt install -y net-tools whois nmap traceroute
echo -e ">>>>>>>>>> End of hacking Packages Installation\n"
sleep 2

echo "####################################################################"
echo "------------- Configuration Files"
echo "####################################################################"

echo "------------- Setup vim"
ln -s ~/github/as-consult/setup/vimrc ~/.vimrc
mkdir -p ~/.vim/spell
mkdir -p ~/.vim/plugged
cd ~/.vim/spell
wget http://ftp.vim.org/pub/vim/runtime/spell/fr.utf-8.spl
wget http://ftp.vim.org/pub/vim/runtime/spell/fr.utf-8.sug
wget http://ftp.vim.org/pub/vim/runtime/spell/de.utf-8.spl
wget http://ftp.vim.org/pub/vim/runtime/spell/de.utf-8.sug
sleep 2

echo "------------- Install VIM Plugins"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sleep 2

echo "------------- Setup Aliases"
echo "# Aliases" >> ~/.zshrc
echo 'alias e='exit'' >> ~/.zshrc
echo 'alias c='clear'' >> ~/.zshrc
echo 'alias myip="curl https://ipinfo.io/json"' >> ~/.zshrc
echo 'alias system="inxi -Fxxxxzr"' >> ~/.zshrc
echo 'alias open='nautilus'' >> ~/.zshrc
echo 'alias r-grep="grep -rin --exclude-dir={tmp,log}"'  >> ~/.zshrc
sleep 2

echo "------------- Setup environment variables"
echo "# Environment variables" >> ~/.zshrc
echo 'export EDITOR=vim' >> ~/.zshrc
sleep 2

echo "------------- Setup Git config"
cp ~/github/as-consult/gitconfig ~/.gitconfig
git config --global pull.ff only
sleep 2

echo "####################################################################"
echo "-----------  APT Clean"
echo "####################################################################"
sudo apt update && sudo apt -y upgrade && sudo apt autoclean && sudo apt -y autoremove



