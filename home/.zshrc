# Config
# -- -- zsh
{ source ~/Documents/bin/zshconf/zshconf.zsh } > /dev/null

# -- -- Environment
export TERMINAL=alacritty
export TERM="$TERMINAL"
export EDITOR=nvim
export PAGER=less

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

# Custom scripts bin
export ZSHRC_BIN_DIR="$HOME/Documents/bin/scripts"
export PATH="$PATH:$ZSHRC_BIN_DIR"

# -- -- .dotrc
export DOTRC_DIR="$HOME/.config/dotrc"
export DOTRC_FILE="$DOTRC_DIR/config"

# Edits the dotrc file
function drc-edit() {
	if [[ ! -f $DOTRC_FILE ]]; then
		cp "$DOTRC_FILE.example" $DOTRC_FILE
	fi

	$EDITOR $DOTRC_FILE
}

# Edits a dotrc machine file specified by the first argument
function drcm-edit() {
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
	return 1
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

# changes the current working directory to the location of the .dotfiles 
# homeshick repo
function .filescd() {
	echo "Changing working directory to .dotfiles location"
	homeshick cd .dotfiles
}

function wrk() {
	cd ~/Documents/workspace/$1
}

# Prints the gocd help text
function gocd-help() {
	echo "gocd - Utlity for navigating to directories located in \"\$GOPATH/src\""
	printf "\n"
	echo "USAGE"
	printf "\n"
	echo "    gocd <dir>"
	printf "\n"
	echo "ARGUMENTS"
	printf "\n"
	echo "    dir - Path to append onto \"\$GOPATH/src/\", which gocd will navigate to."
	printf "\n"
	echo "          For convience, if the first segment of this path is \"gh/\", it "
	echo "          will be replaced with \"github.com/\". This allows for easier "
	echo "          access to the \"\$GOPATH/src/github.com/\" directory."
	printf "\n"
	echo "          Another, similar, shortcut is available for one's GitHub username."
	echo "          \"gh/\$GOCD_GH_USERNAME_SHORTCUT\" will be replaced with"
	echo "          \"github.com/\$GOCD_GH_USERNAME_VALUE\"."
	printf "\n"
	echo "CONFIGURATION"
	printf "\n"
	echo "    Environment Variables:"
	printf "\n"
	echo "    GOCD_GH_USERNAME_SHORTCUT - The value which will be replaced by one's"
	echo "                                GitHub username in the <path> argument."
	printf "\n"
	echo "    GOCD_GH_USERNAME - Value which will replace shortcut, short be user's"
	echo "                       full GitHub username."
	printf "\n"
	echo "EXAMPLES"
	printf "\n"
	echo "    For the following examples let \$GOCD_GH_USERNAME_SHORTCUT=\"nh\""
	echo "    and \$GOCD_GH_USERNAME=\"Noah-Huppert\""
	printf "\n"
	echo "    $ gocd gh/foo/bar => \$GOPATH/src/github.com/foo/bar"
	printf "\n"
	echo "    $ gocd gh/nh/bar => \$GOPATH/src/github.com/Noah-Huppert/bar"
	printf "\n"
	echo "    $ gocd foo/gh/nh => \$GOPATH/src/foo/gh/nh"
	printf "\n"
	echo "    $ gocd gopkg.net/foo/bar => \$GOPATH/src/gopkg.net/foo/bar"
	printf "\n"
	echo "    $ gocd ../pkg/dep => \$GOPATH/pkg/dep"
	printf "\n"
	echo "RETURN VALUES"
	printf "\n"
	echo "    0 - Success"
	echo "    1 - General error"
	echo "    2 - Incorrect invokation"
	echo "    3 - Pre-condition fail"
	printf "\n"
}

# Changes the current working directory to: $GOPATH/src/<dir>
# Where <dir> is the first argument provided after gocd. 

# If "gh" is the first element of the <dir> provided, it will be replaced with 
# "github.com". This is a shortcut which allows you to easily access github.com 
# hosted go projects like so: gocd gh/Noah-Huppert/blapchat
function gocd() { # (dir)
	# If no arguments, print help text
	if [[ "$#" == "0" ]]; then
		gocd-help
	fi

	# Check if dir was provided
	dir="$1"
	if [[ -z "$dir" ]]; then 
		echo "Error: Path must be provided as first argument"
		return 2
	fi

	# Check that dir is not: help, h, --help, -h, -help
	if [[ "$1" =~ "^(help|--help|-help|h|-h)$" ]]; then
		gocd-help
		echo "Info: Interpreted first argument as request to display help"
		return 2
	fi

	# Check $GOPATH exists
	if [[ -z "$GOPATH" ]]; then
		echo "Error: \$GOPATH must not be empty"
		return 3
	fi

	# Replace GitHub username shortcut, if config vars are set
	if [[ (! -z "$GOCD_GH_USERNAME_SHORTCUT") && (! -z "$GOCD_GH_USERNAME") ]]; then
		dir=$(echo "$dir" | sed "s/^gh\/$GOCD_GH_USERNAME_SHORTCUT\//gh\/$GOCD_GH_USERNAME\//g")
	fi

	# Replace "gh" shortcut
	dir=$(echo "$dir" | sed "s/^gh\//github.com\//g")

	# Combine $GOPATH and $dir
	dir="src/$dir"
	finalPath="$GOPATH/$dir"

	# Check directory exists
	if [[ ! -d  "$finalPath" ]]; then
		echo "Error: Provided path must exists, was: \"$finalPath\""
		return 3
	fi

	# Cd
	echo "Changing to \$GOPATH/$dir"
	cd "$finalPath"
}

function cdscripts() {
	cd "$HOME/Documents/bin/scripts/"
}

# GOCD configuration variables, see gocd help text for more information
# Sets the placeholder value a user can enter to refer to $GOCD_USERNAME_VALUE
export GOCD_GH_USERNAME_SHORTCUT="nh"
# Sets the value which will replace $GOCD_GH_USERNAME_SHORTCUT in gocd paths
export GOCD_GH_USERNAME="Noah-Huppert"

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

# Opens the install guide included in the github.com/Noah-Huppert/.dotfiles 
# repository.
#
# No arguments are required. However if the first argument is "edit" the install 
# guide will be opened up in the GitHub web editor interface.
function install-guide() {
	# Check if first argument is "edit"
	if [[ "$1" == "edit" ]]; then
		urlPostfix="/_edit"
		openMode="edit"
	else
		openMode="view"
		urlPostfix=""
	fi

	# Open
	echo "Opening .dotfiles install guide to $openMode"
	xdg-open "https://github.com/Noah-Huppert/.dotfiles/wiki/System-Install$urlPostfix"
}

# -- -- Url decode and encode
alias urldecode="python2 -c \"import sys, urllib as ul; [sys.stdout.write(ul.unquote_plus(l)) for l in sys.stdin]\""

alias urlencode="python2 -c \"import sys, urllib as ul; [sys.stdout.write(ul.quote_plus(l)) for l in sys.stdin]\""

# -- -- One char less alias
alias l=less

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
if [[ "$DOTRC_GO" == "true" ]]; then
	export GOPATH=$DOTRC_GOPATH
	export PATH="$PATH:$GOPATH/bin"
fi

# -- -- RVM
if [[ "$DOTRC_RVM" == "true" ]]; then
	export PATH="$PATH:$HOME/.rvm/bin"
	[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
fi

if [[ "$DOTRC_RUBY" == "true" ]]; then
	PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
fi

# Enable Vim mode in zsh
bindkey -v
export KEYTIMEOUT=1

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Completion: TODO: WIP
#export fpath="$fpath:$HOME/

# added by travis gem
[ -f /home/noah/.travis/travis.sh ] && source /home/noah/.travis/travis.sh

# -- -- Tmux
# if not already running
# and we are running in a GUI environment (we don't 
# want to start tmux unless we have already run startx, b/c startx can not run in tmux)
if [[ ( -z "$TMUX" ) && ( ! -z "$DISPLAY") ]]; then
	tmux && exit
# If we are running tmux
elif [[ ! -z "$TMUX" ]]; then
	tmux source-file "$HOME/.tmux.conf"
fi

export JAVA_OPTS='-XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee'

# https://gist.github.com/matthewmccullough/787142
HISTSIZE=5000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=5000               #Number of history entries to save to disk
HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt incappendhistory #Immediately append to the history file, not just when a term is killed
