set nocompatible
filetype off

" .vimrc auto-reload
augroup reload_vimrc " {
	autocmd!
	autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" set vim shell to bash for Vundle
set shell=~/.vim/shell-wrapper.sh

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle install instructions
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

Plugin 'VundleVim/Vundle.vim'

" -- Style
Plugin 'altercation/vim-colors-solarized'

" -- Behavior
Plugin 'qpkorr/vim-bufkill'
Plugin 'bling/vim-bufferline'
Plugin 'Townk/vim-autoclose'
Plugin 'dag/vim-fish'
runtime macros/matchit.vi

" -- Language
Plugin 'sheerun/vim-polyglot'
Plugin 'rust-lang/rust.vim'
Plugin 'tikhomirov/vim-glsl'

call vundle#end()

" Theme
syntax enable
set background=light
set number
colorscheme solarized
"let g:solarized_termcolors=256

" General config
set spell

" Behavior config
let g:netrw_preview = 1
let g:netrw_liststyle=3
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro' " Always show line numbers, useful for netrw buffer navigation
"let g:netrw_chgwin=2
augroup Format-Options
	autocmd!
	autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

augroup END

" -- Key mapping
" -- -- Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" -- -- Buffer navigation
map <C-a> :bprevious<CR>
map <C-d> :bnext<CR>
map <C-c> :BD<cr>

filetype plugin indent on
filetype plugin on
