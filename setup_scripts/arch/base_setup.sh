#!/bin/bash

PACKAGES=(
  "flatpak"
  "vlc"
  "blender"
  "obsidian"
  "obs-studio"
  "spotify-launcher"
  "discord"
#  "filezilla"
  "orca-slicer"
  "protonup-qt"
  "protonplus"

)

FLATPAK_PACKAGES=(
  "io.edcd.EDMarketConnector"

)

echo "## INSTALLING YAY..."
sudo pacman -S --noconfirm yay

echo "## INSTALLING PACMAN PACKAGES"

for pkg in "${PACKAGES[@]}"; do
    if pacman -Qi "$pkg" &> /dev/null; then
        echo "## $pkg is already installed, skipping..."
    else
        echo "## installing $pkg..."
        sudo yay -S --needed --noconfirm "${PACKAGES[@]}"
    fi
done

for pkg in "${FLATPAK_PACKAGES[@]}"; do
    if flatpak info "$pkg" >/dev/null 2>&1; then
        echo "## $pkg is already installed, skipping..."
    else
        echo "## installing $pkg..."
        sudo flatpak install flathub "${FLATPAK_PACKAGES[@]}" -y --noninteractive
    fi
done

echo "## RUNNING UPDATE AND UPGRADE..."
sudo yay -Syu
sudo flatpak update

echo "## ALL DONE"
