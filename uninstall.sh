#!/usr/bin/env bash
# Git Shortcuts Uninstaller

set -e

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

# Main uninstallation
main() {
    echo "Uninstalling Git Shortcuts..."

    SHELL_CONFIG=$(detect_shell_config)
    echo "Checking shell configuration: $SHELL_CONFIG"

    if ! grep -q "# Git Shortcuts - BEGIN" "$SHELL_CONFIG" 2>/dev/null; then
        echo "Git shortcuts not found in $SHELL_CONFIG"
        exit 0
    fi

    # Remove installation block
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' '/# Git Shortcuts - BEGIN/,/# Git Shortcuts - END/d' "$SHELL_CONFIG"
    else
        sed -i '/# Git Shortcuts - BEGIN/,/# Git Shortcuts - END/d' "$SHELL_CONFIG"
    fi

    echo "✓ Uninstallation complete!"
    echo ""
    echo "To apply changes, run: source $SHELL_CONFIG"
    echo "Or restart your terminal"
}

main
