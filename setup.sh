# RUN FROM HOME !!!


# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# # copy config files
# git clone git@github.com:AnHoang97/My-Dotfiles.git .config
# make -C .config all

#########  install zsh config ##################
# install my oh-my-zsh
export ZSH="$HOME/.config/oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/AnHoang97/ohmyzsh/master/tools/install.sh)"

# install zplug
export ZPLUG_HOME="$HOME/.config/zplug"
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh

# # install zsh plugins (introduce oh-my-zsh to delete this)
# git clone https://github.com/kutsan/zsh-system-clipboard.git $HOME/.config/zsh/plugins/zsh-system-clipboard
# git clone https://github.com/urbainvaes/fzf-marks.git $HOME/.config/zsh/plugins/fzf-marks/fzf-marks.plugin.zsh
# git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

# some add rights
sudo chmod -R 755 /usr/local/share/zsh/site-functions
sudo chmod -R 755 /usr/local/share/zsh

# hush login
touch ~/.hushlogin

# install iterm
brew cask install iterm2

# install coreutils
brew install coreutils

# install wget
brew install wget

# install anaconda (has to be updated)
anaconda_url="https://repo.anaconda.com/archive/Anaconda3-2020.07-MacOSX-x86_64.sh"
wget -P /tmp $anaconda_url
sh /tmp/$(basename $anaconda_url) -p /Users/Shared/anaconda3 -b

# install neovim
brew install nvim

# install pynvim packages
pip install pynvim
pip install neovim-remote

# install latex
brew cask install mactex

#install vs-code
brew cask install visual-studio-code

# install tmux
brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

#enable key repeat and set no retarded defaults (you need to log out for it to take effect)
defaults write -g ApplePressAndHoldEnabled -bool true
defaults write -g InitialKeyRepeat -int 10 
defaults write -g KeyRepeat -int 2
defaults write -g NSGlobalDomain ApplePressAndHoldEnabled -bool false
