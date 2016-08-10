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
    call system("java -jar ". s:jar_path ." -tutxt " . expand("%"))

    call append(0, "")
    call append(0, "")
    0
    exec "read " . expand("%:p:r") . ".utxt"

    "fix trailing whitespace
    exec '1,' . s:dividerLnum() . 's/\s\+$//'

    call s:removeLeadingWhitespace()
endfunction

function! s:removeLeadingWhitespace() abort
    let smallestLead = 100

    for i in range(1, s:dividerLnum())
        let lead = match(getline(i), '\S')
        if lead >= 0 && lead < smallestLead
            let smallestLead = lead
        endif
    endfor

    exec '1,' . s:dividerLnum() . 's/^ \{'.smallestLead.'}//'
endfunction

function! s:addTitle() abort
    let lnum = search('^title ', 'n')
    if !lnum
        return
    endif

    let title = substitute(getline(lnum), '^title \(.*\)', '\1', '')

    call append(0, "")
    call append(0, repeat("^", len(title)+6))
    call append(0, "   " . title)
endfunction
