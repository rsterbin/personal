
" Project info
let g:project_info['Corpweb']['init_func'] = 'g:Project_Init_Corpweb'
let g:project_info['Corpweb']['dump_func'] = 'g:Project_Dump_Corpweb'

" Init function
fun! g:Project_Init_Corpweb()
    " Prep vim for spaces, enforce them, and kill trailing whitespace
    call g:ToggleTabsVsSpaces('spaces')
    let b:enforceSpaces = 'y'
    let b:enforceNoTrailingWhitespace = { 'js' : 'y', 'json' : 'y', 'ejs' : 'y', 'css' : 'y', 'html' : 'y', 'md' : 'y' }
    " Set folding
    exe ":set foldmethod=indent"
    exe ":set foldnestmax=2"
endfun

" Dump function
fun! g:Project_Dump_Corpweb()
    let blank = "console.log()"
    let pos = line('.')
    call append(pos, blank)
    exe "normal j$"
endfun

