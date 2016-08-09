syntax region plantumlPreview start=#\%^\ze\_.*\n@startuml# end=#\ze@startuml#
highlight link plantumlPreview Normal

syn match plantumlPreviewBoxParts #[┌┐└┘┬─│┴<>╚═╪╝╔═╤╪╗║╧╟╠╣]# containedin=plantumlPreview
syn match plantumlPreviewCtrlFlow #\(LOOP\|ALT\)# containedin=plantumlPreview
syn match plantumlPreviewCtrlFlow #║ \[\w*\]#hs=s+3,he=e-1 containedin=plantumlPreview
syn match plantumlPreviewEntity #│\w*│#hs=s+1,he=e-1 containedin=plantumlPreview

hi def link plantumlPreviewBoxParts normal
hi def link plantumlPreviewCtrlFlow Keyword
hi def link plantumlPreviewEntity Statement
