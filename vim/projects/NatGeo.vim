
" Project info
let g:project_info['NatGeo']['init_func'] = 'g:Project_Init_NatGeo'
let g:project_info['NatGeo']['enter_func'] = 'g:Project_Enter_NatGeo'
let g:project_info['NatGeo']['exit_func'] = 'g:Project_Exit_NatGeo'
let g:project_info['NatGeo']['open_func'] = 'g:Project_Open_NatGeo'
let g:project_info['NatGeo']['dump_func'] = 'g:Project_Dump_NatGeo'

" Init function
fun! g:Project_Init_NatGeo()
    " Prep vim for spaces, enforce them, and kill trailing whitespace
    call g:ToggleTabsVsSpaces('spaces')
    let b:enforceSpaces = 'y'
    let b:enforceNoTrailingWhitespace = { 'html' : 'y', 'asp' : 'y', 'inc' : 'y', 'pm' : 'y' }
endfun

" Enter buffer function
fun! g:Project_Enter_NatGeo()
    " Use spaces
    call g:ToggleTabsVsSpaces('spaces')
    " Add a pod/cut doc block
    noremap <leader>adb 0wveyO=pod <ESC>pa()<ESC>o<CR><CR><CR>=cut<ESC>kka
endfun

" Exit buffer function
fun! g:Project_Exit_NatGeo()
    " Go back to the default
    noremap <leader>adb :call AddDocBlock()<CR>
endfun

" Class finder function
fun! g:Project_Open_NatGeo()
    let filepath = 'lib/' . substitute(@", '::', '/', 'g') . '.pm'
    exe ':e ' . filepath
endfun

" Dump function
fun! g:Project_Dump_NatGeo()
    let blank = "print '<pre style=\"color: red;\">' . \"\\n\"; print Dumper ; print '</pre>' . \"\\n\";"
    let pos = line('.')
    call append(pos, blank)
    exe "normal j$9bh"
endfun

