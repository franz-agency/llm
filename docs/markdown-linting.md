# Markdown Linting Setup Guide

This guide explains how to use the markdown linting system in this repository.

## Overview

We use `markdownlint-cli` to ensure consistent markdown formatting across all documentation. The linter helps maintain:

- Consistent heading styles
- Proper list formatting
- Correct spacing and indentation
- Clean markdown syntax

## Installation

### Prerequisites

1. Install Node.js and npm if not already installed
2. Run npm install to get dependencies:

```bash
npm install
```

### Setting up Pre-commit Hook

To automatically check markdown files before committing:

```bash
npm run install:hooks
# or directly:
./scripts/install-pre-commit-hook.sh
```

## Usage

### Manual Linting

Check all markdown files:

```bash
npm run lint:md
# or directly:
./scripts/lint-markdown.sh
```

### Auto-fix Issues

Automatically fix most linting issues:

```bash
npm run lint:md:fix
# or directly:
./scripts/lint-markdown.sh --fix
```

### Skipping Pre-commit Hook

If you need to commit without linting (not recommended):

```bash
git commit --no-verify
```

## Configuration

The linting rules are defined in `.markdownlint.json`. Key settings:

- **MD013**: Line length limit disabled (for better readability)
- **MD033**: HTML allowed in markdown
- **MD034**: Bare URLs allowed
- **MD040**: Code blocks without language specification allowed
- **MD041**: First line heading not required

### Customizing Rules

To modify linting rules, edit `.markdownlint.json`. See [markdownlint rules documentation](https://github.com/DavidAnson/markdownlint/blob/main/doc/Rules.md) for all available options.

## Common Issues and Fixes

### Issue: Trailing spaces

**Fix**: Remove spaces at end of lines

```bash
# Auto-fix will handle this
npm run lint:md:fix
```

### Issue: Multiple consecutive blank lines

**Fix**: Keep only one blank line between sections

### Issue: Inconsistent list markers

**Fix**: Use `-` for unordered lists (configured in our setup)

### Issue: Hard tabs

**Fix**: Use spaces instead of tabs (2 spaces for indentation)

## Pre-commit Hook Details

The pre-commit hook:

1. Only checks staged markdown files
2. Runs markdownlint on those files
3. Blocks commit if issues are found
4. Suggests running auto-fix

## Removing the Setup

To remove the pre-commit hook:

```bash
rm .git/hooks/pre-commit
```

To remove markdown linting entirely:

```bash
npm uninstall markdownlint-cli
rm .markdownlint.json
```

## Troubleshooting

### Hook not running

Ensure the hook is executable:

```bash
chmod +x .git/hooks/pre-commit
```

### markdownlint command not found

Reinstall dependencies:

```bash
npm install
```

### Want different rules

Edit `.markdownlint.json` and adjust rules as needed. Run linting to test changes.

## Related Documentation

- [Markdownlint Rules](https://github.com/DavidAnson/markdownlint/blob/main/doc/Rules.md)
- [Markdownlint CLI](https://github.com/igorshubovych/markdownlint-cli)
- [Git Hooks Documentation](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)
