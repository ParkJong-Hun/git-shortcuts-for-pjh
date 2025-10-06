# Git Shortcuts

Cross-platform git command shortcuts for macOS, Linux, and Windows.

## Installation

```bash
bash install.sh
```

After installation, restart your terminal or run:
```bash
source ~/.zshrc  # if using zsh
source ~/.bashrc # if using bash
```

## Available Commands

| Shortcut Command | Shorter Alias | Original Command | Description |
|-----------------|---------------|------------------|-------------|
| `git-setup` | `pit -s` | `brew install git` (or apt-get, yum, etc.) | Install git using package manager |
| `git-push-this` | `pit -p` | `git push origin {current-branch}` | Push current branch to origin |
| `git-force-push-this` | `pit -pf` | `git push -f origin {current-branch}` | Force push current branch to origin (with confirmation) |
| `git-commit-all "message"` | `pit -c "message"` | `git add . && git commit -m "message"` | Stage all changes and commit |
| `git-reset-this` | `pit -r` | `git add . && git reset --hard HEAD` | Hard reset to HEAD (with confirmation) |
| `git-new-branch "name"` | `pit -b "name"` | `git switch -c {name}` | Create and switch to a new branch |
| `git-modify-branch "name"` | `pit -m "name"` | `git branch -M {name}` | Rename current branch |

## Usage Examples

```bash
# Show help
pit -h
# or
git-shortcuts-for-pjh-help

# Commit all changes
git-commit-all "feat: add new feature"
# or shorter
pit -c "feat: add new feature"

# Push current branch
git-push-this
# or shorter
pit -p

# Force push current branch
git-force-push-this
# or shorter
pit -pf

# Discard all changes
git-reset-this
# or shorter
pit -r

# Create and switch to a new branch
git-new-branch "feature/new-feature"
# or shorter
pit -b "feature/new-feature"

# Rename current branch
git-modify-branch "feature/updated-name"
# or shorter
pit -m "feature/updated-name"
```

## Uninstallation

```bash
bash uninstall.sh
```

## Supported Environments

- **macOS**: bash, zsh
- **Linux**: bash, zsh (apt-get, yum, pacman supported)
- **Windows**: Git Bash, WSL

## File Structure

- `git-shortcuts.sh` - Shortcut function definitions
- `install.sh` - Installation script
- `uninstall.sh` - Uninstallation script
