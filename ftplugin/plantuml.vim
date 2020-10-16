" PlantUML Live Preview for ascii/unicode art
" @Author: Martin Grenfell <martin.grenfell@gmail.com>
" @Date: 2018-12-07 13:00:22
" @Last Modified by: Tsuyoshi CHO <Tsuyoshi.CHO@Gmail.com>
" @Last Modified time: 2018-12-08 00:02:43
" @License: WTFPL
" PlantUML Filetype preview kick

" Intro  {{{1
if exists("b:loaded_slumlord")
    finish
endif
let b:loaded_slumlord=1

let s:save_cpo = &cpo
set cpo&vim

" Mappings {{{1
" TODO: allow chaning the mapping through an option
nmap <buffer> <leader>ex :ExportImage<CR>

" setting {{{1
setlocal nowrap

" autocmd {{{1
augroup slumlord
    autocmd!
    autocmd BufWritePre * if &ft =~ 'plantuml' | silent call slumlord#updatePreview({'write': 1}) | endif
augroup END

" command {{{1
command! -buffer -bar -nargs=0 ExportImage call slumlord#exportImage({})

" Outro {{{1
let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set fdm=marker:
