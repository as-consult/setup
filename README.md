# Introduction
This guide is to configure a debian based development environment using Ruby on Rails.

# Step by step guide
## Customization
Visit https://extensions.gnome.org, and install the bowser extension.
Install:
- Blur my Shell
- Dash to Dock

Bring minimize buttons back:
`gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"`

## Missing drivers
In case of missing drivers, try:
````bash
sudo apt install firmware-iwlwifi
sudo apt install bluez-firmwar
````

## Install setup github project
````bash
mkdir -p ~/github/as-consult
cd ~/github/as-consult
sudo apt install git
git clone https://github.com/as-consult/setup
cd setup
````

## SSH Keys
- You have already a pair of keys:
  - Copy them into ~/.ssh
````bash
sudo chmod 600 ~/.ssh/id_ed25519
eval "$(ssh-agent -s)"
````

- You don't have, so you generate new ones:
`ssh-keygen -t ed25519`

## Install Zsh shell
`~/github/as-consult/setup/install-zsh_1_2.sh`
reboot computer
`~/github/as-consult/setup/install-zsh_2_2.sh`
reboot terminal

## Install required packages and setups
`~/github/as-consult/setup/install-packages.sh`

## Additional setup
### Postgresql credentials
Create your postgres credentials in your home directory:
````bash
touch ~/.pgpass
sudo chmod 600 ~/.pgpass
````

## Install Rbenv
`~/github/as-consult/setup/rbenv_install_1_2.sh`
relaunch terminal
`~/github/as-consult/setup/rbenv_install_2_2.sh`

## Activate Vim plugins
Launch vim and enter: :PlugInstall

## gitconfig
`cp ~/github/as-consult/setup/gitconfig ~/.gitconfig`






