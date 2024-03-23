#!/usr/bin/bash

echo "-------------------------------------------------------"
echo "--- zsh + Oh-my-zsh installation - Part 1"
echo "-------------------------------------------------------"

# Installation zsh
sudo apt install -y git curl zsh

# Installation Oh-my-zsh
echo "----------- Installation Oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
