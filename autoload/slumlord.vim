let s:jar_path = expand("<sfile>:p:h") . "/../plantuml.jar"

function! slumlord#updatePreview() abort
    let startLine = line(".")
    let lastLine = line("$")
    let startCol = col(".")

    let divider = "----8<----"

    if !search(divider, 'n')
        0put!=''
        exec "0put!='".divider."'"
    else
        let l = search(divider, 'n')
        if l > 1
            exec '0,' . (l - 1) . 'delete'
        endif
    endif


    let cmd = system("java -jar ". s:jar_path ." -tutxt " . expand("%"))
    call system(cmd)

    0put!=''
    0put!=''
    0
    exec "read " . expand("%:t:r") . ".utxt"

    call cursor(line("$") - (lastLine - startLine), startCol)
endfunction
