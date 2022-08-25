"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""						
"  <<<==============================							"
"       _     _ _         _       								"
"      |_|___|_| |_   _ _|_|_____ 								"
"      | |   | |  _|_| | | |     |								"
"      |_|_|_|_|_| |_|\_/|_|_|_|_|	v2							"
"																"
"   ===============================>>>                         	"
"																"
" Sections														"
" => General							 						"
" => VIM User Interfaces										"
" => Colors and Fonts											"
" => Text, tab and intend related 								"
" => Files and backups 											"
" => Plugins 													"
"	 															"
" Editor:		    nvim										"
" Dependencies: 	git, vim-plug 								"
" Stolen from:		https://github.com/amix/vimrc/				"
"																"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General 													"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" :wdoas and :wsudo saves the file
" (useful for handling the permission-denied error)
command! Wdoas execute 'w !doas tee % > /dev/null' <bar> edit!
command! Wsudo execute 'w !sudo tee % > /dev/null' <bar> edit!



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface											"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Avoid garbled characters in Chinese language windows OS "
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set wildmenu							" Turn on the Wild menu
set number								" Show the numbers
set ruler								" Always show current position
set cmdheight=1							" Height of the command bar
set hid									" A buffer becomes hidden when it is abandoned 

" Configure backspace so it acts as it should act "
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
 
set ignorecase 							" Ignore case when searching
set smartcase							" When searching try to be smart about cases
set hlsearch							" Highlight search results 
set incsearch							" Makes search act like search in modern browsers
set lazyredraw							" Don't redraw while executing macros (good performance config) 
set magic								" For regular expressions turn magic on 
set showmatch							" Show matching brackets when text indicator is over them 
set mat=2								" How many tenths of a second to blink when matching brackets
set foldcolumn=1						" Add a bit extra margin to the left

" No annoying sound on errors "
set noerrorbells
set novisualbell
set t_vb=
set tm=500



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts											"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting "
syntax enable

" Enable 256 colors palette in Gnome Terminal "
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

set background=dark

" Set extra options when running in GUI mode "
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language "
set encoding=utf8

" Use Unix as the standard file type "
set ffs=unix,dos,mac



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related 								"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs "
set expandtab

" Be smart when using tabs ;) "
set smarttab

" 1 tab == 4 spaces "
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters "
set lbr
set tw=500

set ai 								"Auto indent
set si 								"Smart indent
set wrap 							"Wrap lines



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo									"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. "
set nobackup
set nowb
set noswapfile



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins 													"			
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')
" Line Plugins "
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Theme Plugins "					
"Plug 'flazz/vim-colorschemes'		" Collection of themes
Plug 'sainnhe/everforest' 			" Everforest theme
Plug 'NLKNguyen/papercolor-theme'	" Papercolor theme

" Start screen "
Plug 'mhinz/vim-startify'			" Fancy start screen

" Devel Plugins "
Plug 'preservim/nerdtree'     		" File Tree
Plug 'ryanoasis/vim-devicons' 		" Fancy Icons

" Programming Langs "
Plug 'StanAngeloff/php.vim'			" PHP
Plug 'rust-lang/rust.vim'			" Rust

call plug#end()

colorscheme everforest				" Colorscheme