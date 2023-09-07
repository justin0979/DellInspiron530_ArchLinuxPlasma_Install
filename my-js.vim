" Add this to ~/.vim/colors
syntax match divHtmlWord +[</]\_s*[a-zA-Z1-9-]\++hs=s+1
syntax match attrHtmlStuff +\_s*[a-zA-Z]\+[^=]+hs=s+1

hi link divHtmlWord htmlTag
hi link attrHtmlStuff htmlTag

