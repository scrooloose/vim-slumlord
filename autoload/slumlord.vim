let s:jar_path = expand("<sfile>:p:h") . "/../plantuml.jar"
let s:divider = "@startuml"

function! slumlord#updatePreview() abort
    let startLine = line(".")
    let lastLine = line("$")
    let startCol = col(".")

    if !search(s:divider, 'n')
        0put!=''
        exec "0put!='".s:divider."'"
    else
        let l = search(s:divider, 'n')
        if l > 1
            exec '0,' . (l - 1) . 'delete'
        endif
    endif

    let cmd = system("java -jar ". s:jar_path ." -tutxt " . expand("%"))
    call system(cmd)

    0put!=''
    0put!=''
    0
    exec "read " . expand("%:p:r") . ".utxt"

    call cursor(line("$") - (lastLine - startLine), startCol)

    noautocmd write
endfunction
