#!/bin/bash
# update-claude-date.sh
# Automatically updates the date in ~/.claude/CLAUDE.md
# 
# Installation:
# 1. chmod +x update-claude-date.sh
# 2. Copy to ~/bin/ or another directory in your PATH
# 3. Add to crontab: 0 0 * * * ~/bin/update-claude-date.sh

FILE="$HOME/.claude/CLAUDE.md"
DATE="* **Current date**: $(date +%Y-%m-%d)"

# Check if file exists
if [ ! -f "$FILE" ]; then
    echo "Error: $FILE does not exist"
    exit 1
fi

# Update the first line containing "Current date"
sed -i.bak "/\*\*Current date\*\*/c\\
$DATE" "$FILE"

echo "Updated date in $FILE to $(date +%Y-%m-%d)"