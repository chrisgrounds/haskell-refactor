let g:equals = "\<space>=\<space>"

function! FindNextEmptyLine()
    return "/^$\<cr>"
endfunction

function! FindPreviousEmptyLine()
    return "/^$\<cr>N"
endfunction

function! CreateType(name)
    return "data\<space>" . a:name . g:equals
endfunction

function! ExtractHaskellType(...)
    let newTypeName = exists('a:1') ? a:1 : "MyType"

    let cmd = "normal! gvdmm" 
    let cmd .= FindPreviousEmptyLine() 
    let cmd .= "o" 
    let cmd .= CreateType(newTypeName) 
    let cmd .= "\<esc>po\<esc>`mi\<space>" 
    let cmd .= newTypeName 
    let cmd .= "\<esc>:noh"

    execute cmd
endfunction

function! CreateTypeSignature(name, numArgs)
    let typeSig = "\<space>::"
    let i = 1
    while i <= a:numArgs
        let typeSig .= "\<space>_\<space>->"
        let i += 1
    endwhile
    let typeSig .= "\<space>_"
    return a:name . typeSig
endfunction

function! CreateFunction(name, params)
    if a:params != ""
        return a:name . " " . a:params . g:equals
    endif
    return a:name . g:equals
endfunction

function! ExtractHaskellFunction(...)
    let args       = a:0 > 0 ? split(a:000[0], " ") : []
    let numArgs    = len(args)
    let fName      = numArgs > 0 ? args[0] : "f"
    let numFParams = numArgs - 1
    let fParams    = args != [] ? join(args[1:], " ") : ""

    let cmd = "normal! gvdmm" 
    let cmd .= FindNextEmptyLine() 
    let cmd .= "o" 
    let cmd .= CreateTypeSignature(fName, numFParams) 
    let cmd .= "\<esc>o" 
    let cmd .= CreateFunction(fName, fParams) 
    let cmd .= "\<esc>po\<esc>`mi" 
    let cmd .= fName . (fParams != "" ? " " . fParams : "") 
    let cmd .= "\<esc>:noh"

    execute cmd
endfunction

command! -range -nargs=? ExtractHaskellType     call ExtractHaskellType(<f-args>)
command! -range -nargs=? ExtractHaskellFunction call ExtractHaskellFunction(<f-args>)

