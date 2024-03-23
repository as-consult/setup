#!/usr/bin/bash

echo "-------------------------------------------------------"
echo "--- zsh + Oh-my-zsh installation - Part 2"
echo "-------------------------------------------------------"

echo "----------- Install zsh-syntax-highlighting"
cd $ZSH/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting

echo "Changing the theme"
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="af-magic"/g' ~/.zshrc

echo "Activation of plugins"
sed -i 's/plugins=(git)/plugins=(gitfast last-working-dir zsh-syntax-highlighting ssh-agent)/g' ~/.zshrc

echo -e "Installation complete"
exec zsh
