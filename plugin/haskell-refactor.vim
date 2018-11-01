let g:equals = "\<space>=\<space>"

function! FindNextEmptyLine()
    return "/^$\<cr>"
endfunction

function! FindPreviousEmptyLine()
    return "/^$\<cr>N"
endfunction

function! CreateType(name)
    return "type\<space>" . a:name . g:equals
endfunction

function! GetInput(msg)
    call inputsave()
    let i = input(a:msg)
    call inputrestore()
    return i
endfunction

function! ExtractHaskellType(...)
    let requiresPrompt = a:0 < 1

    let name = requiresPrompt ? GetInput('Name type: ') : a:1

    let cmd = "normal! gvdmm" 
    let cmd .= FindPreviousEmptyLine() 
    let cmd .= "o" 
    let cmd .= CreateType(name)
    let cmd .= "\<esc>po\<esc>`mi" 
    let cmd .= name 
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
    return a:name . (a:params != "" ? " " . a:params : "") . g:equals
endfunction

function! ExtractHaskellFunction(...)
    let requiresPrompt = a:0 < 1

    if requiresPrompt
        let fName        = GetInput('Rename function to: ')
        let providedArgs = GetInput('Give arguments (seperated by space):  ')

        let args       = split(providedArgs, " ")
        let numArgs    = len(args)
        let numFParams = numArgs
        let fParams    = args != [] ? join(args, " ") : ""
    else
        let args       = a:0 > 0 ? split(a:000[0], " ") : []
        let numArgs    = len(args)
        let fName      = numArgs > 0 ? args[0] : "f"
        let numFParams = numArgs - 1
        let fParams    = args != [] ? join(args[1:], " ") : ""
    endif

    let cmd = "normal! gvdmm" 
    let cmd .= FindNextEmptyLine() 
    let cmd .= "o" 
    let cmd .= CreateTypeSignature(fName, numFParams) 
    let cmd .= "\<esc>o" 
    let cmd .= CreateFunction(fName, fParams) 
    let cmd .= "\<esc>p\<esc>`mi"
    let cmd .= fName . (fParams != "" ? " " . fParams : "") 
    let cmd .= "\<esc>:noh"

    execute cmd
endfunction

command! -range -nargs=? ExtractHaskellType     call ExtractHaskellType(<f-args>)
command! -range -nargs=? ExtractHaskellFunction call ExtractHaskellFunction(<f-args>)

