#!/bin/bash

# Script to copy custom files with direct paths using a mapping system
base="$(pwd)"
echo "Current directory: $base"

# Define colors for output
GREEN="\033[0;32m"
RED="\033[0;31m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
YELLOW="\033[1;33m"
RESET="\033[0m"

# Define the mapping of source files to destination paths
# Format: source path relative to repo root -> destination absolute path
declare -A FILE_MAPPINGS=(
    ["arch-packages/illogical-impulse-zsh/.zshrc"]="$HOME/.zshrc"
    ["arch-packages/illogical-impulse-zsh/.zprofile"]="$HOME/.zprofile"
    ["Extras/swaylock/config"]="$XDG_CONFIG_HOME/swaylock/config"
    # Add more mappings here as needed
    # ["path/to/source"]="path/to/destination"
)

# Function to copy a single file
copy_file() {
    local src="$1"
    local dest="$2"
    local src_path="$base/$src"
    
    echo -e "${BLUE}Copying $src to $dest...${RESET}"
    echo "Source: $src_path"
    echo "Destination: $dest"
    
    if [ -f "$src_path" ]; then
        # Create backup if the destination file exists
        if [ -f "$dest" ]; then
            cp -f "$dest" "$dest.backup"
            echo -e "${YELLOW}Created backup at $dest.backup${RESET}"
        fi
        
        # Create destination directory if it doesn't exist
        mkdir -p "$(dirname "$dest")"
        
        # Copy the file
        cp -fv "$src_path" "$dest"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Successfully copied file${RESET}"
        else
            echo -e "${RED}Failed to copy file${RESET}"
        fi
    else
        echo -e "${RED}Source file not found: $src_path${RESET}"
        # List directory contents for debugging
        echo "Contents of directory:"
        ls -la "$(dirname "$src_path")"
    fi
    
    echo -e "${CYAN}--------------------------------------------------${RESET}"
}

# Main process - loop through all mappings and copy files
echo -e "${CYAN}====================================================${RESET}"
echo -e "${CYAN}Starting custom file copy process${RESET}"
echo -e "${CYAN}====================================================${RESET}"

for src in "${!FILE_MAPPINGS[@]}"; do
    dest="${FILE_MAPPINGS[$src]}"
    copy_file "$src" "$dest"
done

echo -e "${GREEN}Finished copying all custom files.${RESET}"