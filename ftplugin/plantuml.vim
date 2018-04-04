if exists("b:loaded_slumlord")
    finish
endif
let b:loaded_slumlord=1

setlocal nowrap

augroup slumlord
    au!
    autocmd BufWritePre * if &ft =~ 'plantuml' | silent call slumlord#updatePreview({'write': 1}) | endif
augroup END
