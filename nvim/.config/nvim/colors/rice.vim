"
" arc's vim colors
" based off lucy/term.vim
"

set background=light
let g:colors_name="rice"

" code
hi Folded       ctermfg=8    ctermbg=none
hi FoldColumn                ctermbg=none
hi NonText      ctermfg=8
hi SpecialKey   ctermfg=8
hi Statement    ctermfg=3

" spell
hi SpellBad     ctermfg=9    ctermbg=none

" highlight
hi Search       ctermfg=15   ctermbg=8
hi Visual       ctermfg=6    ctermbg=none cterm=reverse
hi MatchParen   ctermfg=12   ctermbg=none cterm=reverse
hi ColorColumn               ctermbg=0    cterm=none

" lines
hi CursorLine                             cterm=none
hi CursorLineNr ctermfg=8
hi LineNr       ctermfg=7

" splits
hi SignColumn                ctermbg=none
hi VertSplit    ctermfg=8                 cterm=none

" status
hi StatusLine   ctermfg=8    ctermbg=none cterm=none
hi StatusLineNC ctermfg=8                 cterm=none
hi WildMenu     ctermfg=15   ctermbg=0    cterm=none
hi ModeMsg      ctermfg=8    ctermbg=none cterm=none
hi User1        ctermfg=8    ctermbg=none cterm=none

" tabs
hi TabLine      ctermfg=7    ctermbg=none cterm=none
hi TabLineFill  ctermfg=7    ctermbg=none cterm=none
hi TabLineSel   ctermfg=8    ctermbg=none cterm=none

" diff
hi DiffAdd      ctermfg=14   ctermbg=none
hi DiffChange   ctermfg=12   ctermbg=none
hi DiffDelete   ctermfg=10   ctermbg=none
hi DiffText     ctermfg=9    ctermbg=none

" err
hi Error        ctermfg=1    ctermbg=15 cterm=reverse
hi ErrorMsg     ctermfg=1    ctermbg=15 cterm=reverse
hi WarningMsg   ctermfg=3    ctermbg=15 cterm=reverse
