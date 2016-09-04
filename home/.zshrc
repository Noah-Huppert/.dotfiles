mcdir() { # (dir)
	mkdir -p $1
	cd $1
}

# -- -- Homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)
homeshick refresh --quiet

# -- -- NVM
if [[ $DOTRC_NVM == true ]]; then
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
fi

# -- -- Go
if [[ $DOTRC_GO == true ]]; then
	export GOPATH=$DOTRC_GOPATH
fi
