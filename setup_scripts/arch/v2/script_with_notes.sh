#!/bin/bash

#=========================

# list of packages

PACKAGES=(
  "vlc"
#  "blender"
#  "obsidian"
#  "obs-studio"
  "spotify-launcher"
  "discord"
#  "filezilla"
#  "orca-slicer"
#  "protonup-qt"
#   "protonplus"
  "libreoffice-fresh"
  "btop"
  "github-desktop"
)

#=========================

# list of flatpak package

FLATPAK_PACKAGES=(
#  "io.edcd.EDMarketConnector"
)

#=========================

# Track failures
FAILED_PACKAGES=()
FAILED_FLATPAKS=()

#=========================

# Color codes for output
RED='\e[0;31m' # for error
GREEN='\e[0;32m' # for success
NC='\e[0m' # No Color

#=========================

# section for installing and verifying yay and flatpak package manager

echo "## INSTALLING FLATPAK AND YAY..."
sudo pacman -S --noconfirm yay flatpak # install yay and flatpak
sudo pacman -v yay &> /dev/null # verify yay
sudo pacman -v flatpak &> /dev/null # verify flatpak

# package repo and packahe updates
echo "## RUNNING UPDATE AND UPGRADE..."
sudo yay -Syu
sudo flatpak update

#=========================

# install loops

# yay/pacman install loop
echo "## INSTALLING YAY PACKAGES"
for pkg in "${PACKAGES[@]}"; do
    if yay -Qi "$pkg" &> /dev/null; then
        echo "## $pkg is already installed, skipping..."
    else
        echo "## installing $pkg..."
        sudo yay -Sq --needed --noconfirm "${PACKAGES[@]}";
    fi
done
#=========================


# if you are reading this, you just lost the game

# flatpak install loop
for pkg in "${FLATPAK_PACKAGES[@]}"; do
    if flatpak install "$pkg" >/dev/null 2>&1; then
        echo "## $pkg is already installed, skipping..."
    else
        echo "## installing $pkg..."
        sudo flatpak install flathub "${FLATPAK_PACKAGES[@]}" -y --noninteractive;
    fi
done

#=========================

# verify loops

# yay package verification
echo "#============================"
echo "## VERIFYING PACMAN/YAY PACKAGES"
for pkg in "${PACKAGES[@]}"; do
  if yay -Qi "$pkg" &> /dev/null; then
    echo -e "${GREEN} + $pkg ${NC}"
  else
    echo -e "${RED} - $pkg FAILED ${NC}"
    FAILED_PACKAGES+=("$pkg")
  fi
done
echo "#============================"
# flatpak package verficiation
echo "## VERIFYING FLATPAK PACKAGES"
for pkg in "${FLATPAK_PACKAGES[@]}"; do
  if flatpak info "$pkg" >/dev/null 2>&1; then
    echo -e "${GREEN} + $pkg ${NC}"
  else
    echo -e "${RED} - $pkg FAILED ${NC}"
    FAILED_PACKAGES+=("$pkg")
  fi
done
echo "#============================"
#=========================
echo "## FINISHED"
