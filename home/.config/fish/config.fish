# Config
# ---- .dotrc
export DOTFILES_REPO_PATH="$HOME/.homesick/repos/.dotfiles"
export DOTRC_FILE_PATH="$DOTFILES_REPO_PATH/.dotrc"

function dotrc-edit
	if test -e $DOTRC_FILE_PATH
		eval $EDITOR $DOTRC_FILE_PATH
	else
		mv $DOTFILES_REPO_PATH/.dotrc.example $DOTFILES_REPO_PATH/.dotrc
		eval $EDITOR $DOTRC_FILE_PATH
		. "$HOME/.config/fish/config.fish"	
	end
end

if test -e $DOTRC_FILE_PATH
	. $DOTRC_FILE_PATH
else
	echo "[WARNING] .dotrc file not found, run `dotrc-edit` (looking in: $DOTFILES_REPO_PATH)"
	echo "          config.fish will not load\n"
	exit -1
end



# ---- Environment
export EDITOR=vim

# ---- Alias
function fish-reload
	. "$HOME/.config/fish/config.fish"
end

function fish-edit
	eval $EDITOR "$HOME/.config/fish/config.fish"
end

function wrk
	cd ~/Documents/workspace
end

# External config
# ---- theme-default
set -g theme_short_path yes # Only show current folder name in path


# ---- Homeshick
. "$HOME/.homesick/repos/homeshick/homeshick.fish"
. "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"
homeshick refresh --quiet

# Languages
# ---- NVM
if eval $DOTRC_NVM = true
	function nvm
		bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
	end
end

# ---- Go
if eval $DOTRC_GO = true
	export GOPATH=$DOTRC_GOPATH
end
