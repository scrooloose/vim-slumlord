if exists("b:loaded_slumlord")
    finish
endif
let b:loaded_slumlord=1

if !exists("g:slumlord_au_created")
    autocmd bufwritepost *.uml silent call slumlord#updatePreview()
    let g:slumlord_au_created = 1
endif
