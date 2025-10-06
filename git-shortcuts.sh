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
  git-force-push-this    Force push current branch to origin (with confirmation)
  git-commit-all "msg"   Stage all changes and commit with message
  git-reset-this         Hard reset to HEAD (with confirmation)
  git-new-branch "name"  Create and switch to a new branch
  git-modify-branch "name"  Rename current branch

SHORT ALIASES:
  pit -s                 Same as git-setup
  pit -p                 Same as git-push-this
  pit -pf                Same as git-force-push-this
  pit -c "msg"           Same as git-commit-all
  pit -r                 Same as git-reset-this
  pit -b "name"          Same as git-new-branch
  pit -m "name"          Same as git-modify-branch
  pit -h                 Show this help message

USAGE EXAMPLES:
  git-commit-all "feat: add new feature"
  pit -c "feat: add new feature"

  git-push-this
  pit -p

  git-force-push-this
  pit -pf

  git-reset-this
  pit -r

  git-new-branch "feature/new-feature"
  pit -b "feature/new-feature"

  git-modify-branch "feature/updated-name"
  pit -m "feature/updated-name"

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

# git force-push-this - Force push current branch to origin
gitforcepushthis() {
    local current_branch=$(git branch --show-current 2>/dev/null)
    if [ -z "$current_branch" ]; then
        echo "Error: Not in a git repository or no branch checked out"
        return 1
    fi
    echo "Warning: This will force push to origin/$current_branch!"
    read -p "Are you sure? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git push -f origin "$current_branch"
    else
        echo "Force push cancelled"
        return 1
    fi
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
        git add . && git reset --hard HEAD
    else
        echo "Reset cancelled"
        return 1
    fi
}

# git new-branch - Create and switch to a new branch
gitnewbranch() {
    if [ -z "$1" ]; then
        echo "Error: Branch name required"
        echo "Usage: git-new-branch \"branch-name\""
        return 1
    fi
    git switch -c "$1"
}

# git modify-branch - Rename current branch
gitmodifybranch() {
    if [ -z "$1" ]; then
        echo "Error: Branch name required"
        echo "Usage: git-modify-branch \"branch-name\""
        return 1
    fi
    git branch -M "$1"
}

# Aliases for 'git-' prefix usage
alias git-setup='gitsetup'
alias git-push-this='gitpushthis'
alias git-force-push-this='gitforcepushthis'
alias git-commit-all='gitcommitall'
alias git-reset-this='gitresetthis'
alias git-new-branch='gitnewbranch'
alias git-modify-branch='gitmodifybranch'

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
        -pf)
            shift
            gitforcepushthis "$@"
            ;;
        -c)
            shift
            gitcommitall "$@"
            ;;
        -r)
            shift
            gitresetthis "$@"
            ;;
        -b)
            shift
            gitnewbranch "$@"
            ;;
        -m)
            shift
            gitmodifybranch "$@"
            ;;
        *)
            git "$@"
            ;;
    esac
}
