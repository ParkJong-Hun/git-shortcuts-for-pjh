#!/usr/bin/env bash
# Git Shortcuts - Cross-platform git command aliases
# Compatible with bash, zsh on macOS, Linux, Windows (Git Bash/WSL)

# Help function
git-shortcuts-for-pjh-help() {
    cat << 'EOF'
Git Shortcuts - Available Commands

FULL COMMANDS:
  git-setup              Install git using package manager
  git-push-this          Push current branch to origin
  git-commit-all "msg"   Stage all changes and commit with message
  git-reset-this         Hard reset to HEAD (with confirmation)

SHORT ALIASES:
  pit -s                 Same as git-setup
  pit -p                 Same as git-push-this
  pit -c "msg"           Same as git-commit-all
  pit -r                 Same as git-reset-this
  pit -h                 Show this help message

USAGE EXAMPLES:
  git-commit-all "feat: add new feature"
  pit -c "feat: add new feature"

  git-push-this
  pit -p

  git-reset-this
  pit -r

For more information, visit:
https://github.com/parkjonghun/git-shortcut-for-pjh
EOF
}

# git setup - Install git using appropriate package manager
gitsetup() {
    if command -v brew >/dev/null 2>&1; then
        brew install git
    elif command -v apt-get >/dev/null 2>&1; then
        sudo apt-get update && sudo apt-get install -y git
    elif command -v yum >/dev/null 2>&1; then
        sudo yum install -y git
    elif command -v pacman >/dev/null 2>&1; then
        sudo pacman -S git
    elif command -v choco >/dev/null 2>&1; then
        choco install git
    else
        echo "Error: No supported package manager found (brew, apt-get, yum, pacman, choco)"
        return 1
    fi
}

# git push-this - Push current branch to origin
gitpushthis() {
    local current_branch=$(git branch --show-current 2>/dev/null)
    if [ -z "$current_branch" ]; then
        echo "Error: Not in a git repository or no branch checked out"
        return 1
    fi
    git push origin "$current_branch" "$@"
}

# git commit-all - Add all changes and commit with message
gitcommitall() {
    if [ -z "$1" ]; then
        echo "Error: Commit message required"
        echo "Usage: git-commit-all \"your commit message\""
        return 1
    fi
    git add . && git commit -m "$1"
}

# git reset-this - Hard reset to HEAD
gitresetthis() {
    echo "Warning: This will discard all uncommitted changes!"
    read -p "Are you sure? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git reset --hard HEAD
    else
        echo "Reset cancelled"
        return 1
    fi
}

# Aliases for 'git-' prefix usage
alias git-setup='gitsetup'
alias git-push-this='gitpushthis'
alias git-commit-all='gitcommitall'
alias git-reset-this='gitresetthis'

# Shorter aliases using 'pit' prefix
pit() {
    case "$1" in
        -h|--help)
            git-shortcuts-for-pjh-help
            ;;
        -s)
            shift
            gitsetup "$@"
            ;;
        -p)
            shift
            gitpushthis "$@"
            ;;
        -c)
            shift
            gitcommitall "$@"
            ;;
        -r)
            shift
            gitresetthis "$@"
            ;;
        *)
            git "$@"
            ;;
    esac
}
