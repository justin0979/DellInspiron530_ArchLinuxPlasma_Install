"To unfold an area, type 'za' when cursor is on line
"To fold, place cursor anywhere in marked area and type 'za'
"colorscheme codedark
syntax enable
filetype plugin indent on
set termguicolors

packloadall

let mapleader = "\<space>" 
let maplocalleader = ","


" swap window
nnoremap <leader>m <c-w><c-w>
nnoremap <localleader>n <esc><c-w><c-w>
nnoremap <N <c-w><c-w>
nnoremap ,<down> <c-w><c-w>

nnoremap <leader>g :execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>

" setup folding
" 'za' folds and unfolds marked area where cursor is at
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

" Operator mappings --------------------- {{{
" find '}' and delete contents with either 'dc' or 'cc', c = curly braces
onoremap { :normal! f}vi{<cr>
onoremap } :normal! F{vi{<cr>
onoremap c :normal! f}vi{<cr>
onoremap C :normal! F{vi{<cr>
" find ')' and delete contents with either 'dp' or 'dp', p = parenthesis
onoremap ( :normal! f)vi(<cr>
onoremap ) :normal! F(vi(<cr>
onoremap p :normal! f)vi(<cr>
onoremap P :normal! F(vi(<cr>

" }}}

" key remappings ----------------- {{{

" ID syntax highlighting group ----------------- {{{
" From Vim Tips Wiki, author Charles E. Campbell, Jr.
" Identify the syntax highlighting group used at the cursor
nnoremap <leader>h :echo "highest<" . synIDattr(synID(line("."),col("."),1),"name") . '> transparent<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lowest<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" }}}
" comment out jsx line
nnoremap <leader>cl I{/*<esc>A*/}<esc>

"surround current string with ()
nnoremap s( ciw(<esc>pa)<esc>
nnoremap s) ciw(<esc>pa)<esc>

" surround current line with ()
nnoremap sl( I(<esc>A)<esc>
nnoremap sl) I(<esc>A)<esc>

" surround current string with {}
nnoremap s{ ciw{<esc>pa}<esc>
nnoremap s} ciw{<esc>pa}<esc>
inoremap <c-s>c <esc>ciw{<esc>pa}

" surround current line with {}
nnoremap sl{ I{<esc>A}<esc>
nnoremap sl} I{<esc>A}<esc>
 
" surround current string with []
nnoremap s[ ciw[<esc>pa]<esc>
inoremap <c-s>b <esc>ciw[<esc>pa]

" surround current line with []
nnoremap sl[ I[<esc>A]<esc>
nnoremap sl] I[<esc>A]<esc>

" surround current string with ""
nnoremap s" ciw"<esc>pa"<esc>
nnoremap <c-s>q <esc>ciw"<esc>pa"

" surround current line with ""
nnoremap sl" I"<esc>A"<esc>

" surround current string with ''
nnoremap s' ciw'<esc>pa'<esc>

" surround currint line with ''
nnoremap sl' I'<esc>A'<esc>

" surround current string with ``
nnoremap s` ciw`<esc>pa`<esc>

" surround current line with ``
nnoremap sl` I`<esc>A`<esc>
 
" surround current string with <>
nnoremap s< ciw<<esc>pa><esc>
nnoremap s> ciw<<esc>pa><esc>

" surround with /* */
nnoremap sl* I/*<space><esc>A<space>*/<esc>

"echo '(>^.^<)'

" execute deleting line while in insert mode
inoremap <c-d> <esc>ddO
nnoremap <leader>d dd

" upper case the selected word
inoremap <c-u> <esc>viw U
nnoremap <leader>u viwU

" set wrap and nowrap in normal mode
nnoremap <leader>w :set wrap<cr>
nnoremap <leader>nw :set nowrap<cr>

" set no highlighting
nnoremap <leader>nh :nohlsearch<cr>

" make all searches very magic
nnoremap / /\v

" Find excess white spaces after line
nnoremap <leader>ws :match Error /\v[^ ]\s+$/<cr>
"}}}

" Basic settings ---------------- {{{
set showcmd " shows incomplete typed commands in bottom left
set history=1000 " keep 1000 items in vim history, just hit up arrow for prev entries
set hidden " edit multiple files without saving b4 switching buffers
set wildmenu " shows a menu when using tab completion with vim commands
set scrolloff=5 " has 5 lines above cursor with 'z' then enter
set hlsearch " highligts all search terms
set incsearch " highlights matched string as it is typed
set ignorecase " ignores case in searchs
set smartcase " if search patten has capitals, then overrides ignorecase
set nowrap
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
" }}}

" plugin configuratons -------------------- {{{
" COC configurations --------------------- {{{
" =================== coc config =====================
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

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

augroup cochighlight
  autocmd!
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup end

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  " From coc-css docs
  autocmd FileType scss setl iskeyword+=@-@
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" From coc-prettier docs
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

let g:coc_global_extensions = [ 
      \'coc-clangd',
      \'coc-css',
      \'coc-highlight', 
      \'coc-html', 
      \'coc-json', 
      \'coc-tsserver',
      \'coc-vetur'
      \]
" =================== END coc config =====================
" }}}

" vim-prettier configuraton -------------------------- {{{
" =================== vim-prettier =====================

" Enable auto formatting for files that have '@format' or '@prettier' tag
let g:prettier#autoformat = 0

" To run vim-prettier not only before saving, but also after changing text or
" leaving insert mode:
" let g:prettier#quickfix_enabled = 1
augroup vimprettier
  autocmd!
 " autocmd TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html PrettierAsync
  " Old way of formatting only on saves
  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html PrettierAsync
augroup end

let g:prettier#config#print_width = 63

let g:prettier#config#bracket_spacing = 'true'

let g:prettier#config#trailing_comma = 'all'

" =================== END vim-prettier =====================
" }}}
 
" vim-closetag configuration ------------------- {{{
" =================== vim-closetag =====================
 
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx,*ts'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
 
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
 
let g:closetag_filetypes = 'html,xhtml,phtml,ts,tsx,js,jsx'

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
" =================== END vim-closetag =====================
" }}}

" NERDTree configuraton ------------------------- {{{
" =================== vim-NERDTree =====================
"
" NERDTree commands:
" Press i to open the file in new horizontal split
" Press s to open the file in new vertical split
" Press r to refresh thes current directory
" Press m to launch NERDTree menu inside vim
" Press p to go to parent dir
" 
" Open NERDTree automatically
" Open in already open file with ':NERDTree'
augroup nerdtreegroup
  autocmd!
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
augroup end

let g:NERDTreeWinPos = "left"
let g:NERDTreeWinSize=23
let g:NERDTreeShowHidden=1
"
" =================== END vim-NERDTree =====================
" }}}

" vim-indent-guides configuration ---------------- {{{
" =================== vim-indent-guides =====================
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level=1
let g:indent_guides_guide_size=2
augroup vimindentgroup
  autocmd!
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#444444   ctermbg=240
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#333333   ctermbg=246
augroup end
" =================== END vim-indent-guides =====================
" }}}

" emmet-vim configuration --------------------- {{{
" =================== emmet-vim =====================
 
" Set all g:user_emmet_settings configurationns in ~/.snippets_custom.json
" requires `git clone git@github.com:mattn/webapi-vim.git`
let g:user_emmet_settings = webapi#json#decode(join(readfile(expand('~/.snippets_custom.json')), "\n"))

" =================== END emmet-vim =====================
" }}}

" vim-rest-console -------------------- {{{
" =================== vim-rest-console =====================
let g:vrc_horizontal_split = 1
" ================= END vim-rest-console ===================
" }}}
" }}}

" highligting configurations --------------- {{{
highlight String ctermfg=76 guifg=#5fd700
highlight Pmenu ctermbg=lightgray guibg=#555555
highlight Number ctermfg=255 guifg=#eeeeee
highlight Statement ctermfg=227 guifg=LightGoldenrod1
highlight LineNr ctermfg=240 guifg=Grey35

" coc highlight settings --------------- {{{
hi CocErrorFloat ctermfg=195 guifg=#d7ffff
hi CocErrorHighlight cterm=strikethrough ctermfg=9 guifg=#ff0000
hi CocErrorSign ctermfg=9 guifg=#ff0000
" }}}

hi htmlTag ctermfg=117 guifg=#87d7ff
hi htmlTagName cterm=bold ctermfg=83 guifg=#5fff5f

hi javascriptComment ctermfg=8 guifg=#808080

hi jsFuncCall ctermfg=191 guifg=DarkOliveGreen1
hi jsParens ctermfg=105 guifg=LightSlateBlue

hi javascriptParens ctermfg=159 guifg=#afffff

hi javaScriptVariableDeclaration ctermfg=10 guifg=#00ff00

" typescript highlighting ------------- {{{
hi tsxAttrib ctermfg=75 guifg=#5fafff
hi tsxCloseTag ctermfg=247 guifg=#9e9e9e
hi tsxTag ctermfg=247 guifg=#9e9e9e

hi typescriptArrowFunc ctermfg=81 guifg=#5fd7ff
hi typescriptArrowFuncArg ctermfg=227 guifg=#ffff87
hi typescriptArrowFuncDef ctermfg=227 guifg=#ffff87

hi typescriptBlock ctermfg=51 guifg=#00ffff
hi typescriptBraces ctermfg=117 guifg=#87d7ff

hi typescriptCall ctermfg=51 guifg=#00ffff
hi typescriptCase ctermfg=147 guifg=#afafff
hi typescriptClassKeyword cterm=bold ctermfg=155 guifg=#afff5f
hi typescriptClassName ctermfg=112 guifg=#87d700
hi typescriptComment ctermfg=8 guifg=#808080

hi typescriptConditional ctermfg=147 guifg=#afafff
hi typescriptConditionalParen ctermfg=51 guifg=#00ffff
hi typescriptConstructor ctermfg=86 guifg=#5fffd7

hi typescriptDestructureVariable ctermfg=39 guifg=#00afff
hi typescriptDocComment ctermfg=8 guifg=#808080
hi typescriptDotNotation ctermfg=227 guifg=#ffff87

hi typescriptEnumKeyword ctermfg=14 guifg=#40ffff
hi typescriptExport ctermfg=yellow  guifg=yellow

hi typescriptFuncArg ctermfg=153 guifg=#afd7ff
hi typescriptFuncCallArg ctermfg=153 guifg=#afd7ff
hi typescriptFuncImpl ctermfg=green guifg=green
hi typescriptFunctionMethod ctermfg=yellow guifg=yellow
hi typescriptFuncName ctermfg=195 guifg=#d7ffff

hi typescriptIdentifierName ctermfg=10 guifg=#00ff00
hi typescriptImport ctermfg=171 guifg=#d75fff

hi typescriptObjectLabel ctermfg=229 guifg=#ffffaf
"hi typescriptObjectStaticMethod ctermfg=yellow guifg=yellow
hi typescriptObjectLiteral ctermfg=51 guifg=#00ffff
"hi typescriptObjectMethod ctermfg=yellow guifg=yellow
"hi typescriptObjectAsyncKeyword ctermfg=yellow guifg=yellow

hi typescriptParens ctermfg=159 guifg=#afffff

hi typescriptRegexpString ctermfg=178 guifg=#d7af00

hi typescriptType ctermfg=green guifg=green
hi typescriptTypeReference ctermfg=10 guifg=#00ff00

hi typescriptVars ctermfg=green guifg=green
hi typescriptVariable ctermfg=105 guifg=#8787ff
hi typescriptVariableDeclaration ctermfg=10 guifg=#00ff00
" }}}

" sass highlighting ----------- {{{
hi sassMediaQuery ctermfg=208 guifg=#ff8700
" }}}

hi Function ctermfg=50 guifg=#00FFD7

hi cssBraces ctermfg=yellow guifg=yellow
" value of declaration
hi cssProp ctermfg=45 guifg=#00d7ff
" }}}

" autocmd ------------ {{{

" autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" commentgroup ------------ {{{
augroup commentgroup
  autocmd!
  " multi-line comments on one line with <localleader>c
  autocmd FileType scss nnoremap <buffer> <localleader>c A<space>*/<esc>I/*<space><left><esc>
  " multi-line comments on 3 lines with <localleade>m
  autocmd FileType scss nnoremap <buffer> <localleader>m I/*<cr><cr>*/<up>
  " surround line with multiline comment with <localleader>c
  autocmd FileType javascript,typescript,javascriptreact,typescriptreact nnoremap <buffer> <localleader>c I<space><esc>0v$<left>dI/**<cr><cr>/<left><up><esc>A<esc>p
  " blank multiline comment with <localleader>m
  autocmd FileType javascript,typescript,javascriptreact,typescriptreact nnoremap <buffer> <localleader>m I/**<cr><cr>/<left><up><space><esc>A
  " py - comment current line
  autocmd FileType python nnoremap <buffer> <localleader>c I#<space><esc>
augroup end
"}}}

" ifgroup ------------ {{{
augroup ifgroup
  autocmd!
  " javascript based if statement with iff
  autocmd FileType javascript,typescript :iabbrev <buffer> iff {<cr>}<esc>bIif<space><space><left>()<left>
  autocmd FileType javascriptreact :iabbrev <buffer> iff {<cr>}<esc>bIif<space><space><left>()<left>
  autocmd FileType typescriptreact :iabbrev <buffer> iff {<cr>}<esc>bIif<space><space><left>()<left>
  " cpp iff
  autocmd FileType cpp iabbrev <buffer> iff if<space>()<cr>{}<esc>bba
  " python iff
  autocmd FileType python iabbrev <buffer> iff if:<left>
augroup end
" }}}

" printfuncs ------- {{{
augroup printfuncs
  autocmd!
  " py - surround current line with print(...) with <localleade>p
  autocmd FileType python iabbrev <buffer> <localleader>p <esc>Iprint(<delete><esc>A)
  autocmd FileType python nnoremap <buffer> <localleader>p Iprint(<esc>A)
augroup end
" }}}

" function ------------ {{{
augroup functiongroup
  autocmd!
  "setup function by typing name of function then <localleader>f, i.e.:
  " hello <localleader>f
  " result: function hello ( ) {
  "         }
  autocmd FileType javascript,typescript :iabbrev <buffer> <localleader>f <esc>bifunction<space><esc>A()<space>{<cr>}<esc>bba
  autocmd FileType javascriptreact,typescriptreact :iabbrev <buffer> <localleader>f <esc>bifunction<space><esc>A()<space>{<cr>}<esc>bba
  " setup arrow function for export <localleader>a 
  autocmd FileType typescript,javascript :iabbrev <buffer> <localleader>a () => {<cr>}<esc>bbba
  autocmd FileType javascriptreact,typescriptreact :iabbrev <buffer> <localleader>a () => {<cr>}<esc>bbba
augroup end
" }}}

" Javascript based autocmd group ------------- {{{
augroup jsbasedgroup
  autocmd!
  " setup useEffect Hook with <localleader>u
  autocmd FileType typescriptreact,javascriptreact :iabbrev <buffer> <localleader>u useEffect(() => {<cr>}, [])<esc>O
  " setup for loop with forr
  autocmd FileType javascript,typescript :iabbrev <buffer> forr {<cr>}<esc>bIfor<space><space><left>()<left>
  autocmd FileType javascriptreact :iabbrev <buffer> forr {<cr>}<esc>bIfor<space><space><left>()<left>
  autocmd FileType typescriptreact :iabbrev <buffer> forr {<cr>}<esc>bIfor<space><space><left>()<left>
  " comment out current line cursor is on <leader>c
  autocmd FileType javascript,typescript nnoremap <buffer> <leader>c I//<esc>
  autocmd FileType javascriptreact,typescriptreact nnoremap <buffer> <leader>c I//<esc>
  " multiline comment with <localleader>c
  autocmd BufNewFile,BufRead *.json setlocal nowrap
augroup end
" }}}
 
" html type ---------- {{{
augroup htmltype
  autocmd!
" delete content between html tags
  autocmd FileType html,typescriptreact,javascriptreact onoremap < :<c-u>normal! F>lvf<h<cr>
  autocmd FileType html,typescriptreact,javascriptreact onoremap > :<c-u>normal! F>lvf<h<cr>
augroup end 
" }}}
" }}}

" Groupings ----------------- {{{
augroup parenspairgroup
  autocmd!
  autocmd BufRead,BufNewFile * syn match parens /[(){}]/ | hi parens ctermfg=117 guifg=#87d6ff
  autocmd BufRead,BufNewFile * syn match brack /[\[\]]/ | hi brack ctermfg=161 guifg=#d7005f
augroup end

augroup jsonsytaxgroup
  autocmd!
  autocmd FileType json syntax match Comment +\/\/.\+$+
augroup end

augroup filetype_html
  autocmd!
  " Create a fold in html
  " To unfold: zd
  autocmd FileType html,typescriptreact,typescript,javascript,javascriptreact nnoremap <buffer> <localleader>f Vatzf
augroup end
" }}}

"open .vimrc horizontal split screen
nnoremap <leader>ev :execute "rightbelow split " . $MYVIMRC<cr>

" source .vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

au BufNewFile,BufRead *.ejs set filetype=html
