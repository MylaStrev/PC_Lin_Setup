#!/bin/bash

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
        sudo yay -S --needed --noconfirm "${PACKAGES[@]}"
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
sudo yay -Syu
#sudo flatpak update

echo "## INSTALL COMPLETE!"
