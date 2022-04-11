
" basic configuration options
set number
set fileencodings=utf-8
set encoding=utf-8
set title
set autoindent
set background=dark
set nobackup
set shell=fish
" supress appending <PasteStart> and <PasteEnd> when pasting stuff
set t_BE=

set ignorecase
set smarttab
filetype plugin indent on
set shiftwidth=2
set tabstop=2
set ai
set si
set nowrap
set backspace=start,eol,indent

autocmd InsertLeave * set nopaste

highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40

highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000

runtime maps.vim
runtime plug.vim

let g:github_function_style = "italic"
let g:github_sidebars = ["qf", "vista_kind", "terminal", "packer"]
" Change the "hint" color to the "orange" color, and make the "error" color bright red
let g:github_colors = {
	\ 'hint': 'orange',
	\ 'error': '#ff0000'
\ }

" Use GitHub theme
colorscheme github_dark

