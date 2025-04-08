#!/bin/bash

# ayak üstü düzelticem diye bacağıma kramp girdi
# Hyprland Installation Script for Arch Linux
# This script installs Hyprland and its dependencies on Arch Linux


# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}Starting Hyprland installation...${NC}"

# Check if running as root
if [ "$EUID" -eq 0 ]; then 
    echo -e "${RED}Please run this script as a normal user, not as root${NC}"
    exit 1
fi

# Install required packages
echo -e "${GREEN}Installing required packages...${NC}"
sudo pacman -S --needed \
    hyprland \
    waybar \
    wofi \
    kitty \
    swaybg \
    swayidle \
    wl-clipboard \
    polkit-kde-agent \
    network-manager-applet \
    blueman \
    thunar \
    gvfs \
    file-roller \
    xdg-desktop-portal-hyprland \
    xdg-desktop-portal-gtk \
    xdg-desktop-portal \
    qt5-wayland \
    qt6-wayland \
    gtk3 \
    nvidia-utils \
    nvidia-settings \
    xorg-xwayland \
    --noconfirm

# Create necessary directories
echo -e "${GREEN}Creating configuration directories...${NC}"
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/wofi
mkdir -p ~/.config/kitty
mkdir -p ~/.config/swaybg

# Copy configuration files
echo -e "${GREEN}Copying configuration files...${NC}"
cp -r hypr/* ~/.config/hypr/
cp -r waybar/* ~/.config/waybar/

# Set up environment variables
echo -e "${GREEN}Setting up environment variables...${NC}"
cat << EOF > ~/.config/environment.d/envvars.conf
XDG_CURRENT_DESKTOP=Hyprland
XDG_SESSION_DESKTOP=Hyprland
XDG_SESSION_TYPE=wayland
XDG_SESSION_CLASS=user
QT_QPA_PLATFORM=wayland
QT_WAYLAND_DISABLE_WINDOWDECORATION=1
GDK_BACKEND=wayland
MOZ_ENABLE_WAYLAND=1
EOF

# Add Hyprland to display manager
echo -e "${GREEN}Adding Hyprland to display manager...${NC}"
sudo mkdir -p /usr/share/wayland-sessions/
sudo tee /usr/share/wayland-sessions/hyprland.desktop << EOF
[Desktop Entry]
Name=Hyprland
Comment=An intelligent dynamic tiling Wayland compositor
Exec=Hyprland
Type=Application
EOF

echo -e "${GREEN}Installation completed!${NC}"
echo -e "${GREEN}Please log out and select Hyprland from your display manager to start using it.${NC}"
echo -e "${GREEN}If you encounter any issues, check the logs at ~/.local/share/hypr/hyprland.log${NC}" 