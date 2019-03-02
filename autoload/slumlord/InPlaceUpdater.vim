" PlantUML Live Preview for ascii/unicode art
" @Author: Martin Grenfell <martin.grenfell@gmail.com>
" @Date: 2018-12-07 13:00:22
" @Last Modified by: Tsuyoshi CHO <Tsuyoshi.CHO@Gmail.com>
" @Last Modified time: 2018-12-08 00:11:32
" @License: WTFPL
" PlantUML preview plugin InPlace Updater

" Intro  {{{1
scriptencoding utf-8

" InPlaceUpdater object {{{1
let s:InPlaceUpdater = {}
let s:InPlaceUpdater.divider = "@startuml"

function! slumlord#InPlaceUpdater#getInstance() abort
  return deepcopy(s:InPlaceUpdater)
endfunction

function! s:InPlaceUpdater.update(args) abort dict
    let startLine = line(".")
    let lastLine = line("$")
    let startCol = col(".")

    call self.__deletePreviousDiagram()
    call self.__insertDiagram(b:slumlord_preview_fname)
    call slumlord#util#addTitle()

    call cursor(line("$") - (lastLine - startLine), startCol)

    if a:args['write']
        noautocmd write
    endif
endfunction

function! s:InPlaceUpdater.__deletePreviousDiagram() abort dict
    if self.__dividerLnum() > 1
        exec '0,' . (self.__dividerLnum() - 1) . 'delete _'
    endif
endfunction

function! s:InPlaceUpdater.__insertDiagram(fname) abor dictt
    call append(0, "")
    call append(0, "")
    0

    call slumlord#util#readWithoutStoringAsAltFile(a:fname)

    "fix trailing whitespace
    exec '1,' . self.__dividerLnum() . 's/\s\+$//e'

    call slumlord#util#removeLeadingWhitespace()
endfunction

function! s:InPlaceUpdater.__dividerLnum() abor dictt
    return search(self.divider, 'wn')
endfunction

" vim:set fdm=marker:
