#            _
#    _______| |__  _ __ ___
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__
# (_)___|___/_| |_|_|  \___|

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
[ -f "$HOME/.config/fzf/commands.sh" ] && source "$HOME/.config/fzf/commands.sh"

ZSH_THEME="myagnoster"

COMPLETION_WAITING_DOTS="true"

# source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# source zplug
source $ZPLUG_HOME/init.zsh

zplug urbainvaes/fzf-marks
zplug zsh-users/zsh-autosuggestions
zplug kutsan/zsh-system-clipboard
zplug AnHoang97/vim-mode-zsh
zplug "plugins/git",   from:oh-my-zsh
zplug "plugins/colored-man-pages",   from:oh-my-zsh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load 

# configure key bindings
bindkey -s '^f' 'fcd ~\n'
bindkey -s '^b' 'fzm\n'
bindkey -s '^r' 'ranger\n'
bindkey '^ ' autosuggest-accept

