
" Project info
let g:project_info['Taskman']['init_func'] = 'g:Project_Init_Taskman'
let g:project_info['Taskman']['open_func'] = 'g:Project_Open_Taskman'
let g:project_info['Taskman']['dump_func'] = 'g:Project_Dump_Taskman'

" Init function
fun! g:Project_Init_Taskman()
    " Set the file type to aspperl for known extensions
    let ext = expand("%:e")
    if ext == 'inc' || ext == 'html' || ext == 'asp'
        exe ":set ft=aspperl"
    endif
    " Prep vim for spaces, enforce them, and kill trailing whitespace
    call g:ToggleTabsVsSpaces('spaces')
    let b:enforceSpaces = 'y'
    let b:enforceNoTrailingWhitespace = { 'html' : 'y', 'asp' : 'y', 'inc' : 'y', 'pm' : 'y' }
endfun

" Class finder function
fun! g:Project_Open_Taskman()
    let filepath = 'lib/' . substitute(@", '::', '/', 'g') . '.pm'
    exe ':e ' . filepath
endfun

" Dump function
fun! g:Project_Dump_Taskman()
    let blank = "print '<pre style=\"color: red;\">' . \"\\n\"; print Dumper ; print '</pre>' . \"\\n\";"
    let pos = line('.')
    call append(pos, blank)
    exe "normal j$9bh"
endfun

