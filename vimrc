"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Author:  Eric Schmidt
"
" Sections:
"   -> Package Management
"   -> General
"   -> Colors and Fonts
"   -> Vim User Interface
"   -> Moving Around, Tabs and Buffers.
"   -> Status Line
"   -> Files
"   -> Substitution / Searching
"   -> Helper Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Package Managment
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle plugin manager
set nocompatible              
filetype off                  
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" GitHub repos
Bundle 'git://github.com/altercation/vim-colors-solarized.git'
Bundle 'git://github.com/Raimondi/delimitMate'
Bundle 'git://github.com/kien/ctrlp.vim.git'
Bundle 'git://github.com/joonty/vdebug'
Bundle 'git://github.com/scrooloose/nerdtree'
Bundle 'git://github.com/vim-perl/vim-perl'
Bundle 'git://github.com/shawncplus/phpcomplete.vim'
Bundle 'git://github.com/ervandew/supertab'
Bundle 'git://github.com/nelstrom/vim-visual-star-search'
Bundle 'beyondwords/vim-twig'

call vundle#end()           
filetype plugin indent on 

" CtrlP package
set runtimepath^=~/.vim/bundle/ctrlp.vim,~/repos

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Set path to repos
set path+=~/repos/**

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Set 256 color mode 
if &term == "xterm"
    set t_Co=256
endif

let g:solarized_termcolors=256
let g:solarized_termtrans = 0
let g:solarized_degrade = 1 
let g:solarized_bold = 1 
let g:solarized_underline = 1 
let g:solarized_italic = 1 
set background=dark
colorscheme solarized

set colorcolumn=120
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Press i to enter insert mode, and ii to exit  
imap ii <Esc>

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" Ignore case when searching
set ignorecase

" Show matching brackets when text indicator is over them
set showmatch 

" How many tenths of a second to blink when matching brackets
set mat=2

" Show line numbers
set number

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab                                                                

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4"

set ai "Auto indent
set si "Smart indent

" Set paste toggle
set pastetoggle=<F2>

"delete trailing whitespace
map <leader>ws :%s/\s\+$// 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving Around, Tabs and Buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Ctrlp mappings
let g:ctrlp_map = '<c-p>'
 
set tags=tags.tags
nmap <silent> <F4> :call CreateTags()<CR><CR>

"open tag in new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

"active directory
"cnoremap < expr > %%     getcmdtype() = = ':' ? expand('%: h').'/' : ''

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeShowBookmarks=1
map <C-f> :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status Line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn back-up stuff off - use GIT
set nobackup
set nowb
set noswapfile

" Active directory expansion
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Fast saving
nmap <leader>w :w!<cr>

" PHP Syntax Check
map <C-s> :!php -l %<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Substitution / Searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Repeat last substitution and last substitution flags
nnoremap & :&&<CR>
xnoremap & :&&<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

function CreateTags()
    exec ':!ctags -R -f tags.tags --fields=+aimS --languages=php'
endfunction
