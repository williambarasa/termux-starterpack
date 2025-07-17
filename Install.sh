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

echo -e "${YELLOW}Welcome to the Termux Starter Pack Installer!${NC}"
echo ""
echo -e "${RED}Heads up:${NC} This package can use over 3GB of storage. Make sure you have enough space before continuing."
read -p "Press [ENTER] to continue or [CTRL+C] to cancel the installation..."

echo ""
echo -e "${CYAN}How would you like to install the Starter Pack?${NC}"
echo "1) Full installation (everything, takes more space)"
echo "2) Minimal installation (just the basics, less space)"
echo "3) Manual selection (choose exactly what you want)"
read -p "Enter 1, 2, or 3 [default: 1]: " install_type
install_type=${install_type:-1}

full_packages=(
  git python python2 python3 curl wget tar zip unzip openssl openssh nano vim clang gdb valgrind
  neofetch fzf zsh fish tcsh emacs neovim golang lua54 lua53 lua52 php ruby rust swift proot
  proot-distro hollywood micro htop jython bat lazygit ffmpeg starship xh cmus mpd helix cmatrix
  nmap net-tools screenfetch tmux jq docker kubectl perl kotlin dart
)
minimal_packages=(git python curl wget micro openssh rxfetch zsh lua54 cmus  proot htop tmux unzip)

if [ "$install_type" = "2" ]; then
  packages=("${minimal_packages[@]}")
elif [ "$install_type" = "3" ]; then
  echo -e "${YELLOW}Great! Let's pick your packages.${NC}"
  echo "Type the numbers of the packages you want, separated by spaces. For example: 1 4 7"
  for i in "${!full_packages[@]}"; do
    printf "%2d) %s\n" $((i+1)) "${full_packages[$i]}"
  done
  read -p "Your choices: " choices
  packages=()
  for choice in $choices; do
    idx=$((choice-1))
    [ "$idx" -ge 0 ] && [ "$idx" -lt "${#full_packages[@]}" && packages+=("${full_packages[$idx]}")
  done
  if [ "${#packages[@]}" -eq 0 ]; then
    echo -e "${RED}No valid choices made. Exiting.${NC}"
    exit 1
  fi
else
  packages=("${full_packages[@]}")
fi

echo ""
echo -e "${GREEN}Starting installation of the following packages:${NC}"
echo "${packages[*]}"
echo ""

for pkg in "${packages[@]}"; do
  echo -e "${YELLOW}Installing $pkg...${NC}"
  pkg install -y "$pkg"
done

echo ""
echo -e "${GREEN}All done! Enjoy your new Termux setup. If you have questions or want to suggest improvements, let me know on GitHub!${NC}"