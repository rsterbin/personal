
" Project info
let g:project_info['Taubman']['init_func'] = 'g:Project_Init_Taubman'
let g:project_info['Taubman']['enter_func'] = 'g:Project_Enter_Taubman'
let g:project_info['Taubman']['open_func'] = 'g:Project_Open_Taubman'
let g:project_info['Taubman']['dump_func'] = 'g:Project_Dump_Taubman'

" Init function
fun! g:Project_Init_Taubman()

    " Set the file type to aspperl
    let ext = expand("%:e")
    if ext == 'inc' || ext == 'html' || ext == 'asp'
        exe ":set ft=aspperl"
    endif

    " Prep vim for spaces, enforce them, and kill trailing whitespace
    call g:ToggleTabsVsSpaces('spaces')
    let b:enforceSpaces = 'y'
    let b:enforceNoTrailingWhitespace = { 'html' : 'y', 'asp' : 'y', 'inc' : 'y', 'pm' : 'y' }

endfun

" Enter buffer function
fun! g:Project_Enter_Taubman()
    call g:ToggleTabsVsSpaces('spaces')
endfun

" Class finder function
fun! g:Project_Open_Taubman()
    let filepath = 'lib/' . substitute(@", '::', '/', 'g') . '.pm'
    exe ':e ' . filepath
endfun

" Dump function
fun! g:Project_Dump_Taubman()
    let blank = "print '<pre style=\"color: red;\">' . \"\\n\"; print Dumper ; print '</pre>' . \"\\n\";"
    let pos = line('.')
    call append(pos, blank)
    exe "normal j$9bh"
endfun

