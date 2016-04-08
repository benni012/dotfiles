" my vimrc
" general {{{

set runtimepath+=~/.fzf

" enable syntax
syntax on

" set colorscheme
colorscheme term
" }}}
" plugins {{{

call plug#begin()
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-sensible'
Plug 'jamessan/vim-gnupg'
Plug 'tpope/vim-speeddating'
Plug 'ap/vim-css-color'
Plug 'nanotech/jellybeans.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/goyo.vim'
Plug 'benekastah/neomake'
Plug 'mbbill/undotree'
Plug 'nhooyr/neoman.vim'
Plug 'tpope/vim-vinegar'
"Plug 'mhinz/vim-startify'
call plug#end()
" }}}
" options {{{

" show whitespaces
"set listchars=eol:¬,tab:>-,trail:!,extends:>,precedes:<
set listchars=tab:›\ 

" abbreviate stuff 
set shortmess=atI

" lazyredraw
set lazyredraw

" undo opts
set undofile
set undodir=~/.config/nvim/undo

" statusline
set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%=%-16(\ %l,%c-%v\ %)%P

"" highlight search matches
set hlsearch

" show next match while typing
set incsearch

" ignore case
set ignorecase
set smartcase

" wrap search
set wrapscan

" enable line numbers
set number 

" enable cursorline
set cursorline

" disable the ruler at the bottom left
set noruler

" enable these nifty modelines 
set modeline

" tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=0
set noexpandtab

" when joining lines, remove comment character
set formatoptions+=j

" remove docx from gzip
let g:zipPlugin_ext='*.zip,*.jar,*.xpi,*.ja,*.war,*.ear,*.celzip,*.oxt,*.kmz,*.wsz,*.xap,*.docm,*.dotx,*.dotm,*.potx,*.potm,*.ppsx,*.ppsm,*.pptx,*.pptm,*.ppam,*.sldx,*.thmx,*.xlam,*.xlsx,*.xlsm,*.xlsb,*.xltx,*.xltm,*.xlam,*.crtx,*.vdw,*.glox,*.gcsx,*.gqsx'
" }}}
" keybinds {{{

" leader is comma
let mapleader=","

" jk is the exit mode key
inoremap jk <ESC>

" move the cursor by visual line
nnoremap j gj
nnoremap k gk

" faster window switch
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" get rid of the highlights
nnoremap <silent> <leader><space> :nohlsearch<CR>

" toggle listchars
nnoremap <silent> <leader>l :set list!<CR>

" toggle fold
nnoremap <space> za

" source/edit vimrc
nnoremap <silent> <leader>sv :source ~/.vimrc<CR>
nnoremap <silent> <leader>ev :vsp ~/.vimrc<CR>

" toggle relative line numbers
nnoremap <silent> <leader>rl :set relativenumber!<CR>

" toggle undotree
nnoremap <silent> <leader>u :UndotreeToggle<CR>

" super-save
nnoremap <leader>w :update<CR>

" arrow keys resize views
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
nnoremap <Up> :resize -2<CR>
nnoremap <Down> :resize +2<CR>

" keep the cursor in place when joining lines
nnoremap J mzJ`z

" damn you, vim!
nnoremap Y y$
" }}}
" commands {{{

com! WP call WordProcessorMode()
com! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
com! Wipeout call s:wipeout()
" }}}
" functions {{{

func! WordProcessorMode() 
	setlocal formatoptions=1 
	setlocal noexpandtab 
	"setlocal spell spelllang=en_us 
	"set thesaurus+=~/.config/nvim/thesaurus/mthesaur.txt
	set complete+=s
	set formatprg=par
	setlocal wrap 
	setlocal linebreak 
	Goyo
endfu 

function! s:wipeout()
	let tpbl=[]
	call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
	let wiped = 0
	for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1 && !getbufvar(v:val,"&mod")')
		silent execute 'bwipeout!' buf
		let wiped += 1
	endfor
	echom wiped . ' buffers wiped'
endfunction

" }}}
" autocmds {{{

" Read-only pdf through pdftotext
autocmd! BufReadPre *.pdf silent set ro
autocmd! BufReadPost *.pdf silent %!pdftotext -nopgbrk -layout -q -eol unix "%" - | fmt -w78

autocmd! BufReadPre *.doc,*.docx,*.rtf,*.odp,*.odt silent set ro
autocmd BufReadPost *.doc,*.docx,*.rtf,*.odp,*.odt silent %!pandoc "%" -tplain -o /dev/stdout

" strip trailing whitespace
autocmd BufWritePre *.java,*.c,*.cpp,*.html,*.css,*.txt :%s/\s\+$//e

" c set compiler
autocmd BufRead,BufNewFile *.c set makeprg=cc\ %

" pnc (Pro and Contra) filetype
autocmd BufRead,BufNewFile *.pnc set filetype=pnc
autocmd BufRead,BufNewFile *.pnc syntax match pos "^\s*+.*$" 
autocmd BufRead,BufNewFile *.pnc syntax match neg "^\s*-.*$" 
autocmd BufRead,BufNewFile *.pnc highlight pos ctermfg=green
autocmd BufRead,BufNewFile *.pnc highlight neg ctermfg=red

" }}}
" vim:foldmethod=marker:foldlevel=0
