#!/usr/bin/bash
#     _    ____  
#    / \  / ___|   Alexandre Stanescot
#   / _ \ \___ \   http://alexstan67.github.io/profile/
#  / ___ \ ___) |  https://github.com/alexstan67/
# /_/   \_\____/ 
#
# Date:	   23/03/2024
# Update:  23/03/2024
# Title: Installation script after ebian 12 fresh install 

echo "####################################################################"
echo "----------- Installation General Packages"
echo "####################################################################"
sudo apt install -y vim vim-gtk3 lynx tree gimp imagemagick libaio1 hardinfo vlc traceroute heif-gdk-pixbuf heif-thumbnailer libheif1:amd64 inkscape exfat-fuse qalc gpick exiv2 gnome-clocks libavcodec-extra easytag figlet mat2 kleopatra testdisk pdftk simplescreenrecorder neofetch qrencode xournal thunderbird
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
sudo apt autoremove evolution

# Packages for work
echo "####################################################################"
echo "------------- Install of Work Packages"
echo "####################################################################"
sudo apt install -y cifs-utils nautilus-nextcloud nextcloud-desktop
echo -e ">>>>>>>>>> End of Work Packages Installation\n"
sleep 2

echo "####################################################################"
echo "-----------  Third Party Installations"
echo "####################################################################"

# CherryTree
echo "------------- Install CherryTree"
sudo add-apt-repository ppa:giuspen/ppa
sudo apt update && sudo apt install -y cherrytree
sleep 2

# DBeaver
echo "------------- Install DBeaver"
cd ~/Downloads
wget "https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb"
sudo dpkg -i dbeaver-ce_latest_amd64.deb
sleep 2

# AppImageLauncher
echo "------------- Install AppImageLauncher"
sudo apt install software-properties-common
sudo add-apt-repository ppa:appimagelauncher-team/stable
sudo apt update
sudo apt install -y appimagelauncher
sleep 2

# QGIS Installation
echo "------------- Install QGIS"
sudo apt-get install python-software-properties
sudo add-apt-repository ppa:ubuntugis/ppa
sudo apt update && apt install qgis qgis-plugin-grass
sleep 2

echo "------------- Install Brave Browser"
sudo apt install curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser
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
sudo apt install -y net-tools whois nmap
echo -e ">>>>>>>>>> End of hacking Packages Installation\n"
sleep 2

echo "####################################################################"
echo "------------- Configuration Files"
echo "####################################################################"
echo "------------- Setup Lynx"
sudo chmod 777 /etc/lynx/lynx.cfg
sudo echo 'ACCEPT_ALL_COOKIES:TRUE' >> /etc/lynx/lynx.cfg

echo "------------- Setup vim"
ln -s ~/github/as-consult/vimrc ~/.vimrc
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

echo "------------- Setup Firewall"
sudo ufw app list
sudo ufw default allow outgoing
sudo ufw allow http
sudo ufw allow https
sudo ufw allow ssh
sudo ufw allow imaps
sudo ufw allow smtp
sudo ufw allow ipp    #printers
sudo ufw allow postgresql
sudo ufw enable
sudo ufw status

echo "------------- Setup Aliases"
echo "# Aliases" >> ~/.zshrc
echo "alias meteo='curl wttr.in'" >> ~/.zshrc
echo 'alias e='exit'' >> ~/.zshrc
echo 'alias c='clear'' >> ~/.zshrc
echo 'alias myip="curl https://ipinfo.io/json"' >> ~/.zshrc
echo 'alias system="inxi -Fxxxxzr"' >> ~/.zshrc
echo 'alias mint="neofetch"' >> ~/.zshrc
echo "alias lynx-ddg='lynx www.duckduckgo.com'" >> ~/.zshrc
echo 'alias open='nautilus'' >> ~/.zshrc
echo 'alias r-grep="grep -rin --exclude-dir={tmp,log}"'
sleep 2

echo "------------- Setup environment variables"
echo "# Environment variables" >> ~/.zshrc
echo 'export EDITOR=vim' >> ~/.zshrc
sleep 2

echo "------------- Setup Git config"
cp ~/github/as-consult/gitconfig ~/.gitconfig
git config --global pull.ff only
sleep 2

echo "------------- Setup crontab -e"
crontab ~/github/as-consult/setup/crontab_purge  #To purge logs
sleep 2

echo "####################################################################"
echo "-----------  APT Clean"
echo "####################################################################"
sudo apt update && sudo apt -y upgrade && sudo apt autoclean && sudo apt -y autoremove



