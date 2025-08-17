# CLAUDE.md Configuration Guide

This README explains the CLAUDE.md configuration file used by Franz und Franz GmbH for customizing Claude's behavior across all interactions.

## Origin

This configuration approach was inspired by the community discussion: [What's in your global ~/.claude/CLAUDE.md? Share your minimal configs!](https://www.reddit.com/r/ClaudeAI/comments/1mrr3nm/whats_in_your_global_claudeclaudemd_share_your/)

## Overview

The CLAUDE.md file is a custom instruction set that configures Claude's operational parameters, ensuring consistent behavior across all development tasks. This file should be placed in `~/.claude/CLAUDE.md` for global application.

## Configuration Directives

### Core Settings (REQUIRED)

#### **Current date**

```markdown
* **Current date**: 2025-08-17
```

- **Purpose**: Provides Claude with temporal context for time-sensitive operations
- **Required**: YES - Must be updated daily for accurate time references
- **Impact**: Affects all date-related calculations, recent event queries, and temporal reasoning

#### **Date usage**

```markdown
* **Date usage** — Treat the line above as the single source of truth for "today".
```

- **Purpose**: Ensures Claude uses the configured date consistently
- **Required**: YES - Critical for temporal consistency
- **Impact**: Prevents Claude from using system time or making assumptions

#### **Precedence**

```markdown
* **Precedence** — System → Developer → User → Tools. Resolve conflicts by escalating upward.
```

- **Purpose**: Defines hierarchy for instruction conflicts
- **Required**: YES - Essential for consistent behavior
- **Impact**: Determines which instructions take priority when conflicts arise

### Development Standards (REQUIRED)

#### **Language**

```markdown
* **Language** — English only for all code, comments, docs, examples, commits, configs, errors, tests.
```

- **Purpose**: Enforces consistent language across all technical content
- **Required**: YES - Mandatory for international collaboration
- **Impact**: Ensures codebase maintainability and team communication

#### **Git commits**

```markdown
* **Git commits** — Use Conventional Commits:
  * Format: `<type>(<scope>): <subject>`
  * Types: `feat` | `fix` | `docs` | `style` | `refactor` | `test` | `chore` | `perf`
  * Subject: ≤ 50 chars, imperative mood, no period
  * Small changes: one-line commit
  * Complex changes: add body (wrap at 72 chars) explaining what/why; reference issues
  * Keep commits atomic and self-explanatory; split by concern
```

- **Purpose**: Standardizes commit messages for better version control
- **Required**: YES - Essential for changelog generation and code history
- **Impact**: Improves collaboration, automated tooling, and code review

### Operational Behavior (REQUIRED)

#### **Delivery**

```markdown
* **Delivery** — Provide the complete answer now. No background tasks or time estimates.
```

- **Purpose**: Ensures immediate, complete responses
- **Required**: YES
- **Impact**: Claude provides full solutions immediately (compatible with sub-agents)
- **Note**: Does NOT conflict with Claude Code sub-agents, which execute synchronously

#### **Grounding & research**

```markdown
* **Grounding & research** — Use verifiable facts; cite when you browse; write "Unknown" rather than guess; use absolute dates for time-sensitive points; use websearch for recent/niche/high-stakes information.
```

- **Purpose**: Ensures factual accuracy and transparency
- **Required**: YES - Critical for reliability
- **Impact**: Improves trust and verifiability of responses

### Working Principles (HIGHLY RECOMMENDED)

#### **Assumptions**

```markdown
* **Assumptions** — When ambiguous, state reasonable assumptions and proceed. Ask only if execution would otherwise fail, and still deliver your best attempt.
```

- **Purpose**: Balances autonomy with clarity
- **Optional**: Can be adjusted based on team preference
- **Impact**: Reduces back-and-forth, increases productivity

#### **Format**

```markdown
* **Format** — Match the user's requested format and constraints exactly.
```

- **Purpose**: Ensures output meets expectations
- **Optional**: Can be customized for specific formats
- **Impact**: Improves usability of generated content

### Style Guidelines (OPTIONAL BUT RECOMMENDED)

#### **Style**

```markdown
* **Style** — Crisp, precise prose with diplomatic rigor. Apply Socratic checks on assumptions and logic. Prefer self-documenting code to comments.
```

- **Purpose**: Defines communication and code style
- **Optional**: Can be adjusted to team preferences
- **Impact**: Affects readability and maintainability

#### **Brevity**

```markdown
* **Brevity** — Make every token earn its place.
```

- **Purpose**: Encourages concise, efficient communication
- **Optional**: Adjustable based on documentation needs
- **Impact**: Reduces verbosity, improves clarity

### Technical Preferences (OPTIONAL)

#### **Tools**

```markdown
* **Tools** — Use only when they add clear value; follow tool rules; keep system/tool internals private. Prefer `rg` over `grep`, `fd` over `find`; `tree` is available.
```

- **Purpose**: Optimizes tool usage for performance
- **Optional**: Can be customized to available tools
- **Impact**: Improves execution speed and efficiency

#### **Code & math**

```markdown
* **Code & math** — Compute stepwise (digit-by-digit for arithmetic). Return minimal, correct code and outputs; briefly note constraints.
```

- **Purpose**: Ensures accuracy in calculations
- **Optional**: Can be adjusted for different precision needs
- **Impact**: Affects computational accuracy and verbosity

### Privacy & Security (OPTIONAL)

#### **Reasoning privacy**

```markdown
* **Reasoning privacy** — Keep chain-of-thought private; share conclusions and key steps only.
```

- **Purpose**: Reduces noise in responses
- **Optional**: Can be made more transparent if needed
- **Impact**: Cleaner, more focused outputs

### Inclusive Language (RECOMMENDED)

#### **Inclusive terminology**

```markdown
* **Inclusive terminology** — Use: allowlist/blocklist, primary/replica, placeholder/example, main branch, conflict-free, concurrent/parallel.
```

- **Purpose**: Promotes inclusive development culture
- **Optional**: Strongly recommended for modern teams
- **Impact**: Creates welcoming environment for all contributors

## Sub-Agents Compatibility

The `Delivery` directive ("Provide the complete answer now") is **fully compatible** with Claude Code sub-agents. Sub-agents:

- Execute synchronously within their own context windows
- Complete their specialized tasks immediately
- Return results to the main context
- Are NOT background tasks or asynchronous processes

## Daily Maintenance

The `Current date` field MUST be updated daily. You can automate this with the scripts below.

### Auto-Update Scripts

#### Option 1: Shell Script with Cron

Create a script to update the date automatically:

```bash
#!/bin/bash
# Save as ~/bin/update-claude-date.sh and chmod +x

FILE="$HOME/.claude/CLAUDE.md"
DATE="- **Current date**: $(date +%Y-%m-%d)"

# Update the first line containing "Current date"
sed -i.bak "/\*\*Current date\*\*/c\\
$DATE" "$FILE"
```

Then add it to your crontab:

```bash
# Run 'crontab -e' and add:
0 0 * * * ~/bin/update-claude-date.sh
```

#### Option 2: One-liner Cron Entry

For a more direct approach, add this single line to your crontab:

```bash
# Run 'crontab -e' and add:
0 0 * * * sed -i.bak 's/\*\*Current date\*\*: [0-9-]*/\*\*Current date\*\*: '$(date +%Y-%m-%d)'/' ~/.claude/CLAUDE.md
```

This will automatically update the date in your CLAUDE.md file every day at midnight.

### Using the Provided Scripts

This repository includes ready-to-use scripts:

- **`update-claude-date.sh`**: The update script that modifies the date in CLAUDE.md
- **`install-cron.sh`**: Interactive installer that sets up the cron job for you

To use them:

```bash
# Run the installer
./install-cron.sh

# Or manually install the update script
cp update-claude-date.sh ~/bin/
chmod +x ~/bin/update-claude-date.sh
crontab -e  # Then add: 0 0 * * * ~/bin/update-claude-date.sh
```

## Customization Guidelines

1. **Required fields** should never be removed
2. **Optional fields** can be adjusted or removed based on team needs
3. **Additional directives** can be added following the same format
4. **Test changes** in a project-specific `.claude/CLAUDE.md` before applying globally

## File Location

- **Global**: `~/.claude/CLAUDE.md` (applies to all projects)
- **Project-specific**: `.claude/CLAUDE.md` (overrides global for that project)

## License

MIT License - Franz und Franz GmbH

---

_For questions or improvements, please submit a pull request or contact the development team._
