#!/bin/bash

set -e

# Check if script is run as root
if [ "$(id -u)" = "0" ]; then
  echo "This script should not be run as root. Exiting..."
  exit 1
fi

# Check if visudo file exists
if [ ! -f "/etc/sudoers.d/README" ]; then
  echo "Warning: visudo file not found. Some packages may not be installed."
  sudo=""
else
  sudo="sudo"
fi

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Display ASCII logo
echo -e "${RED}"
echo '  ______                                    _____ __             __                             __  '
echo ' /_  __/__  _________ ___  __  ___  __     / ___// /_____ ______/ /____  _________  ____ ______/ /__'
echo '  / / / _ \/ ___/ __ `__ \/ / / / |/_/_____\__ \/ __/ __ `/ ___/ __/ _ \/ ___/ __ \/ __ `/ ___/ //_/'
echo ' / / /  __/ /  / / / / / / /_/ />  </_____/__/ / /_/ /_/ / /  / /_/  __/ /  / /_/ / /_/ / /__/ ,<   '
echo '/_/  \___/_/  /_/ /_/ /_/\__,_/_/|_|     /____/\__/\__,_/_/   \__/\___/_/  / .___/\__,_/\___/_/|_|  '
echo '                                                                          /_/                       '
echo -e "${NC}"

# Essential packages
pkg up -y
pkg upgrade -y
echo -e "${YELLOW}Installing Starter Package...${NC}"
essential_packages=(
  git python python2 python3 curl wget tar zip unzip openssl openssh nano vim build-essential
  clang gdb valgrind
  neofetch fzf zsh fish
  tcsh emacs neovim golang ecj 
  lua54 lua53 lua52 php ruby rust swift 
  proot proot-distro hollywood  
)
for package in "${essential_packages[@]}"; do
  echo -ne "${BLUE}Installing ${package}${NC}"
  $sudo apt-get install -y "$package" > /dev/null 2>&1 || (echo -e "\r${BLUE}Installing ${package}...${RED}Failed!${NC}" && exit 1)
  echo -e "\r${BLUE}Installing ${package}...${GREEN}Done!${NC}"
done

# Node-Js and Yarn
echo -e "${YELLOW}Installing extra development packages...${NC}"
frontend_dev_packages=(
  nodejs yarn
)
for package in "${frontend_dev_packages[@]}"; do
  echo -ne "${BLUE}Installing ${package}${NC}"
  $sudo apt-get install -y "$package" > /dev/null 2>&1 || (echo -e "\r${BLUE}Installing ${package}...${RED}Failed!${NC}" && exit 1)
  echo -e "\r${BLUE}Installing ${package}...${GREEN}Done!${NC}"
done
