#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
OS="$(uname -s)"

install_pkg() {
    if [ "$OS" = "Darwin" ]; then
        brew install "$1"
    else
        sudo apt update && sudo apt install -y "$1"
    fi
}

# Install stow
if ! command -v stow &>/dev/null; then
    echo "Installing stow..."
    install_pkg stow
fi

# Install applications
echo "Installing applications..."
[ -z "$(command -v starship)" ] && install_pkg starship
[ "$OS" = "Darwin" ] && [ -z "$(command -v ghostty)" ] && install_pkg ghostty

cd "$DOTFILES_DIR"
echo "Linking dotfiles..."

# Link all packages using stow
stow -v --target="$HOME" vim zsh tmux tig git posh starship ghostty

echo "✓ Bootstrap complete!"
