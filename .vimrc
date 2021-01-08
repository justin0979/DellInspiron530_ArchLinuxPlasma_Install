"execute pathogen#infect()
colorscheme codedark
"let base16colorspace=256
"colorscheme base16-default-dark
syntax enable
filetype plugin indent on
set termguicolors

"packloadall

set showcmd " shows incomplete typed commands in bottom left
set history=1000 " keep 1000 items in vim history, just hit up arrow for prev entries
set hidden " edit multiple files without saving b4 switching buffers
set wildmenu " shows a menu when using tab completion with vim commands
set scrolloff=5 " has 5 lines above cursor with 'z' then enter
set hlsearch " highligts all search terms
set incsearch " highlights matched string as it is typed
set ignorecase " ignores case in searchs
set smartcase " if search patten has capitals, then overrides ignorecase
set lbr " does not wrap in middle of word
set number
set tabstop=2
"set autoindent
set smartindent
set shiftwidth=2
set expandtab
set softtabstop=2
" set list lcs=tab:\|\
set termwinsize=10x0 " sets window height to 10 with ':bel term'

let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"

" =================== coc config =====================
" Configuraton taken from coc.nvim
set nobackup " Some servers have issues with backup files
set nowritebackup

set cmdheight=2 " Give more space for displaying messages.

" Having longer updatetime (default is 4000ms) leads to noticeable
" delays and poor user experience
set updatetime=300

set shortmess+=c " Don't pass messages to |ins-completion-menu|.

" Always show the signcolumn, otherwise it would shift the text
" each time diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" End coc.nvim configuration
" =================== coc config =====================


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
" Open in already open file with ':NERDTree'
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let g:NERDTreeWinPos = "right"
let g:NERDTreeWinSize=25
let g:NERDTreeShowHidden=1
"
" =================== vim-NERDTree =====================
"
" =================== vim-indent-guides =====================
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level=1
let g:indent_guides_guide_size=2
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#444444   ctermbg=240
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#333333   ctermbg=246
"; =================== vim-indent-guides =====================
"
" =================== vim-javascript =====================
let g:javascript_conceal_arrow_function       = "⇒"
let g:javascript_plugin_flow = 1
let g:vim_jsx_pretty_colorful_config = 1 " default 0
" =================== vim-javascript =====================
"
" =================== typescript-vim =====================
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''
" =================== typescript-vim =====================
"
" =================== coc =====================
let g:coc_global_extensions = [ 'coc-tsserver' ]
" =================== coc =====================

highlight String ctermfg=154 guifg=#afff00
highlight Pmenu ctermbg=lightgray guibg=#555555
hi LineNr guifg=#696969 
hi CocErrorSign guifg=#add8e6 ctermfg=lightblue
hi typescriptParens ctermfg=117 guifg=#87d7ff
hi typescriptBraces ctermfg=117 guifg=#87d7ff
hi typescriptDotNotation ctermfg=227 guifg=#ffff87
hi typescriptType ctermfg=green guifg=green
autocmd BufRead,BufNewFile * syn match parens /[(){}]/ | hi parens ctermfg=117 guifg=#87d6ff
autocmd BufRead,BufNewFile * syn match brack /[\[\]]/ | hi brack ctermfg=161 guifg=#d7005f
