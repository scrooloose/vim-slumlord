if exists("b:loaded_slumlord")
    finish
endif
let b:loaded_slumlord=1

autocmd bufwritepost *.uml silent call slumlord#updatePreview()
