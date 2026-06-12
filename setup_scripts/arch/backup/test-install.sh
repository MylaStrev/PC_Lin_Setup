#!/bin/bash

# colour codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;32m'
NC='\033[0m'

# package lists
PACKAGES=(
#  "vlc"
#  "blender"
  "obsidian"
#  "obs-studio"
  "spotify-launcher"
  "discord"
#  "filezilla"
#  "orca-slicer"
#  "protonup-qt"
#  "protonplus"
  "libreoffice-fresh"
  "btop"
  "github-desktop"
)

#FLATPAK_PACKAGES=(
#  "io.edcd.EDMarketConnector"
#)

NEEDED_PACKAGES=(
#  "flatpak"
  "yay"
)

# installing yay and flatpak
for pkg in "${NEEDED_PACKAGES[@]}"; do
    if pacman -Qi "$pkg" &> /dev/null; then
        echo "## $pkg is already installed, skipping..."
    else
        echo "## installing $pkg..."
        sudo pacman -S "${NEEDED_PACKAGES[@]}" --needed --noconfirm
    fi
done

#package install scripts
echo "## INSTALLING PACMAN PACKAGES"

for pkg in "${PACKAGES[@]}"; do
    if pacman -Qi "$pkg" &> /dev/null; then
        echo "## $pkg is already installed, skipping..."
    else
        echo "## installing $pkg..."
        yay -S --needed --noconfirm "${PACKAGES[@]}"
    fi
done

#for pkg in "${FLATPAK_PACKAGES[@]}"; do
#    if flatpak info "$pkg" >/dev/null 2>&1; then
#        echo "## $pkg is already installed, skipping..."
#    else
#        echo "## installing $pkg..."
#        sudo flatpak install flathub "${FLATPAK_PACKAGES[@]}" -y --noninteractive
#        echo "## $pkg install command complete"
#    fi
#done

echo "## RUNNING UPDATE AND UPGRADE..."
sudo pacman -Syu
yay -Syu
#sudo flatpak update

echo "## INSTALL COMPLETE!"
