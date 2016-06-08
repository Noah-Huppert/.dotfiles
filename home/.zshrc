# Environment
export PATH="/home/noah/.nvm/versions/node/v6.0.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"

# Config
# -- -- zsh
{ source ~/.config/zshconf/zshconf.zsh } &> /dev/null

# -- -- Homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)
homeshick refresh --quiet
