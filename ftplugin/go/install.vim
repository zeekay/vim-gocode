if exists("b:did_ftplugin_go_install")
    finish
endif

if !exists('g:go_install_commands')
    let g:go_install_commands = 1
endif

if g:go_install_commands
    command! -buffer -nargs=* -complete=dir GoBuild call s:GoBuild(<f-args>)
    command! -buffer -nargs=* -complete=dir GoInstall call s:GoInstall(<f-args>)
    command! -buffer -nargs=* -complete=dir GoRun call s:GoRun(<f-args>)
    command! -buffer -nargs=* -complete=dir GoTest call s:GoTest(<f-args>)
    command! -buffer -nargs=* -complete=dir GoTestVerbose call s:GoTestVerbose(<f-args>)
endif

function! s:GoBuild(...)
    if a:0 == 1
        let relpkg=a:1
        let file=getcwd()
    else
        let relpkg=expand('%')
        let file=''
    endif

    let pkg=GoRelPkg(file, relpkg)
    if pkg != -1
        let output=system('go build '.pkg)
        echo output
    else
        echohl Error | echo 'You are not in a go package' | echohl None
    endif
endfunction

function! s:GoInstall(...)
    if a:0 == 1
        let relpkg=a:1
        let file=getcwd()
    else
        let relpkg=expand('%')
        let file=''
    endif

    let pkg=GoRelPkg(file, relpkg)
    if pkg != -1
        let output=system('go install '.pkg)
        if !v:shell_error
            echo 'Package '.pkg.' installed'
        else
            echo output
        endif
    else
        echohl Error | echo 'You are not in a go package' | echohl None
    endif
endfunction

function! s:GoRun(...)
    if a:0 == 1
        let relpkg=a:1
        let file=getcwd()
    else
        let relpkg=expand('%')
        let file=''
    endif

    let pkg=GoRelPkg(file, relpkg)
    if pkg != -1
        let output=system('go run '.relpkg)
        echo output
    else
        echohl Error | echo 'You are not in a go package' | echohl None
    endif
endfunction

function! s:GoTest(...)
    if a:0 == 1
        let relpkg=a:1
        let file=getcwd()
    else
        let relpkg=expand('%')
        let file=''
    endif

    let pkg=GoRelPkg(file, relpkg)
    if pkg != -1
        echo system('go test '.pkg)
    else
        echohl Error | echo 'You are not in a go package' | echohl None
    endif
endfunction

function! s:GoTestVerbose(...)
    if a:0 == 1
        let relpkg=a:1
        let file=getcwd()
    else
        let relpkg=expand('%')
        let file=''
    endif

    let pkg=GoRelPkg(file, relpkg)
    if pkg != -1
        echo system('go test -v '.pkg)
    else
        echohl Error | echo 'You are not in a go package' | echohl None
    endif
endfunction

let b:did_ftplugin_go_install=1

" vim:sw=4:et
