# CLAUDE.md Configuration Guide

This README explains the CLAUDE.md configuration file used by Franz und Franz GmbH for customizing Claude's behavior across all interactions.

## Origin

This configuration approach was inspired by the community discussion: [What's in your global ~/.claude/CLAUDE.md? Share your minimal configs!](https://www.reddit.com/r/ClaudeAI/comments/1mrr3nm/whats_in_your_global_claudeclaudemd_share_your/)

## Overview

The CLAUDE.md file is a custom instruction set that configures Claude's operational parameters, ensuring consistent behavior across all development tasks. This file should be placed in `~/.claude/CLAUDE.md` for global application.

### Quick Start

1. **Deploy the configuration:**
   ```bash
   ./scripts/deploy-claude-config.sh
   ```

2. **Set up automatic date updates:**
   ```bash
   ./install-cron.sh
   ```

3. **Verify installation:**
   ```bash
   cat ~/.claude/CLAUDE.md
   ```

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

The `Current date` field MUST be updated daily for accurate temporal context.

### Automation Scripts

This repository includes ready-to-use scripts for automatic date updates:

| Script | Purpose | Usage |
|--------|---------|--------|
| `update-claude-date.sh` | Updates the date in CLAUDE.md | Run manually or via cron |
| `install-cron.sh` | Interactive installer for cron job | `./install-cron.sh` |
| `scripts/deploy-claude-config.sh` | Deploy CLAUDE.md with backup | `./scripts/deploy-claude-config.sh` |

### Quick Setup

```bash
# Interactive setup (recommended)
./install-cron.sh

# Manual installation
cp update-claude-date.sh ~/bin/
chmod +x ~/bin/update-claude-date.sh
crontab -e  # Add: 0 0 * * * ~/bin/update-claude-date.sh
```

The cron job will automatically update the date every day at midnight.

## Customization Guidelines

1. **Required fields** should never be removed
2. **Optional fields** can be adjusted or removed based on team needs
3. **Additional directives** can be added following the same format
4. **Test changes** in a project-specific `.claude/CLAUDE.md` before applying globally

## File Locations

| Location | Path | Scope | Priority |
|----------|------|-------|----------|
| Global | `~/.claude/CLAUDE.md` | All projects | Base |
| Project | `.claude/CLAUDE.md` | Current project | Override |
| Repository | `claude/CLAUDE.md` | This repo (template) | Source |

## Available Scripts

| Script | Location | Purpose |
|--------|----------|---------|
| `deploy-claude-config.sh` | `scripts/` | Deploy CLAUDE.md with automatic backup |
| `update-claude-date.sh` | Root | Update date field in CLAUDE.md |
| `install-cron.sh` | Root | Set up automatic daily updates |

For detailed usage, see the scripts themselves or run with `--help`.

## License

MIT License - Franz und Franz GmbH

---

_For questions or improvements, please submit a pull request or contact the development team._
