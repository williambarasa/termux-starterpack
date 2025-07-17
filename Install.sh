#!/bin/bash

# Color setup
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

clear

# Figlet banner (auto-install if needed)
if ! command -v figlet >/dev/null 2>&1; then
  echo -e "${YELLOW}figlet not found, installing it now...${NC}"
  pkg install -y figlet
fi

echo -e "${CYAN}"
figlet "termux-starterpack"
echo -e "${NC}"

echo -e "${YELLOW}Welcome to the Termux Starter Pack Installer!${NC}"
echo
echo -e "${RED}Heads up:${NC} This package can use more than 3GB of storage. Make sure you have enough space before continuing."
read -p "Press [ENTER] to continue or [CTRL+C] to cancel..."

echo
echo -e "${CYAN}Manual selection mode: Choose the packages you want!${NC}"
full_packages=(
  git python python2 python3 curl wget tar zip unzip openssl openssh nano vim clang gdb valgrind
  neofetch fzf zsh fish tcsh emacs neovim golang lua54 lua53 lua52 php ruby rust swift proot
  proot-distro hollywood micro htop jython bat lazygit ffmpeg starship xh cmus mpd helix cmatrix
  nmap net-tools screenfetch tmux jq docker kubectl perl kotlin dart
)

for i in "${!full_packages[@]}"; do
  printf "%2d) %s\n" $((i+1)) "${full_packages[$i]}"
done

echo
echo -e "${YELLOW}Type the numbers of the packages you want, separated by spaces (e.g., 1 4 7):${NC}"
read -p "Your choices: " choices

# Build list of selected packages
selected_packages=()
for choice in $choices; do
  idx=$((choice-1))
  if [ "$idx" -ge 0 ] && [ "$idx" -lt "${#full_packages[@]}" ]; then
    selected_packages+=("${full_packages[$idx]}")
  fi
done

if [ "${#selected_packages[@]}" -eq 0 ]; then
  echo -e "${RED}No valid choices made. Exiting.${NC}"
  exit 1
fi

echo
echo -e "${GREEN}You'll be asked before each selected package is installed.${NC}"
echo

for pkg in "${selected_packages[@]}"; do
  read -p "Do you want to install ${pkg}? [Y/n]: " answer
  answer=${answer,,}
  if [[ "$answer" =~ ^(n|no)$ ]]; then
    echo -e "${YELLOW}Skipping ${pkg}.${NC}"
    continue
  fi
  echo -e "${YELLOW}Installing ${pkg}...${NC}"
  pkg install -y "$pkg"
done

echo
echo -e "${GREEN}All done! Your Termux is ready. Thank you for using the Starter Pack!${NC}"
echo -e "${CYAN}If you have questions or suggestions, visit the GitHub repo. Have fun!${NC}"