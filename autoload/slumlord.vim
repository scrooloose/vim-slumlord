if exists("g:slumlord_plantuml_jar_path")
    let s:jar_path = g:slumlord_plantuml_jar_path
else
    let s:jar_path = expand("<sfile>:p:h") . "/../plantuml.jar"
endif

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
    let fname = s:createDiagram()

    call append(0, "")
    call append(0, "")
    0

    call s:readWithoutStoringAsAltFile(fname)

    "fix trailing whitespace
    exec '1,' . s:dividerLnum() . 's/\s\+$//e'

    call s:removeLeadingWhitespace()
endfunction

function! s:readWithoutStoringAsAltFile(fname) abort
    let oldcpoptions = &cpoptions
    set cpoptions-=a
    exec "read " . a:fname
    let &cpoptions = oldcpoptions
endfunction

function! s:createDiagram() abort
    let fname = tempname()
    execute "write " . fname
    call s:convertNonAsciiSupportedSyntax(fname)
    call system("java -jar ". s:jar_path ." -tutxt " . fname)

    return fname . ".utxt"
endfunction

function! s:convertNonAsciiSupportedSyntax(fname) abort
    exec 'edit ' . a:fname
    /@startuml/,/@enduml/s/^\s*\(boundary\|database\|entity\|control\)/participant/e
    /@startuml/,/@enduml/s/^\s*\(end \)\?\zsref\>/note/e
    /@startuml/,/@enduml/s/^\s*ref\>/note/e
    /@startuml/,/@enduml/s/|||/||4||/e
    /@startuml/,/@enduml/s/\.\.\.\([^.]*\)\.\.\./==\1==/e
    write
    bwipe!
endfunction

function! s:removeLeadingWhitespace() abort
    let smallestLead = 100

    for i in range(1, s:dividerLnum()-1)
        let lead = match(getline(i), '\S')
        if lead >= 0 && lead < smallestLead
            let smallestLead = lead
        endif
    endfor

    exec '1,' . s:dividerLnum() . 's/^ \{'.smallestLead.'}//e'
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
