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

| Shortcut Command | Original Command | Description |
|-----------------|------------------|-------------|
| `git-setup` | `brew install git` (or apt-get, yum, etc.) | Install git using package manager |
| `git-push-this` | `git push origin {current-branch}` | Push current branch to origin |
| `git-commit-all "message"` | `git add . && git commit -m "message"` | Stage all changes and commit |
| `git-reset-this` | `git reset --hard HEAD` | Hard reset to HEAD (with confirmation) |

## Usage Examples

```bash
# Commit all changes
git-commit-all "feat: add new feature"

# Push current branch
git-push-this

# Discard all changes
git-reset-this
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
