#!/bin/bash
# lint-markdown.sh
# Lints and fixes all markdown files in the repository

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the repository root
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
if [ -z "$REPO_ROOT" ]; then
    REPO_ROOT="$(dirname "$0")/.."
fi

cd "$REPO_ROOT" || exit 1

echo -e "${BLUE}Markdown Linter${NC}"
echo "==============="
echo ""

# Check if markdownlint is installed
if ! command -v npx &> /dev/null || ! npx markdownlint --version &> /dev/null 2>&1; then
    echo -e "${RED}Error: markdownlint-cli not found${NC}"
    echo "Please run: npm install --save-dev markdownlint-cli"
    exit 1
fi

# Parse arguments
FIX_MODE=false
if [ "$1" = "--fix" ] || [ "$1" = "-f" ]; then
    FIX_MODE=true
fi

# Find all markdown files
echo -e "${YELLOW}Finding markdown files...${NC}"
MD_FILES=$(find . -type f -name "*.md" -not -path "./node_modules/*" -not -path "./.git/*")
FILE_COUNT=$(echo "$MD_FILES" | grep -c .)

if [ "$FILE_COUNT" -eq 0 ]; then
    echo "No markdown files found"
    exit 0
fi

echo "Found $FILE_COUNT markdown file(s)"
echo ""

# Run linter
if [ "$FIX_MODE" = true ]; then
    echo -e "${YELLOW}Running linter in fix mode...${NC}"
    npx markdownlint --fix $MD_FILES
    RESULT=$?
    
    if [ $RESULT -eq 0 ]; then
        echo -e "${GREEN}✓ All markdown files have been fixed${NC}"
    else
        echo -e "${RED}✗ Some issues could not be automatically fixed${NC}"
        echo ""
        echo "Running check to show remaining issues:"
        npx markdownlint $MD_FILES
    fi
else
    echo -e "${YELLOW}Running linter in check mode...${NC}"
    npx markdownlint $MD_FILES
    RESULT=$?
    
    if [ $RESULT -eq 0 ]; then
        echo -e "${GREEN}✓ All markdown files pass linting${NC}"
    else
        echo ""
        echo -e "${YELLOW}To automatically fix issues, run:${NC}"
        echo "  $0 --fix"
        echo "  or: npm run lint:md:fix"
        exit 1
    fi
fi

exit $RESULT