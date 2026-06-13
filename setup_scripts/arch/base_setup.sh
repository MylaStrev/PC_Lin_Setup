#!/bin/bash

PACKAGES=(
#  "flatpak"
  "vlc"
#  "blender"
#  "obsidian"
#  "obs-studio"
  "spotify-launcher"
  "discord"
#  "filezilla"
#  "orca-slicer"
#  "protonup-qt"
#  "protonplus"
  "libreoffice-fresh"
  "github-desktop"
)

FLATPAK_PACKAGES=(
#  "io.edcd.EDMarketConnector"
)

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track failures
FAILED_PACKAGES=()
FAILED_FLATPAKS=()

echo "## INSTALLING YAY..."
sudo pacman -S --noconfirm yay
# Verify yay installation
if ! command -v yay &> /dev/null; then
    echo -e "${RED}✗ YAY installation failed${NC}"
    exit 1
else
    echo -e "${GREEN}✓ YAY installed successfully${NC}"
fi

echo "## INSTALLING PACMAN PACKAGES"

for pkg in "${PACKAGES[@]}"; do
    if pacman -Qi "$pkg" &> /dev/null; then
        echo "## $pkg is already installed, skipping..."
    else
        echo "## installing $pkg..."
        sudo yay -S --needed --noconfirm "${PACKAGES[@]}"
    fi
done

echo "## INSTALLING FLATPAK PACKAGES"

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

# Verify all pacman packages
echo ""
echo "## VERIFYING PACMAN PACKAGES..."
for pkg in "${PACKAGES[@]}"; do
    if pacman -Qi "$pkg" &> /dev/null; then
        echo -e "${GREEN}✓ $pkg${NC}"
    else
        echo -e "${RED}✗ $pkg - FAILED${NC}"
        FAILED_PACKAGES+=("$pkg")
    fi
done

# Verify all flatpak packages
echo ""
echo "## VERIFYING FLATPAK PACKAGES..."
for pkg in "${FLATPAK_PACKAGES[@]}"; do
    if flatpak info "$pkg" >/dev/null 2>&1; then
        echo -e "${GREEN}✓ $pkg${NC}"
    else
        echo -e "${RED}✗ $pkg - FAILED${NC}"
        FAILED_FLATPAKS+=("$pkg")
    fi
done

# Final summary
echo "========================================"
if [ ${#FAILED_PACKAGES[@]} -eq 0 ] && [ ${#FAILED_FLATPAKS[@]} -eq 0 ]; then
    echo -e "${GREEN}✓ ALL INSTALLATIONS COMPLETED SUCCESSFULLY${NC}"
    echo "========================================"
    exit 0
else
    echo -e "${RED}✗ SOME INSTALLATIONS FAILED${NC}"
    if [ ${#FAILED_PACKAGES[@]} -gt 0 ]; then
        echo -e "${RED}Failed pacman packages:${NC}"
        for pkg in "${FAILED_PACKAGES[@]}"; do
            echo "  - $pkg"
        done
    fi
    if [ ${#FAILED_FLATPAKS[@]} -gt 0 ]; then
        echo -e "${RED}Failed flatpak packages:${NC}"
        for pkg in "${FAILED_FLATPAKS[@]}"; do
            echo "  - $pkg"
        done
    fi
    echo "========================================"
    exit 1
fi
