# .dotfiles
A collection of system configuration files

# Setup
1. Fish
	- `sudo apt-get install fish -y`
2. Fisherman
	- `curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisherman`
3. Homeshick
	- `git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick`
4. NVM
	- `git clone git://github.com/creationix/nvm.git $HOME/.nvm` 
5. Go
	- `sudo add-apt-repository ppa:ubuntu-lxc/lxd-stable`
	- `sudo apt-get update`
	- `sudo apt-get install golang -y`
6. `.dotrc`
	- `dotrc-edit`
		- This command will only work if you reloaded your shell after you cloned down this repository

# `.dotrc`
The purpose of this file is to store configuration values which may differ between computers.
