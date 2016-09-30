syn region plantumlPreview start=#\%^\ze\_.*\n@startuml# end=#\ze@startuml#
syn match plantumlPreviewBoxParts #[┌┐└┘┬─│┴<>╚═╪╝╔═╤╪╗║╧╟╠╣]# containedin=plantumlPreview contained
syn match plantumlPreviewCtrlFlow #\(LOOP\|ALT\|OPT\)[^│]*│\s*[a-zA-Z0-9?! ]*# containedin=plantumlPreview contains=plantumlPreviewBoxParts contained
syn match plantumlPreviewCtrlFlow #║ \[[^]]*\]#hs=s+3,he=e-1 containedin=plantumlPreview contained
syn match plantumlPreviewEntity #│\w*│#hs=s+1,he=e-1 containedin=plantumlPreview contained
syn match plantumlPreviewTitleUnderline #\^\+# containedin=plantumlPreview contained
syn match plantumlPreviewNoteText #║[^┌┐└┘┬─│┴<>╚═╪╝╔═╤╪╗║╧╟╠╣]*[░ ]║#hs=s+1,he=e-2 containedin=plantumlPreview contained
syn match plantumlPreviewDividerText #╣[^┌┐└┘┬─│┴<>╚═╪╝╔═╤╪╗║╧╟╣]*╠#hs=s+1,he=e-1 containedin=plantumlPreview contained
syn match plantumlPreviewMethodCall #\(\(│\|^\)\s*\)\@<=[a-zA-Z_]*([[:alnum:],_ ]*)# containedin=plantumlPreview contained
syn match plantumlPreviewMethodCallParen #[()]# containedin=plantumlPreviewMethodCall contained

hi def link plantumlPreview Normal
hi def link plantumlPreviewBoxParts normal
hi def link plantumlPreviewCtrlFlow Keyword
hi def link plantumlPreviewLoopName Statement
hi def link plantumlPreviewEntity Statement
hi def link plantumlPreviewTitleUnderline Statement
hi def link plantumlPreviewNoteText Constant
hi def link plantumlPreviewDividerText Constant
hi def link plantumlPreviewMethodCall plantumlText
hi def link plantumlPreviewMethodCallParen plantumlColonLine

" vim: ft=vim
