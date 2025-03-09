#!/bin/bash
# This script maps custom files to destinations, backs up existing files, and copies the custom files

set -euo pipefail
cd "$(dirname "$0")"
export base="$(pwd)"

# Define colors
GREEN="\033[0;32m"
RED="\033[0;31m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
YELLOW="\033[1;33m"
MAGENTA="\033[0;35m"
RESET="\033[0m"

# Define custom files to destinations map
declare -A custom_files_map
custom_files_map["arch-packages/illogical-impulse-zsh/.zshrc"]="$HOME/.zshrc"

# Greetings!
cat << 'EOF'
###################################################################################################
|                                                                                                 |
|  Custom Files Mapper                                                                            |
|                                                                                                 |
|  This script will map custom files to their destinations, backing up existing files with .bak   |
|  extension and then copying the custom files to their destinations.                             |
|                                                                                                 |
###################################################################################################
EOF

read -rp "Do you want to continue? [Y/n] " REPLY
echo
if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo -e "${RED}Exiting.${RESET}"
    exit 0
fi

# Process custom files map - backup existing files and copy custom files
echo -e "${CYAN}_____________________________________________________${RESET}"
echo -e "${MAGENTA}Processing custom files map:${RESET}"
for src in "${!custom_files_map[@]}"; do
    dest="${custom_files_map[$src]}"
    echo -e "${BLUE}Mapping $src -> $dest${RESET}"
    
    # Check if source file exists
    if [[ ! -f "$base/$src" ]]; then
        echo -e "${RED}Source file $base/$src does not exist. Skipping...${RESET}"
        continue
    fi
    
    # Backup existing file if it exists
    if [[ -f "$dest" ]]; then
        echo -e "${YELLOW}Backing up existing $dest to ${dest}.bak${RESET}"
        cp -f "$dest" "${dest}.bak"
    fi
    
    # Copy the custom file
    echo -e "${GREEN}Copying $src to $dest${RESET}"
    mkdir -p "$(dirname "$dest")"
    cp -f "$base/$src" "$dest"
done

echo -e "${GREEN}Done. Custom files have been copied to their destinations.${RESET}"