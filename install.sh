#!/usr/bin/env bash
# Git Shortcuts Installer
# Supports macOS, Linux, Windows (Git Bash/WSL)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SHORTCUTS_FILE="$SCRIPT_DIR/git-shortcuts.sh"

# Detect shell configuration file
detect_shell_config() {
    if [ -n "$ZSH_VERSION" ] || [ -f "$HOME/.zshrc" ]; then
        echo "$HOME/.zshrc"
    elif [ -n "$BASH_VERSION" ] || [ -f "$HOME/.bashrc" ]; then
        echo "$HOME/.bashrc"
    elif [ -f "$HOME/.bash_profile" ]; then
        echo "$HOME/.bash_profile"
    else
        echo "$HOME/.profile"
    fi
}

# Main installation
main() {
    echo "Installing Git Shortcuts..."

    if [ ! -f "$SHORTCUTS_FILE" ]; then
        echo "Error: git-shortcuts.sh not found in $SCRIPT_DIR"
        exit 1
    fi

    SHELL_CONFIG=$(detect_shell_config)
    echo "Detected shell configuration: $SHELL_CONFIG"

    # Check if already installed
    if grep -q "git-shortcuts.sh" "$SHELL_CONFIG" 2>/dev/null; then
        echo "Git shortcuts already installed in $SHELL_CONFIG"
        read -p "Reinstall? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Installation cancelled"
            exit 0
        fi
        # Remove old installation
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i '' '/# Git Shortcuts - BEGIN/,/# Git Shortcuts - END/d' "$SHELL_CONFIG"
        else
            sed -i '/# Git Shortcuts - BEGIN/,/# Git Shortcuts - END/d' "$SHELL_CONFIG"
        fi
    fi

    # Add source line to shell config
    cat >> "$SHELL_CONFIG" << EOF

# Git Shortcuts - BEGIN
if [ -f "$SHORTCUTS_FILE" ]; then
    source "$SHORTCUTS_FILE"
fi
# Git Shortcuts - END
EOF

    echo "✓ Installation complete!"
    echo ""
    echo "Available commands:"
    echo "  git-setup          - Install git using package manager"
    echo "  git-push-this      - Push current branch to origin"
    echo "  git-commit-all     - Add all changes and commit"
    echo "  git-reset-this     - Hard reset to HEAD (with confirmation)"
    echo ""
    echo "To activate now, run: source $SHELL_CONFIG"
    echo "Or restart your terminal"
}

main
