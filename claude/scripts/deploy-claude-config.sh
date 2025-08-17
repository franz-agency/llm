#!/bin/bash
# deploy-claude-config.sh
# Deploys CLAUDE.md to global location with backup

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Configuration
SOURCE_FILE="$(dirname "$0")/../CLAUDE.md"
TARGET_DIR="$HOME/.claude"
TARGET_FILE="$TARGET_DIR/CLAUDE.md"
BACKUP_DIR="$TARGET_DIR/backups"

echo -e "${YELLOW}CLAUDE.md Deployment Script${NC}"
echo "============================"
echo ""

# Check if source file exists
if [ ! -f "$SOURCE_FILE" ]; then
    echo -e "${RED}Error: Source file not found at $SOURCE_FILE${NC}"
    exit 1
fi

# Create target directory if it doesn't exist
if [ ! -d "$TARGET_DIR" ]; then
    echo "Creating directory: $TARGET_DIR"
    mkdir -p "$TARGET_DIR"
fi

# Create backup directory if it doesn't exist
if [ ! -d "$BACKUP_DIR" ]; then
    echo "Creating backup directory: $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
fi

# If target file exists, create backup with timestamp
if [ -f "$TARGET_FILE" ]; then
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    BACKUP_FILE="$BACKUP_DIR/CLAUDE.md.backup_${TIMESTAMP}"
    
    echo -e "Creating backup: ${YELLOW}$BACKUP_FILE${NC}"
    cp "$TARGET_FILE" "$BACKUP_FILE"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Backup created successfully${NC}"
    else
        echo -e "${RED}Error: Failed to create backup${NC}"
        exit 1
    fi
else
    echo "No existing file found, skipping backup"
fi

# Copy new file to target location
echo -e "Deploying: ${YELLOW}$SOURCE_FILE${NC} → ${YELLOW}$TARGET_FILE${NC}"
cp "$SOURCE_FILE" "$TARGET_FILE"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ CLAUDE.md deployed successfully${NC}"
    echo ""
    echo "Location: $TARGET_FILE"
    
    # Show recent backups
    if [ -d "$BACKUP_DIR" ] && [ "$(ls -A $BACKUP_DIR 2>/dev/null)" ]; then
        echo ""
        echo "Recent backups:"
        ls -lt "$BACKUP_DIR" | head -6 | tail -5
    fi
else
    echo -e "${RED}Error: Failed to deploy CLAUDE.md${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}Deployment complete!${NC}"