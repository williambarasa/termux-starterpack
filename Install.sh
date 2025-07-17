#!/bin/bash

# Color setup
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

clear

# Display a big friendly banner using figlet, installing if necessary
if ! command -v figlet >/dev/null 2>&1; then
  echo -e "${YELLOW}figlet not found, installing it now for a better banner...${NC}"
  pkg install -y figlet
fi

echo -e "${CYAN}"
figlet "termux-starterpack"
echo -e "${NC}"

echo -e "${YELLOW}Welcome to the Termux Starter Pack Installer!${NC}"
echo ""
echo -e "${RED}Heads up:${NC} This package can use more than 3GB of storage. Make sure you have enough space before continuing."
read -p "Press [ENTER] to continue or [CTRL+C] to cancel..."

echo ""
echo -e "${CYAN}How would you like to install your starter pack?${NC}"
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
minimal_packages=(git python python3 curl wget nano vim proot htop tmux unzip)

if [ "$install_type" = "2" ]; then
  packages=("${minimal_packages[@]}")
elif [ "$install_type" = "3" ]; then
  echo -e "${YELLOW}Awesome! Let's pick your packages.${NC}"
  echo "Type the numbers of the packages you want, separated by spaces. For example: 1 4 7"
  for i in "${!full_packages[@]}"; do
    printf "%2d) %s\n" $((i+1)) "${full_packages[$i]}"
  done
  read -p "Your choices: " choices
  packages=()
  for choice in $choices; do
    idx=$((choice-1))
    if [ "$idx" -ge 0 ] && [ "$idx" -lt "${#full_packages[@]}" ]; then
      packages+=("${full_packages[$idx]}")
    fi
  done
  if [ "${#packages[@]}" -eq 0 ]; then
    echo -e "${RED}No valid choices made. Exiting.${NC}"
    exit 1
  fi
else
  packages=("${full_packages[@]}")
fi

echo ""
echo -e "${GREEN}Starting installation. You'll be asked before each package is installed.${NC}"
echo ""

for pkg in "${packages[@]}"; do
  read -p "Do you want to install ${pkg}? [Y/n]: " answer
  answer=${answer,,} # convert to lowercase
  if [[ "$answer" =~ ^(n|no)$ ]]; then
    echo -e "${YELLOW}Skipping ${pkg}.${NC}"
    continue
  fi
  echo -e "${YELLOW}Installing ${pkg}...${NC}"
  pkg install -y "$pkg"
done

echo ""
echo -e "${GREEN}All done! Your Termux is ready. Thank you for using the Starter Pack!${NC}"
echo -e "${CYAN}If you have questions or suggestions, visit the GitHub repo. Have fun!${NC}