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

# Install Starship
if ! command -v starship &>/dev/null; then
    echo "Installing starship..."
    install_pkg starship
fi

# Stow packages
cd "$DOTFILES_DIR"
stow -v --target="$HOME" starship vim zsh tmux tig git

chmod +x "$HOME/.config/starship-gitstatus.sh"

echo "Bootstrap complete."
