#                         __ _ _      
#    _____ __  _ __ ___  / _(_) | ___ 
#   |_  / '_ \| '__/ _ \| |_| | |/ _ \
#  _ / /| |_) | | | (_) |  _| | |  __/
# (_)___| .__/|_|  \___/|_| |_|_|\___|
#       |_|                           
# Profile file. Runs on login. Environmental variables are set here.
#

#Append dirs to serach path
export PATH="$HOME/Scripts/rserver:$PATH"
export PATH="/Users/Shared/anaconda3/bin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"

# ~/ Clean-up:
export LESSHISTFILE="-"
export ZDOTDIR="$HOME/.config/zsh"

# Default programms
export EDITOR="nvim"
export FILE="ranger"

# FZF defaults
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export FZF_DEFAULT_COMMAND='ag -f --hidden --ignore .git -g ""'

# Attach to tmux session 
# When havin $PATH problems goto: https://pgib.me//blog/2013/10/11/macosx-tmux-zsh-rbenv/
# exec tmux -f ~/.config/tmux/.tmux.conf new-session -A -s main

export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"
export DYLD_LIBRARY_PATH="/usr/local/Cellar/llvm/10.0.1/lib"
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/lib

# Add direnv hook
command -v direnv &>/dev/null && eval "$(direnv hook zsh)" || echo "direnv does not exits."
