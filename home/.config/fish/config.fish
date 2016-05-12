# Config
# ---- Environment
export EDITOR=vim

# ---- Alias
function fish-reload
	. "$HOME/.config/fish/config.fish"
end

function fish-edit
	eval $EDITOR "$HOME/.config/fish/config.fish"
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
function nvm
	bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

# ---- Go
export GOPATH="$HOME/Documents/workspace/go"
