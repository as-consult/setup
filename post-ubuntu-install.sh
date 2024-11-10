#!/usr/bin/bash
#     _    ____  
#    / \  / ___|   Alexandre Stanescot
#   / _ \ \___ \   http://alexstan67.github.io/profile/
#  / ___ \ ___) |  https://github.com/alexstan67/
# /_/   \_\____/ 
#
# Date:	   30/09/2024
# Update:  08/10/2024
# Title: Post installation script after Ubuntu-24.04.1-LTS fresh install
# Download manually this file from https://github.com/as-consult/setup
# make it executable and execute it.

echo "####################################################################"
echo "----------- Create directories and update/upgrade APT"
echo "####################################################################"
mkdir ~/github ~/apps ~/VMs
sudo apt update && sudo apt -y upgrade

echo "####################################################################"
echo "----------- Install APT Packages"
echo "####################################################################"
sudo apt install -y git gh usb-creator-gtk python3-pip vim lynx tree gimp \
                    imagemagick vlc inkscape qalc gpick exiv2 easytag figlet \
                    mat2 kleopatra neofetch qrencode xournalpp font-manager \
                    testdisk openscad librecad stellarium nextcloud-desktop \
                    nautilus-nextcloud qemu-system virt-manager bridge-utils \
                    zsh curl net-tools whois nmap traceroute transmission \
                    metadata-cleaner timeshift pdftk postgresql-client \
                    gnome-browser-connector vim-gtk3 simple-scan sqlite3 \
                    libreoffice
# testdisk  = recovery tool
# pdftk     = manage pdf (concat, ..) https://www.pdflabs.com/docs/pdftk-cli-examples/
# qrencode  = generate a qr code, c.f. qrencode -o "wef" -s 6 -l H -m 2 "https://weekend-fly.com"
# xournalpp = pdf annotations
sleep 2

echo "####################################################################"
echo "-----------  Install SNAP Packages"
echo "####################################################################"
sudo snap install postman thunderbird brave cherrytree projectlibre \
                  cups marble torrhunt signal-desktop podcasts slack
sudo snap install obsidian --classic
sleep 2

echo "####################################################################"
echo "-----------  Install Docker"
echo "####################################################################"
# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# install latest version
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin \
                    docker-compose-plugin

# Post-install to run docker as non-root
#sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# Configure Docker to start on boot with systemd
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sleep 2

echo "####################################################################"
echo "------------- Configuration Files"
echo "####################################################################"

echo "------------- Clone github/as-consult/setup repo"
mkdir -p ~/github/as-consult && cd ~/github/as-consult
git clone https://github.com/as-consult/setup.git
echo "------------- Setup vim"
ln -s ~/github/as-consult/setup/config/vimrc ~/.vimrc
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

echo "------------- Setup OH-MY-ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sleep 2

echo "------------- Setup environment variables"
echo "# Environment variables" >> ~/.zshrc
echo 'export EDITOR=vim' >> ~/.zshrc
sleep 2

echo "------------- Setup Aliases"
echo "# Aliases" >> ~/.zshrc
echo 'alias e='exit'' >> ~/.zshrc
echo 'alias myip="curl https://ipinfo.io/json"' >> ~/.zshrc
echo 'alias r-grep="grep -rin --exclude-dir={tmp,log}"'  >> ~/.zshrc
echo 'alias docked-rails-console="docker compose exec --user 1000 -it rails-app rails console"'  >> ~/.zshrc
echo 'alias docked-rails-test="docker compose exec --user 1000 -it rails-app rails test"'  >> ~/.zshrc
echo 'alias docked-rails-bash="docker compose exec --user 1000 -it rails-app bash"'  >> ~/.zshrc
sleep 2

echo "------------- Setup oh-my-zsh plugin"
mkdir -p ~/.oh-my-zsh/plugins
cd ~/.oh-my-zsh/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting

sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="af-magic"/g' ~/.zshrc
sed -i 's/plugins=(git)/plugins=(gitfast last-working-dir zsh-syntax-highlighting ssh-agent)/g' ~/.zshrc

echo "------------- Setup git config"
ln -s ~/github/as-consult/setup/config/gitconfig ~/.gitconfig
git config --global pull.ff only
sleep 2

echo "------------- Setup Lynx"
sudo chmod 777 /etc/lynx/lynx.cfg
echo 'ACCEPT_ALL_COOKIES:TRUE' >> /etc/lynx/lynx.cfg
sleep 2

echo "------------- Install Ledger Nano S USB Support"
wget -q -O - https://raw.githubusercontent.com/LedgerHQ/udev-rules/master/add_udev_rules.sh | sudo bash
sudo add-apt-repository universe
sudo apt install -y libfuse2
sudo apt install -y libfuse3-3
sleep 2

echo "------------- Setup Hosts"
sudo chown alex:root /etc/hosts
echo '192.168.77.16	 nas-001' >> /etc/hosts
echo '192.168.77.19	 mac-001' >> /etc/hosts
echo '54.37.152.178  vps-001' >> /etc/hosts
echo '51.210.106.100 vps-002' >> /etc/hosts
echo '141.94.17.140  vps-003' >> /etc/hosts
sleep 2

echo "------------- Setup Firewall"
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw allow 80      #http
sudo ufw allow 443     #https
sudo ufw allow 22      #ssh
sudo ufw allow 993     #imaps
sudo ufw allow 25      #smtp
sudo ufw enable
sleep 2

echo "------------- Setup crontab -e"
crontab ~/github/as-consult/setup/config/crontab_purge  #To purge logs
sleep 2

echo "------------- Download Samsung SCX-470 Drivers"
cd ~/Downloads && wget https://ftp.hp.com/pub/softlib/software13/printers/SS/SL-M4580FX/uld_V1.00.39_01.17.tar.gz 

echo "------------- Install templates"
# Ensure directories exists
mkdir -p ~/snap/libreoffice/current/.config/libreoffice/4/user/config
mkdir -p ~/.config/inkscape/palettes
mkdir -p ~/Templates
# Variables
libreoffice_folder=~/snap/libreoffice/current/.config/libreoffice/4/user/config
inkscape_folder=~/.config/inkscape/palettes
# Inkscape
ln -s ~/github/as-consult/setup/templates/as-consult.gpl $inkscape_folder/as-consult
ln -s ~/github/as-consult/setup/templates/wef_2023.gpl $inkscape_folder/wef_2023.gpl
ln -s ~/github/as-consult/setup/templates/sky-unlimited.gpl $inkscape_folder/sky-unlimited.gpl
# Libreoffice color schemes
ln -s ~/github/as-consult/setup/templates/as-consult.soc $libreoffice_folder/as-consult.soc
ln -s ~/github/as-consult/setup/templates/wef_2023.soc $libreoffice_folder/wef_2023.soc
ln -s ~/github/as-consult/setup/templates/sky-unlimited.soc $libreoffice_folder/wef_2023.soc
# Libreoffice Templates
ln -s ~/github/as-consult/setup/templates/SKUN-L.ott ~/Templates/SKUN-L.ott
ln -s ~/github/as-consult/setup/templates/SKUN-P.otp ~/Templates/SKUN-P.otp

echo "####################################################################"
echo "-----------  APT Clean"
echo "####################################################################"
sudo apt update && sudo apt -y upgrade && sudo apt autoclean && \
sudo apt -y autoremove

########################################################################
# Things to do after install !!!
########################################################################
# Ethernet Card Tuxedo
  # MEDIATEK Corp device 0688
  # Kernel Driver in use: mt7921e
# Launch :PlugInstall in vim
# Configure Printers
  # Home Printer
	  # sudo vim /etc/sane.d/xerox_mfp.conf
	  # Remplacer sous l'imprimante Samsung SCX-470 le usb par: tcp 192.168.77.21
    # Printers / add
    # Network printer / LPD/LPR / 192.168.77.21
    # Search for a printer driver to download -> Samsung scx
  # Work Printer
    # sudo dpkg -i /home/alex/SynologyDrive/alex/driver/cque-en-4.0-11.x86_64.deb
    # add printer: socket://192.168.128.250:9100
    # Canon iR-ADV-C3525/3550 PCL
# dns nameservers
  # Add one of following servers in network setup
  # FDN:      80.67.169.12,80.67.169.40
  # OPENDNS:  208.67.222.222,208.67.220.220
# Configure Synology VPN
# Install tor
  # https://www.torproject.org/download/
  # Extract into ~/apps
  # ./start-tor-browser.desktop --register-app
# Inskape
  # Preferences/Themes/Icon Theme: Multicolor
# DisplayLink for docking station
  # https://github.com/AdnanHodzic/displaylink-debian
