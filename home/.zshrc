# Environment
export PATH="/home/noah/.nvm/versions/node/v6.0.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"

# Config
# -- -- zsh
{ source ~/.config/zshconf/zshconf.zsh } &> /dev/null

# -- -- Environment
export EDITOR=vim

# -- -- .dotrc
export DOTFILES_REPO_DIR="$HOME/.homesick/repos/.dotfiles"
export DOTRC_FILE="$DOTFILES_REPO_DIR/.dotrc"

function dotrc-edit() {
	if [[ ! -f $DOTRC_FILE ]]; then
		mv "$DOTFILES_REPO_DIR/.dotrc.example $DOTRC_FILE"
	fi

	$EDITOR $DOTRC_FILE
}

if [[ -f $DOTRC_FILE ]]; then
	source $DOTRC_FILE
else
	llog $LOG_ERROR ".dotrc file not found, run `dotrc-edit` (expected: $DOTRC_FILE)"
	llog $LOG_ERROR ".zshrc will not load"
	exit 1
fi

if [[ -z $DOTRC_PATH ]]; then
	export PATH="$PATH $DOTRC_PATH"
fi

# -- -- Alias
function zsh-reload() {
	source ~/.zshrc
}

function zsh-edit() {
	$EDITOR ~/.zshrc
}

function wrk() {
	cd ~/Documents/workspace
}

function mcdir() { # (dir)
	mkdir $1
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
