let s:jar_path = expand("<sfile>:p:h") . "/../plantuml.jar"
let s:divider = "@startuml"

function! slumlord#updatePreview() abort
    if !search(s:divider, 'n')
        return
    end

    let startLine = line(".")
    let lastLine = line("$")
    let startCol = col(".")

    let l = search(s:divider, 'n')
    if l > 1
        exec '0,' . (l - 1) . 'delete'
    endif

    let cmd = system("java -jar ". s:jar_path ." -tutxt " . expand("%"))
    call system(cmd)

    0put!=''
    0put!=''
    0
    exec "read " . expand("%:p:r") . ".utxt"

    call s:addTitle()

    "fix trailing whitespace
    exec '1,' . l . 's/\s\+$//'

    call cursor(line("$") - (lastLine - startLine), startCol)

    noautocmd write
endfunction

function! s:addTitle() abort
    let lnum = search('^title ', 'n')
    if !lnum
        return
    endif

    let title = substitute(getline(lnum), '^title \(.*\)', '\1', '')

    call append(0, "")
    call append(0, "     " . repeat("^", len(title)+6))
    call append(0, "        " . title)
endfunction
