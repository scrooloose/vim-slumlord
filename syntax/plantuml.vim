syn region plantumlPreview start=#\%^\ze\_.*\n@startuml# end=#\ze@startuml#
syn match plantumlPreviewBoxParts #[┌┐└┘┬─│┴<>╚═╪╝╔═╤╪╗║╧╟╠╣]# containedin=plantumlPreview contained
syn match plantumlPreviewCtrlFlow #\(LOOP\|ALT\)[^│]*│\s*[a-zA-Z0-9?! ]*# containedin=plantumlPreview contains=plantumlPreviewBoxParts contained
syn match plantumlPreviewCtrlFlow #║ \[\w*\]#hs=s+3,he=e-1 containedin=plantumlPreview contained
syn match plantumlPreviewEntity #│\w*│#hs=s+1,he=e-1 containedin=plantumlPreview contained
syn match plantumlPreviewTitleUnderline #\^\+# containedin=plantumlPreview contained

hi def link plantumlPreview Normal
hi def link plantumlPreviewBoxParts normal
hi def link plantumlPreviewCtrlFlow Keyword
hi def link plantumlPreviewLoopName Statement
hi def link plantumlPreviewEntity Statement
hi def link plantumlPreviewTitleUnderline Statement

" vim: ft=vim
