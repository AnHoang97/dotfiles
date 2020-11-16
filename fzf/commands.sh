#! /usr/bin/env sh

# fd - cd to selected directory
unalias fcd 2> /dev/null
fcd() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# Install (one or multiple) selected application(s)
# using "brew search" as source input
unalias finstall 2> /dev/null
finstall() {
	local inst=$(brew search | fzf -m)

	if [[ $inst ]]; then
		for prog in $(echo $inst);
		do; brew install $prog; done;
	fi
}

# fh - repeat history
unalias fhistory 2> /dev/null
fhistory() {
	eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

# finstall - install packages with homebrew 
unalias finstall 2> /dev/null
# Install (one or multiple) selected application(s)
# using "brew search" as source input
finstall() {
	local inst=$(brew search | fzf -m)

	if [[ $inst ]]; then
		for prog in $(echo $inst);
		do; brew install $prog; done;
	fi
}



# ftmux - create new tmux session, or switch to existing one. Works from within tmux too. (@bag-man)
# `tm` will allow you to select your tmux session via fzf.
# `ftmux irc` will attach to the irc session (if it exists), else it will create it.

unalias ftmux 2> /dev/null
ftmux() {
	[[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
	if [ $1 ]; then
	tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
	fi
	
	echo "Press Ctrl-D to delte a session, Ctrl-r to rename a session and Ctrl-S to create a new session"
	out=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0 --expect=ctrl-s,ctrl-r,ctrl-d)

	local key=$(echo $out | head -1)
	local session=$(echo $out | head -2 | tail -1)

	if [[ $key == ctrl-d ]]; then
		tmux kill-session -t "$session" 
		ftmux
	elif [[ $key == ctrl-r ]]; then
		echo "new session name: "
		read sessionname
		tmux rename-session -t "$session" $sessionname
		ftmux
	elif [[ $key == ctrl-s ]]; then
		echo "new session name: "
		read sessionname
		tmux new -s $sessionname -d
		tmux $change -t $sessionname
	else
		tmux $change -t "$session" 
	fi
}


# fsession - managing vim sessions
unalias fsession 2> /dev/null
fsession() {
	echo "Press Ctrl-D to delte a session and Ctrl-S to create a new session"
	local out=$( ls ~/.cache/nvim/session | fzf --exit-0 --expect=ctrl-s,ctrl-d )
	local key=$(echo $out | head -1)
	local vsession=$(echo $out | head -2 | tail -1)

	if [[ $key == ctrl-s ]]; then
		echo "new session name: "
		read sessionname
		echo "create new vim session at $HOME/.cache/nvim/session/$sessionname.vim"
		nvim -c "SaveSession $sessionname"
	elif [[ $key == ctrl-d ]]; then
		rm -i $HOME/.cache/nvim/session/$vsession
		fsession
	elif [[ ! -z $vsession ]]; then
		echo "open vim session at $HOME/.cache/nvim/session/$vsession"
		nvim -S $HOME/.cache/nvim/session/$vsession
	fi
}

