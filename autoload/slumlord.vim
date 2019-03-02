" PlantUML Live Preview for ascii/unicode art
" @Author: Martin Grenfell <martin.grenfell@gmail.com>
" @Date: 2018-12-07 13:00:22
" @Last Modified by: Tsuyoshi CHO <Tsuyoshi.CHO@Gmail.com>
" @Last Modified time: 2018-12-08 13:15:46
" @License: WTFPL
" PlantUML preview plugin core

" Intro  {{{1
scriptencoding utf-8

if exists("g:autoloaded_slumlord")
  finish
endif
let g:autoloaded_slumlord = 1

let s:save_cpo = &cpo
set cpo&vim

" variable {{{1
let g:slumlord_plantuml_jar_path = get(g:, 'slumlord_plantuml_jar_path', expand("<sfile>:p:h") . "/../plantuml.jar")
let g:slumlord_asciiart_utf = get(g:, 'slumlord_asciiart_utf', 1)

" function {{{1
function! slumlord#updatePreview(args) abort
    if !slumlord#util#shouldInsertPreview()
        return
    end

    let charset = 'UTF-8'

    let type = 'utxt'
    let ext  = 'utxt'
    if !g:slumlord_asciiart_utf
      let type = 'txt'
      let ext  = 'atxt'
    endif

    let tmpfname = tempname()
    call slumlord#util#mungeDiagramInTmpFile(tmpfname)
    let b:slumlord_preview_fname = fnamemodify(tmpfname,  ':r') . '.' . ext

    let cmd = "java -Dapple.awt.UIElement=true -splash: -jar ". g:slumlord_plantuml_jar_path ." -charset ". charset ." -t" . type ." ". tmpfname

    let write = has_key(a:args, 'write') && a:args["write"] == 1
    if exists("*jobstart")
        call jobstart(cmd, { "on_exit": function("s:asyncHandlerAdapter"), "write": write, "bufnr": bufnr("") })
    elseif exists("*job_start")
        call job_start(cmd, { "exit_cb": {job,st->call('s:asyncHandlerAdapter',[job,st,0],{"bufnr": bufnr(""),"write": write})}, "out_io": "buffer", "out_buf": bufnr("") })
    else
        call system(cmd)
        if v:shell_error == 0
            call s:updater.update(a:args)
        endif
    endif
endfunction

function! s:asyncHandlerAdapter(job_id, data, event) abort dict
    if a:data != 0
        return 0
    endif

    if bufnr("") != self.bufnr
        return 0
    endif

    call s:updater.update(self)
endfunction

" other shit {{{1
if exists("g:slumlord_separate_win") && g:slumlord_separate_win
    let s:updater = slumlord#WinUpdater#getInstance()
else
    let s:updater = slumlord#InPlaceUpdater#getInstance()
endif

" Outro {{{1
let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set fdm=marker:
