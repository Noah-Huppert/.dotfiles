# Config
# -- -- zsh
{ source ~/Documents/bin/zshconf/zshconf.zsh } &> /dev/null

# -- -- Environment
export EDITOR=nvim

# -- -- GPG TTY
export GPG_TTY=$(tty)

# Config dir
export XDG_CONFIG_HOME="$HOME/.config"

# SSH Agent
# Snippet from wiki.archlinux.org/inudex.php/SSH_keys#SSH_agents
export RC_SSH_AGENT_INFO="$HOME/.config/running-ssh-agent-info"

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
	ssh-agent > $RC_SSH_AGENT_INFO
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
	eval "$(<$RC_SSH_AGENT_INFO)" > /dev/null
fi

# -- -- .dotrc
export DOTRC_DIR="$HOME/.config/dotrc"
export DOTRC_FILE="$DOTRC_DIR/config"

function dotrc-edit() {
	if [[ ! -f $DOTRC_FILE ]]; then
		cp "$DOTRC_FILE.example" $DOTRC_FILE
	fi

	$EDITOR $DOTRC_FILE
}

function dotrc-machine-edit() {
	[ -z "$1" ] && echo "Expected 1 argument"

	$EDITOR "$DOTRC_DIR/machines/$1"
}

# -- -- -- load
if [[ -f $DOTRC_FILE ]]; then
	source $DOTRC_FILE

	export DOTRC_MACHINE_FILE="$DOTRC_DIR/machines/$DOTRC_MACHINE"

	# load machine specific config
	if [ ! -z ${DOTRC_MACHINE+x} ]; then
		if [ -f $DOTRC_MACHINE_FILE ]; then
			source $DOTRC_MACHINE_FILE
		else
			llog $LOG_ERROR "cannot load machine specific config (expected: $DOTRC_MACHINE_FILE)"
			llog $LOG_ERROR "ignoring..."

		fi
	fi
		
else
	llog $LOG_ERROR "dotrc file not found, run `dotrc-edit` (expected: $DOTRC_FILE)"
	llog $LOG_ERROR ".zshrc will not load"
	exit 1
fi

if [[ -n $DOTRC_PATH ]]; then
	export PATH="$PATH:$DOTRC_PATH"
fi

# -- -- Alias
function zsh-reload() {
	source ~/.zshrc
}

function zsh-edit() {
	$EDITOR ~/.zshrc
}

# shickcd changes the current working directory to the location of the 
# .dotfiles homeshick repo
function shickcd() {
	echo "Changing working directory to .dotfiles location"
	homeshick cd .dotfiles
}

function wrk() {
	cd ~/Documents/workspace/$1
}

function mcdir() { # (dir)
	mkdir -p $1
	cd $1
}

function serve() {
	python3 -m http.server
}

function venvdir() {# virtual_env
	echo "$HOME/Documents/lib/python/$1"
}

function venv() {# virtual_env
	virtualenv "$(venvdir $1)"
}

function venvactivate() {# virtual_env
	source "$(venvdir $1)/bin/activate"
}

# -- -- Url decode and encode
alias urldecode="python2 -c \"import sys, urllib as ul; [sys.stdout.write(ul.unquote_plus(l)) for l in sys.stdin]\""

alias urlencode="python2 -c \"import sys, urllib as ul; [sys.stdout.write(ul.quote_plus(l)) for l in sys.stdin]\""

# -- -- Homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)
homeshick refresh --quiet

# -- -- NVM
if [[ $DOTRC_NVM == true ]]; then
	if [ -z ${DOTRC_NVM_DIR+x} ]; then
		export NVM_DIR="$HOME/.nvm"
	else
		export NVM_DIR=$DOTRC_NVM_DIR
	fi

	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
fi

# -- -- Go
if [[ $DOTRC_GO == true ]]; then
	export GOPATH=$DOTRC_GOPATH
	export PATH="$PATH:$GOPATH/bin"
fi

# -- -- RVM
if [[ $DOTRC_RVM == true ]]; then
	export PATH="$PATH:$HOME/.rvm/bin"
	[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
fi

# Enable Vim mode in zsh
bindkey -v
export KEYTIMEOUT=1

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
