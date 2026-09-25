# oh-my-zsh is installed and updated by oh-my-zsh itself (not managed here).
export ZSH="$HOME/.oh-my-zsh"

# Binary mirror source for Homebrew (git remote)
export HOMEBREW_BREW_GIT_REMOTE="https://mirror.nju.edu.cn/git/homebrew/brew.git"

# Prompt is provided by Starship, so no oh-my-zsh theme is loaded.
ZSH_THEME=""

if [ "$(uname -s)" = "Darwin" ]; then
    source "$HOME/.zshrc.mac"
elif [ "$(uname -s)" = "Linux" ]; then
    source "$HOME/.zshrc.linux"
fi
