#!/bin/bash

# Exit script on errors
set -e

# Check if the script is being run as root
if [ "$(id -u)" = "0" ]; then
  echo "Please do not run this script as root. Exiting..."
  exit 1
fi

echo "Starting the setup process..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # Reset color

# Display a logo
echo -e "${RED}"
cat << 'EOF'
  ______                                    _____ __             __                             __  
 /_  __/__  _________ ___  __  ___  __     / ___// /_____ ______/ /____  _________  ____ ______/ /__
  / / / _ \/ ___/ __ `__ \/ / / / |/_/_____\__ \/ __/ __ `/ ___/ __/ _ \/ ___/ __ \/ __ `/ ___/ //_/
 / / /  __/ /  / / / / / / /_/ />  </_____/__/ / /_/ /_/ / /  / /_/  __/ /  / /_/ / /_/ / /__/ ,<   
/_/  \___/_/  /_/ /_/ /_/\__,_/_/|_|     /____/\__/\__,_/_/   \__/\___/_/  / .___/\__,_/\___/_/|_|  
                                                                          /_/                       
EOF
echo -e "${NC}"

# Update and upgrade packages
pkg up -y
pkg upgrade -y
echo -e "${YELLOW}Installing essential packages...${NC}"

# Install package repos 
pkg in x11-repo
pkg in root-repo 

# List of packages to install
packages=(
  git python python2 python3 curl wget tar zip unzip openssl openssh nano vim clang gdb valgrind
  neofetch fzf zsh fish tcsh emacs neovim golang lua54 lua53 lua52 php ruby rust swift proot
  proot-distro hollywood micro htop jython bat lazygit ffmpeg starship xh cmus mpd helix cmatrix
  nmap net-tools screenfetch tmux jq docker kubectl terraform perl kotlin dart
)

# Install packages
for pkg in "${packages[@]}"; do
  echo -e "${BLUE}Installing $pkg...${NC}"
  if pkg install -y "$pkg" > /dev/null 2>&1; then
    echo -e "${GREEN}$pkg installed successfully!${NC}"
  else
    echo -e "${RED}Failed to install $pkg. Exiting...${NC}"
    exit 1
  fi
done

# Install Node.js and Yarn
echo -e "${YELLOW}Installing Node.js and Yarn...${NC}"
dev_packages=(nodejs yarn)
for pkg in "${dev_packages[@]}"; do
  echo -e "${BLUE}Installing $pkg...${NC}"
  if pkg install -y "$pkg" > /dev/null 2>&1; then
    echo -e "${GREEN}$pkg installed successfully!${NC}"
  else
    echo -e "${RED}Failed to install $pkg. Exiting...${NC}"
    exit 1
  fi
done

echo -e "${GREEN}Setup is complete!${NC}"