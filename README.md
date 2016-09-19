# .dotfiles
A collection of system configuration files

# Setup
1. Install `zsh`
	- Install zsh and make it the default shell
	- Instructions vary depending on the OS
		- Debian, Install with: `sudo apt-get install -y zsh`
		- Arch, Install with: `sudo pacman -S zsh`
2. Install the `zshconf` tool with: `git clone git@github.com:Noah-Huppert/zshconf $HOME/.config/zshconf`
3. Install the `homeshick` tool with: `git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick`
4. Install `nvm`
	- NVM can be install via git or your OS package manager
	- Via git: `git clone git://github.com/creationix/nvm.git $HOME/.nvm` 
	- Via OS package manager
		- Arch, Install the `nvm` package from AUR
5. Install Go
	- Ubuntu:
		- `sudo add-apt-repository ppa:ubuntu-lxc/lxd-stable`
		- `sudo apt-get update`
		- `sudo apt-get install golang -y`
	- Arch: `sudo pacman -S go`
6. dotrc
	- `dotrc-edit`
		- This command will only work if you reloaded your shell after you cloned down this repository

# dotrc
The purpose of this file is to store configuration values which may differ between computers.

The file itself is typically located in `$HOME/.config/dotrc/config`.
