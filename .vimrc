execute pathogen#infect()
colorscheme codedark
"let base16colorspace=256
"colorscheme base16-default-dark
syntax enable
filetype plugin indent on

set showcmd " shows typed commands in bottom left
set history=1000
set hidden
set wildmenu " shows a menu when using tab completion
set scrolloff=5 " has 5 lines above cursor with 'z' then enter
set hlsearch " highligts all search terms
set incsearch " highlights matched string as it is typed
set ignorecase " ignores case in searchs
set smartcase " if search patten has capitals, then overrides ignorecase
set lbr " does not wrap in middle of word
set number
set tabstop=2
set autoindent
set smartindent
set shiftwidth=2
set expandtab
set softtabstop=2
set list lcs=tab:\|\

let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"


" =================== vim-base16 =====================
"  function! s:base16_customize() abort
"    call Base16hi("MatchParen", g:base16_gui05, g:base16_gui03, g:base16_cterm05, g:base16_cterm03, "bold,italic", "")
"  endfunction
"  
"  augroup on_change_colorschema
"    autocmd!
"    autocmd ColorScheme * call s:base16_customize()
"  augroup END
" =================== vim-base16 =====================
"
" =================== vim-code-dark =====================

" let g:airline_theme = 'codedark'
" set enc=utf-8
" set guifont=Powerline_Consolas:h11
" set renderoptions=type:directx,gamma:1.5,contrast:0.5,geom:1,renmode:5,taamode:1,level:0.5

" =================== vim-code-dark =====================

" =================== vim-prettier =====================

let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

let g:prettier#config#print_width=68

let g:prettier#config#bracket_spacing = 'true'

let g:prettier#config#trailing_comma = 'all'

" =================== vim-prettier =====================
"
" =================== vim-closetag =====================
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx,*ts'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'
"
" =================== vim-closetag =====================

" =================== vim-NERDTree =====================
" Open NERDTree automatically
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let g:NERDTreeWinPos = "right"
let g:NERDTreeWinSize=25
"
" =================== vim-NERDTree =====================
"
" =================== vim-indent-guides =====================
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=darkgrey
"; =================== vim-indent-guides =====================
