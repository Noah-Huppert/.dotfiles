" Required vim options for Vundle
set nocompatible
filetype off

" .vimrc auto-reload
augroup reload_vimrc " {
	autocmd!
	autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" set vim shell to bash for Vundle
" set shell=~/.vim/shell-wrapper.sh

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle install instructions
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

Plugin 'VundleVim/Vundle.vim'

" -- Style
" Plugin 'altercation/vim-colors-solarized'
" Plugin 'whatyouhide/vim-gotham'
Plugin 'morhetz/gruvbox'

" -- Behavior
Plugin 'qpkorr/vim-bufkill'
Plugin 'bling/vim-bufferline'
Plugin 'Townk/vim-autoclose'

" -- Language
Plugin 'sheerun/vim-polyglot'
Plugin 'rust-lang/rust.vim'
Plugin 'tikhomirov/vim-glsl'

Plugin 'editorconfig/editorconfig-vim'

call vundle#end()

" Theme
syntax enable
set background=dark
set number
colorscheme gruvbox
"let g:solarized_termcolors=256

" General config
set spell
set colorcolumn=80

" Behavior config
let g:netrw_preview = 2
let g:netrw_liststyle=3
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro' " Always show line numbers, useful for netrw buffer navigation
"let g:netrw_chgwin=2
augroup Format-Options
	autocmd!
	autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

augroup END

" -- Key mapping
" -- -- Move by visual lines (Instead of file lines)
noremap k gk
noremap j gj

" -- -- Disable certain keys
" -- -- -- Arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" -- -- -- Scroll wheel
noremap <ScrollWheelUp>      <NOP>
noremap <S-ScrollWheelUp>    <NOP>
noremap <C-ScrollWheelUp>    <NOP>
noremap <ScrollWheelDown>    <NOP>
noremap <S-ScrollWheelDown>  <NOP>
noremap <C-ScrollWheelDown>  <NOP>
noremap <ScrollWheelLeft>    <NOP>
noremap <S-ScrollWheelLeft>  <NOP>
noremap <C-ScrollWheelLeft>  <NOP>
noremap <ScrollWheelRight>   <NOP>
noremap <S-ScrollWheelRight> <NOP>
noremap <C-ScrollWheelRight> <NOP>

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
:filetype plugin on
