let s:jar_path = expand("<sfile>:p:h") . "/../plantuml.jar"
let s:divider = "@startuml"

function! slumlord#updatePreview() abort
    if !s:dividerLnum()
        return
    end

    let startLine = line(".")
    let lastLine = line("$")
    let startCol = col(".")

    call s:deletePreviousDiagram()
    call s:insertDiagram()
    call s:addTitle()

    call cursor(line("$") - (lastLine - startLine), startCol)

    noautocmd write
endfunction

function! s:dividerLnum() abort
    return search(s:divider, 'n')
endfunction

function! s:deletePreviousDiagram() abort
    if s:dividerLnum() > 1
        exec '0,' . (s:dividerLnum() - 1) . 'delete'
    endif
endfunction

function! s:insertDiagram() abort
    let cmd = system("java -jar ". s:jar_path ." -tutxt " . expand("%"))
    call system(cmd)

    call append(0, "")
    call append(0, "")
    0
    exec "read " . expand("%:p:r") . ".utxt"

    "fix trailing whitespace
    exec '1,' . s:dividerLnum() . 's/\s\+$//'

    "remove leading whitespace
    exec '1,' . s:dividerLnum() . 's/^ \{7}//'
endfunction

function! s:addTitle() abort
    let lnum = search('^title ', 'n')
    if !lnum
        return
    endif

    let title = substitute(getline(lnum), '^title \(.*\)', '\1', '')

    call append(0, "")
    call append(0, repeat("^", len(title)+6))
    call append(0, " " . title)
endfunction
