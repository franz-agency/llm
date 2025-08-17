# Git Hooks Documentation

This document explains the git hooks available in this repository and how to use them.

## Available Hooks

### Pre-commit Hook

The pre-commit hook runs before each commit to ensure code quality.

**Current checks:**

- Markdown linting for all staged `.md` files

**Installation:**

```bash
npm run install:hooks
```

**Bypass (when necessary):**

```bash
git commit --no-verify
```

## How Git Hooks Work

Git hooks are scripts that run automatically at certain points in the git workflow:

- **pre-commit**: Runs before a commit is created
- **commit-msg**: Validates commit messages
- **pre-push**: Runs before pushing to remote

Our hooks are stored in `.git/hooks/` and are not tracked by git itself.

## Managing Hooks

### Install All Hooks

```bash
npm run install:hooks
```

### Check Hook Status

```bash
ls -la .git/hooks/
```

### Remove a Hook

```bash
rm .git/hooks/pre-commit
```

### Backup Existing Hooks

The installer automatically backs up existing hooks with timestamp:

```bash
.git/hooks/pre-commit.backup.20250817_123456
```

## Creating Custom Hooks

To add a new hook:

1. Create script in `scripts/hooks/`
2. Make it executable
3. Update installer to include it

Example hook structure:

```bash
#!/bin/bash
# Hook description

# Exit codes:
# 0 = success (allow operation)
# 1 = failure (block operation)

echo "Running custom hook..."

# Your checks here
if [ condition ]; then
    echo "Check failed"
    exit 1
fi

echo "Check passed"
exit 0
```

## Hook Best Practices

1. **Keep hooks fast** - They run on every commit
2. **Provide clear messages** - Tell users what failed and how to fix it
3. **Allow bypass** - Sometimes hooks need to be skipped
4. **Check for dependencies** - Don't fail if tools aren't installed
5. **Be cross-platform** - Consider Windows/Mac/Linux differences

## Troubleshooting

### Hook Not Running

Check permissions:

```bash
chmod +x .git/hooks/pre-commit
```

### Hook Blocking Valid Commits

Bypass once:

```bash
git commit --no-verify
```

Or fix the underlying issue.

### Hook Running Slowly

- Optimize checks to only process changed files
- Consider moving expensive checks to CI/CD

## Sharing Hooks

Since `.git/hooks/` is not tracked, use our installer scripts to share hooks:

1. Scripts in `scripts/` are tracked
2. Installer creates hooks from these scripts
3. Team members run installer after cloning

## Security Considerations

- Hooks run with user permissions
- Never commit sensitive data in hooks
- Review hook scripts before installing
- Be cautious with hooks from untrusted sources

## Related Tools

Consider these alternatives for more complex needs:

- **Husky**: npm package for managing git hooks
- **pre-commit**: Python framework for multi-language hooks
- **lefthook**: Fast and powerful git hooks manager

For this project, we use simple bash scripts for transparency and minimal dependencies.
