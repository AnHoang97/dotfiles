#            _
#    _______| |__  _ __ ___
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__
# (_)___|___/_| |_|_|  \___|

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
[ -f "$HOME/.config/fzf/commands.sh" ] && source "$HOME/.config/fzf/commands.sh"

# install zgen if not exists and load command
[ -d "${HOME}/.config/zgen" ] || git clone https://github.com/tarjoilija/zgen.git "${HOME}/.config/zgen"
source "${HOME}/.config/zgen/zgen.zsh"

# load lf config
[ -f  "${HOME}/.config/lf/lf.config.sh" ] && source "${HOME}/.config/lf/lf.config.sh"

# load spaceship config
[ -f  "${HOME}/.config/spaceship/config.sh" ] && source "${HOME}/.config/spaceship/config.sh"

# run tmux if started from iTerm2
[ $TERM_PROGRAM = "iTerm.app" ] && [ -z $TMUX ] && exec tmux -f $HOME/.config/tmux/tmux.conf new-session -A -s main

# if the init script doesn't exist
if ! zgen saved; then
	# fancy prompt
	zgen load denysdovhan/spaceship-prompt spaceship

	# specify plugins here
	zgen load urbainvaes/fzf-marks
	zgen load kutsan/zsh-system-clipboard
	zgen load AnHoang97/zsh-vim-mode
	zgen load zsh-users/zsh-completions
	zgen load zsh-users/zsh-syntax-highlighting
	zgen load zsh-users/zsh-autosuggestions

	zgen oh-my-zsh
	zgen oh-my-zsh plugins/docker
	zgen oh-my-zsh plugins/docker-machine
	zgen oh-my-zsh plugins/docker-compose
	zgen oh-my-zsh plugins/aws
	zgen oh-my-zsh plugins/brew

	zgen load esc/conda-zsh-completion

	# generate the init script from plugins above
	zgen save
fi

bindkey -s '^f' 'fcd ~\n'
bindkey '^e' edit-command-line
bindkey -s '^l' 'lfcd\n'
bindkey '^ ' autosuggest-accept

# prevent conda from changing ps1
conda config --set changeps1 False
