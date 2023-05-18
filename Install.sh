#!/bin/bash

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
echo '  ____                            _       ____                  '
echo ' / ___|___  _ __  _ __   ___  ___| |_ ___|  _ \  ___  ___ _   _ '
echo '| |   / _ \| `_ \| `_ \ / _ \/ __| __/ _ \ | | |/ _ \/ __| | | |'
echo '| |__| (_) | |_) | |_) |  __/ (__| ||  __/ |_| |  __/\__ \ |_| |'
echo ' \____\___/| .__/| .__/ \___|\___|\__\___|____/ \___||___/\__,_|'
echo '           |_|   |_|                                           '
echo -e "${NC}"

# Essential packages
echo -e "${YELLOW}Installing essential packages...${NC}"
packages=(
    git python python2 python-dev python3 python3-dev curl wget tar zip unzip openssl openssh nano vim build-essential
    clang gdb valgrind libssl-dev libffi-dev libreadline-dev libbz2-dev libsqlite3-dev libncurses5-dev libncursesw5-dev
    zlib1g-dev tk-dev libffi-dev neofetch
)
for package in "${packages[@]}"; do
    echo -ne "${BLUE}Installing ${package}${NC}"
    $sudo apt-get install -y "$package" > /dev/null 2>&1 &
    pid=$!
    i=0
    spin='-\|/'
    while kill -0 "$pid" 2>/dev/null; do
        i=$(( (i+1) % 4 ))
        printf "\r${BLUE}Installing ${package}...${spin:$i:1}${NC}"
        sleep 0.1
    done
    if [ $? -eq 0 ]; then
        echo -e "\r${BLUE}Installing ${package}...${GREEN}Done!${NC}"
    else
        echo -e "\r${BLUE}Installing ${package}...${RED}Failed!${NC}"
    fi
done

# Front-end dev packages
echo -e "${YELLOW}Installing front-end development packages...${NC}"
frontend_packages=(
    nodejs npm yarn
    # Add more front-end packages here
    webpack gulp grunt
)
for package in "${frontend_packages[@]}"; do
    echo -ne "${BLUE}Installing ${package}${NC}"
    $sudo apt-get install -y "$package" > /dev/null 2>&1 &
    pid=$!
    i=0
    spin='-\|/'
    while kill -0 "$pid" 2>/dev/null; do
        i=$(( (i+1) % 4 ))
        printf "\r${BLUE}Installing ${package}...${spin:$i:1}${NC}"
        sleep 0.1
   
