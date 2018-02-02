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

" Vim Plug
" Install with:
"     curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')

Plug 'VundleVim/Vundle.vim'

" -- Style
" Plug 'altercation/vim-colors-solarized'
" Plug 'whatyouhide/vim-gotham'
Plug 'morhetz/gruvbox'

" -- Behavior
Plug 'qpkorr/vim-bufkill'
Plug 'bling/vim-bufferline'
Plug 'Townk/vim-autoclose'

" -- Language
Plug 'sheerun/vim-polyglot'
Plug 'rust-lang/rust.vim'
Plug 'tikhomirov/vim-glsl'

" -- -- Go
Plug 'fatih/vim-go'

" -- -- Code style
Plug 'editorconfig/editorconfig-vim'

" -- -- Code completion
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-jedi'
let g:deoplete#enable_at_startup = 1

" Install gcode with: go get -u github.com/nsf/gocode
Plug 'zchee/deoplete-go', { 'do': 'make'}
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'

" C++
" Install libclang python bindings: pip install --user nose
Plug 'zchee/deoplete-clang'
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang/'

" Doxygen
Plug 'vim-scripts/DoxygenToolkit.vim'

call plug#end()

" Theme
"syntax enable
syntax on
set background=dark
set number
colorscheme gruvbox
"let g:solarized_termcolors=256

" Search color
set hlsearch
hi clear Search ctermfg
hi Search cterm=NONE ctermfg=grey

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

" -- -- Code folding
set foldenable
set foldmethod=marker
au FileType sh let g:sh_fold_enabled=5
au FileType sh let g:ls_bash=0
au FileType sh set foldmethod=syntax
syntax enable

:filetype plugin on

" -- -- Code Completion
set completeopt+=noinsert
set completeopt+=noselect
