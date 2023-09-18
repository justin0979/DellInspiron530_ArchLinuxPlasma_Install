" \= optional char before cursor
" \| OR
" \@! NOT match

syntax match myEndStatement +\v;$+
 
"syntax match divHtmlWord +[</]\_s*[a-zA-Z1-9-]\++hs=s+1
syntax match frontHtmlAngleBracket +\v[\w\s]*\zs<\ze\w\++
"syn match htmlTagArrows /</
syntax match myHtmlTag /\v[</]\zs[a-zA-Z0-9-_]+\ze.*/
"syntax match backHtmlAngleBrackets +:</]\w\+\zs>+

syn match myRegexLiteral +\/[^\/]\+\/\ze\w*+

" =>
syn match myArrowFuncSymbol /.*\zs=>\ze.*/

syn match myCallFuncName /\v[a-zA-Z0-9-_]+\ze\(/
" gets only name in `function name() {}` or `const name = () =>`
syn match myObjName / \zs[a-zA-Z0-9-_]\+\ze \=\(=\|(\(\w\+\)\=)\) \=\((\([a-zA-Z0-9_$]\+\)\=) \==>\|{\)/
syn match myObjKeyName /\w\+\ze: \=["'`{(\/0-9a-zA-Z]/
"syn match myObjKeyName /\w\+\ze: \=.*/
syntax match myHtmlAttribute /\_s*\zs[a-zA-Z-_]\+\ze=[{"']/

hi link myHtmlTag htmlTag
hi link myHtmlAttribute htmlTag
hi link javascriptIdentifier typescriptVariable
hi link frontHtmlAngleBracket typescriptVariable
hi link myEndStatement typescriptVariable

hi myRegexLiteral ctermfg=Red guifg=#ff0000
