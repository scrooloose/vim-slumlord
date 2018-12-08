" PlantUML Live Preview for ascii/unicode art
" @Author: Martin Grenfell <martin.grenfell@gmail.com>
" @Date: 2018-12-07 13:00:22
" @Last Modified by: Tsuyoshi CHO <Tsuyoshi.CHO@Gmail.com>
" @Last Modified time: 2018-12-08 00:11:42
" @License: WTFPL
" PlantUML preview plugin Window Updater

" Intro  {{{1
scriptencoding utf-8

" WinUpdater object {{{1
let s:WinUpdater = {}

function! slumlord#WinUpdater#getInstance() abort
  return deepcopy(s:WinUpdater)
endfunction

function! s:WinUpdater.update(args) abort dict
    let fname = b:slumlord_preview_fname
    call self.__moveToWin()
    %d

    call append(0, "")
    call append(0, "")
    0

    call slumlord#util#readWithoutStoringAsAltFile(fname)

    "fix trailing whitespace
    %s/\s\+$//e

    call slumlord#util#removeLeadingWhitespace()
    call slumlord#util#addTitle()
    wincmd p
endfunction

function s:WinUpdater.__moveToWin() abort dict
    if exists("b:slumlord_bnum")
        if bufwinnr(b:slumlord_bnum) != -1
            exec bufwinnr(b:slumlord_bnum) . "wincmd w"
        else
            exec b:slumlord_bnum . "sb"
        endif
    else
        let prev_bnum = bufnr("")
        new
        call setbufvar(prev_bnum, "slumlord_bnum", bufnr(""))
        call self.__setupWinOpts()
    endif
endfunction

function s:WinUpdater.__setupWinOpts() abort dict
    setl nowrap
    setl buftype=nofile
    syn match plantumlPreviewBoxParts #[┌┐└┘┬─│┴<>╚═╪╝╔═╤╪╗║╧╟╠╣]#
    syn match plantumlPreviewCtrlFlow #\(LOOP\|ALT\|OPT\)[^│]*│\s*[a-zA-Z0-9?! ]*#
    syn match plantumlPreviewCtrlFlow #║ \[[^]]*\]#hs=s+3,he=e-1
    syn match plantumlPreviewEntity #│\w*│#hs=s+1,he=e-1
    syn match plantumlPreviewTitleUnderline #\^\+#
    syn match plantumlPreviewNoteText #║[^┌┐└┘┬─│┴<>╚═╪╝╔═╤╪╗║╧╟╠╣]*[░ ]║#hs=s+1,he=e-2
    syn match plantumlPreviewDividerText #╣[^┌┐└┘┬─│┴<>╚═╪╝╔═╤╪╗║╧╟╣]*╠#hs=s+1,he=e-1
    syn match plantumlPreviewMethodCall #\(\(│\|^\)\s*\)\@<=[a-zA-Z_]*([[:alnum:],_ ]*)# 
    syn match plantumlPreviewMethodCallParen #[()]# containedin=plantumlPreviewMethodCall contained

    hi def link plantumlPreviewBoxParts normal
    hi def link plantumlPreviewCtrlFlow Keyword
    hi def link plantumlPreviewLoopName Statement
    hi def link plantumlPreviewEntity Statement
    hi def link plantumlPreviewTitleUnderline Statement
    hi def link plantumlPreviewNoteText Constant
    hi def link plantumlPreviewDividerText Constant
    hi def link plantumlPreviewMethodCall plantumlText
    hi def link plantumlPreviewMethodCallParen plantumlColonLine
endfunction

" vim:set fdm=marker:
