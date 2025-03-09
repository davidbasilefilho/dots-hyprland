#!/bin/bash

# Force copy the .zshrc file from the repository to the home directory
# No checks, no backups (unless specified), just copy it

# Define colors for output
GREEN="\033[0;32m"
RED="\033[0;31m"
BLUE="\033[0;34m"
RESET="\033[0m"

echo -e "${BLUE}Force copying .zshrc file...${RESET}"

# Get the script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_FILE="$SCRIPT_DIR/arch-packages/illogical-impulse-zsh/.zshrc"
DEST_FILE="$HOME/.zshrc"

# Create backup if requested
if [[ "$1" == "--backup" || "$1" == "-b" ]]; then
  echo -e "${BLUE}Creating backup of existing .zshrc...${RESET}"
  cp -f "$DEST_FILE" "$DEST_FILE.backup" 2>/dev/null
fi

# Remove the old file first to ensure clean copy
echo -e "${BLUE}Removing old .zshrc (if exists)...${RESET}"
rm -f "$DEST_FILE"

# Copy the file forcefully
echo -e "${BLUE}Copying new .zshrc...${RESET}"
cp -f "$SOURCE_FILE" "$DEST_FILE"

# Check if copy was successful
if [[ $? -eq 0 ]]; then
  echo -e "${GREEN}SUCCESS: .zshrc has been forcefully copied to your home directory.${RESET}"
else
  echo -e "${RED}ERROR: Failed to copy .zshrc file.${RESET}"
  exit 1
fi

echo -e "${BLUE}Done.${RESET}"