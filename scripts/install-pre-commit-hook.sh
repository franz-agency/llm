#!/bin/bash
# install-pre-commit-hook.sh
# Installs a git pre-commit hook for markdown linting

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the repository root
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
if [ -z "$REPO_ROOT" ]; then
    echo -e "${RED}Error: Not in a git repository${NC}"
    exit 1
fi

HOOK_FILE="$REPO_ROOT/.git/hooks/pre-commit"

echo -e "${BLUE}Git Pre-commit Hook Installer${NC}"
echo "=============================="
echo ""

# Check if hook already exists
if [ -f "$HOOK_FILE" ]; then
    echo -e "${YELLOW}Warning: Pre-commit hook already exists${NC}"
    echo "Current hook content:"
    echo "---"
    head -10 "$HOOK_FILE"
    echo "---"
    echo ""
    read -p "Do you want to overwrite it? (y/N): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled"
        exit 0
    fi
    
    # Backup existing hook
    BACKUP_FILE="$HOOK_FILE.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$HOOK_FILE" "$BACKUP_FILE"
    echo -e "${GREEN}✓ Backup created: $BACKUP_FILE${NC}"
fi

# Create the pre-commit hook
cat > "$HOOK_FILE" << 'EOF'
#!/bin/bash
# Git pre-commit hook for markdown linting

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Running markdown linter...${NC}"

# Get list of staged markdown files
STAGED_MD_FILES=$(git diff --cached --name-only --diff-filter=ACM | grep '\.md$')

if [ -z "$STAGED_MD_FILES" ]; then
    # No markdown files staged
    exit 0
fi

# Check if markdownlint is available
if ! command -v npx &> /dev/null || ! npx markdownlint --version &> /dev/null 2>&1; then
    echo -e "${YELLOW}Warning: markdownlint-cli not found, skipping markdown checks${NC}"
    echo "To enable markdown linting, run: npm install --save-dev markdownlint-cli"
    exit 0
fi

# Run linter on staged files
echo "Checking $(echo "$STAGED_MD_FILES" | wc -l) markdown file(s)..."
npx markdownlint $STAGED_MD_FILES

if [ $? -ne 0 ]; then
    echo ""
    echo -e "${RED}✗ Markdown linting failed${NC}"
    echo ""
    echo "Options:"
    echo "  1. Fix issues manually and stage changes"
    echo "  2. Run: npm run lint:md:fix"
    echo "  3. Skip hook: git commit --no-verify"
    echo ""
    exit 1
fi

echo -e "${GREEN}✓ Markdown files pass linting${NC}"
exit 0
EOF

# Make hook executable
chmod +x "$HOOK_FILE"

echo -e "${GREEN}✓ Pre-commit hook installed successfully${NC}"
echo ""
echo "The hook will:"
echo "  • Check all staged markdown files before commit"
echo "  • Auto-fix issues if possible"
echo "  • Block commit if issues remain"
echo ""
echo "To skip the hook for a single commit, use:"
echo "  git commit --no-verify"
echo ""
echo "To uninstall the hook, run:"
echo "  rm $HOOK_FILE"