# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="befunny"

if [ $(uname -s) = "Darwin" ];then
    source $ZSH/zshrc.mac
elif [ $(uname -s) = "Linux" ];then
    source $ZSH/zshrc.linux
else
fi
