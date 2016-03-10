#!/bin/bash
indent() { sed 's/^/     /'; }

# Symlinks
echo "
####################
#     Symlinks     # 
####################"

if ! [ -L ".vimrc" ]; then
	ln -s ./.vimrc ~/.vimrc
fi

echo "[Linked] .vimrc"
echo 

# Vim Bootstrap
echo "
####################
#   Bootstrapping  #
####################"

if [ -f "~/.vim/bundle/Vundle.vim" ]; then
	echo "[Bootstrapped] Vim Vundle (Installed)"
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim | indent
else
	echo "[Bootstrapped] Vim Vundle (Updated)"
	git -C ~/.vim/bundle/Vundle.vim pull origin master | indent
fi
echo
