#!/bin/sh

putgitrepo() { # Downloads a gitrepo $1 and places the files in $2 only overwriting conflicts
	dir=$(mktemp -d)
	git clone --recursive -b "$branch" --depth 1 "$1" "$dir" >/dev/null 2>&1
	cp -rfT "$dir" "$2"
	}

putgitrepo "git@github.com:AnHoang97/dotfiles.git" "~"
