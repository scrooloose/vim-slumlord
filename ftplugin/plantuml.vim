if exists("b:loaded_slumlord")
    finish
endif
let b:loaded_slumlord=1

setlocal nowrap

augroup slumlord
    au!
    autocmd bufwritepre *.{uml,pu,plantuml,puml} silent call slumlord#updatePreview({'write': 1})
augroup END
