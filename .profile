#                         __ _ _      
#    _____ __  _ __ ___  / _(_) | ___ 
#   |_  / '_ \| '__/ _ \| |_| | |/ _ \
#  _ / /| |_) | | | (_) |  _| | |  __/
# (_)___| .__/|_|  \___/|_| |_|_|\___|
#       |_|                           
# Profile file. Runs on login. Environmental variables are set here.

export LC_ALL="en_US.UTF-8"

#Append dirs to serach path
export PATH="/Users/Shared/anaconda3/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="/Users/anhoang/.config/oh-my-zsh"

# ~/ Clean-up:
export LESSHISTFILE="-"
export ZDOTDIR="$HOME/.config/zsh"
export ZPLUG_HOME="$HOME/.config/zplug"
export ZGEN_DIR="$HOME/.config/zgen/plugins"

# Default programms
export EDITOR="nvim"
export FILE="ranger"

# FZF defaults
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export FZF_DEFAULT_COMMAND='ag -f --hidden --ignore .git -g ""'

# Add direnv hook
# command -v direnv &>/dev/null && eval "$(direnv hook zsh)" || echo "direnv does not exits."
