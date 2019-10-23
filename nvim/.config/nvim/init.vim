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
" Plug 'ap/vim-css-color'
" Plug 'justinmk/vim-dirvish'
" Plug 'justinmk/vim-sneak'
" Plug 'kiteco/plugins', { 'rtp': 'vim-kite/plugin/kite.vim' }
" Plug 'mhinz/vim-startify'
" Plug 'mphe/grayout.vim'
" Plug 'nanotech/jellybeans.vim'
" Plug 'nhooyr/neoman.vim'
" Plug 'tpope/vim-abolish'
" Plug 'tpope/vim-eunuch'
" Plug 'tpope/vim-fugitive'
" Plug 'Shougo/deoplete.nvim'
" Plug 'tpope/vim-obsession'

Plug 'benekastah/neomake'
Plug 'jremmen/vim-ripgrep'
Plug 'jamessan/vim-gnupg'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'mbbill/undotree'
Plug 'rking/ag.vim'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'wellle/targets.vim'
call plug#end()
" }}}
" options {{{

" enable mouse
set mouse=a

" show whitespaces
"set listchars=eol:¬,tab:>-,trail:!,extends:>,precedes:<
set listchars=tab:›\ ,eol:¬

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
" show replaces on the fly
set inccommand=nosplit

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
let g:zipPlugin_ext='*.zip,*.jar,*.xpi,*.ja,*.war,*.ear,*.celzip,*.oxt,*.kmz,*.wsz,*.xap,*.docm,*.dotx,*.dotm,*.potx,*.potm,*.ppsx,*.ppsm,*.pptx,*.pptm,*.ppam,*.sldx,*.thmx,*.xlam,*.xlsx,*.xlsm,*.xlsb,*.xltx,*.xltm,*.xlam,*.crtx,*.vdw,*.glox,*.gcsx,*.gqsx,*.epub'

" wrap
set wrap
set breakindent
set breakindentopt=sbr
set showbreak=↪\ 

" limelight 
let g:limelight_conceal_ctermfg = 240

" deoplete
let g:deoplete#enable_at_startup = 1

" no syntax autoindent
filetype indent off
filetype plugin off

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

" toggle line number
nnoremap <silent> <leader>n :set number!<CR>

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

" reverse join
nnoremap K i<CR><Esc>d^==kg_lD

" manpage
nnoremap <silent> <C-'> K

" damn you, vim!
nnoremap Y y$

" make a numeration
vnoremap <C-a> :call Incr()<CR>
" }}}
" abbrev {{{
inoreabbrev ;forall; ∀
inoreabbrev ;exists; ∃
inoreabbrev ;E; ∈
inoreabbrev ;<=; ≤
inoreabbrev ;>=; ≥
inoreabbrev ;^2; ²
inoreabbrev ;^3; ³
inoreabbrev ;C=; ⊆
inoreabbrev ;C; ⊂
inoreabbrev ;not; ¬
inoreabbrev ;and; ∧
inoreabbrev ;or; ∨
inoreabbrev ;->; →
inoreabbrev ;=>; ⇒
inoreabbrev ;<>; ⇔
inoreabbrev ;!=; ≠
inoreabbrev ;t; \texttt{

" inoreabbrev ,U, 
" inoreabbrev ,u, 
" }}}
" commands {{{

com! WP call WordProcessorMode()
com! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
com! Wipeout call s:wipeout()
com! FormatC execute '%g/^\s*\n\s*$/d' | %normal = | nohlsearch | %!indent -kr
com! Time r!date --iso-8601
" }}}
" functions {{{

" word processor mode
function! WordProcessorMode()
	setlocal linebreak
	setlocal wrap
	Goyo
endfunction

" wipe all buffers
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

" create numeration
function! Incr()
	let a = line('.') - line("'<")
	let c = virtcol("'<")
	if a > 0
		execute 'normal! '.c.'|'.a."\<C-a>"
	endif
	normal `<
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

" pnc (pro and contra) filetype
autocmd BufRead,BufNewFile *.pnc set filetype=pnc
autocmd BufRead,BufNewFile *.pnc syntax match pos "^\s*+.*$" 
autocmd BufRead,BufNewFile *.pnc syntax match neg "^\s*-.*$" 
autocmd BufRead,BufNewFile *.pnc highlight pos ctermfg=green
autocmd BufRead,BufNewFile *.pnc highlight neg ctermfg=red

" hoare filetype
autocmd BufRead,BufNewFile *.hoare set filetype=java
autocmd BufRead,BufNewFile *.hoare syntax match assertion "^\s*<.*>\s*$" 
autocmd BufRead,BufNewFile *.hoare highlight assertion ctermfg=darkblue

" disable auto commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" limelight + goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" spaces instead of tabs in .hs
autocmd! BufRead,BufNewFile *.hs set expandtab

" tex no indent
autocmd! BufRead,BufNewFile *.tex set indentexpr=

" }}}
" vim:foldmethod=marker:foldlevel=0
