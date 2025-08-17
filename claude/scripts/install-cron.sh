#!/bin/bash
# install-cron.sh
# Installs the auto-update cron job for CLAUDE.md date

# Color codes for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}CLAUDE.md Auto-Update Installer${NC}"
echo "================================="
echo ""
echo "This script will add a cron job to automatically update"
echo "the date in your ~/.claude/CLAUDE.md file every day at midnight."
echo ""

# Check if CLAUDE.md exists
if [ ! -f "$HOME/.claude/CLAUDE.md" ]; then
    echo "Warning: ~/.claude/CLAUDE.md does not exist yet."
    echo "Please create it first before setting up auto-update."
    exit 1
fi

echo "Choose installation method:"
echo "1) Install update script to ~/bin/ and add to cron"
echo "2) Add one-liner directly to cron (simpler)"
echo ""
read -p "Enter choice (1 or 2): " choice

case $choice in
    1)
        # Create ~/bin if it doesn't exist
        mkdir -p ~/bin
        
        # Copy update script
        cp "$(dirname "$0")/update-claude-date.sh" ~/bin/
        chmod +x ~/bin/update-claude-date.sh
        
        # Add to crontab
        (crontab -l 2>/dev/null; echo "0 0 * * * ~/bin/update-claude-date.sh") | crontab -
        
        echo -e "${GREEN}✓ Script installed to ~/bin/update-claude-date.sh${NC}"
        echo -e "${GREEN}✓ Cron job added to run daily at midnight${NC}"
        ;;
    2)
        # Add one-liner to crontab
        (crontab -l 2>/dev/null; echo "0 0 * * * sed -i.bak 's/\*\*Current date\*\*: [0-9-]*/\*\*Current date\*\*: '\$(date +%Y-%m-%d)'/' ~/.claude/CLAUDE.md") | crontab -
        
        echo -e "${GREEN}✓ One-liner cron job added to run daily at midnight${NC}"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo ""
echo "Installation complete!"
echo "To verify, run: crontab -l"
echo "To remove, run: crontab -e and delete the relevant line"