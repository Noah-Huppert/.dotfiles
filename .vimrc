set nocompatible
filetype off

" -- Auto reload vimrc
augroup reload_vimrc " {
	autocmd!
	autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" -- Plugin manager
Plugin 'VundleVim/Vundle.vim'

" -- Basic defaults
Plugin 'git://github.com/tpope/vim-sensible.git'

" -- File tree
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "~",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" -- Golang
Plugin 'fatih/vim-go'

" -- Markdown
Plugin 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1

" -- Dockerfile lang
Plugin 'ekalinin/Dockerfile.vim'

" -- JSON
Plugin 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

" -- Buffer explorer
Plugin 'bling/vim-bufferline'

" -- Base-16 theme
Plugin 'chriskempson/base16-vim'
"let base16colorspace=256
"Plugin 'candycode.vim'

" -- Status line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" -- Git integration
" Plugin 'git://github.com/tpope/vim-fugitive.git'

" -- Buffer kill
Plugin 'qpkorr/vim-bufkill'

" -- Code completion
" Plugin 'git://github.com/Valloric/YouCompleteMe'

" -- Indentation
Plugin 'godlygeek/tabular'

" -- Color highlighting
Plugin 'git://github.com/ap/vim-css-color.git'

call vundle#end()
filetype plugin indent on

" Line numbers
set number
set hidden

" Theme
colorscheme base16-paraiso
"set background=dark
let g:airline_theme='simple'
let g:airline_powerline_fonts = 1
let g:airline#extensions#bufferline#enabled = 0

" Keymaps
" -- Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" -- Buffer navigation
map <C-a> :bprevious<CR>
map <C-d> :bnext<CR>

" -- NERDTree
command! NERD NERDTree
command! NERDT NERDTreeToggle
let NERDTreeShowHidden=1

" -- Spellcheck
setlocal spell! spelllang=en_us
