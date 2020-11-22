#            _
#    _______| |__  _ __ ___
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__
# (_)___|___/_| |_|_|  \___|

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
[ -f "$HOME/.config/fzf/commands.sh" ] && source "$HOME/.config/fzf/commands.sh"


# load zgen
source "${HOME}/.config/zgen/zgen.zsh"

# load lf config
[ -f  "${HOME}/.config/lf/lf.config.sh" ] && source "${HOME}/.config/lf/lf.config.sh"

# if the init script doesn't exist
if ! zgen saved; then
	#theme
	zgen load AnHoang97/agnoster-zsh-theme agnoster

	# specify plugins here
	zgen load urbainvaes/fzf-marks
	zgen load kutsan/zsh-system-clipboard
	zgen load AnHoang97/zsh-vim-mode
	zgen load zsh-users/zsh-completions
	zgen load zsh-users/zsh-syntax-highlighting
	zgen load zsh-users/zsh-autosuggestions

	# completion
	zgen load esc/conda-zsh-completion.zsh-theme

	# generate the init script from plugins above
	zgen save
fi

bindkey -s '^f' 'fcd ~\n'
bindkey '^e' edit-command-line
bindkey -s '^l' 'lfcd\n'
bindkey '^ ' autosuggest-accept
