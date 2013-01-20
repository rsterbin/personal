
" Project info
let g:project_info['Taubman']['init_func'] = 'g:Project_Init_Taubman'
let g:project_info['Taubman']['open_func'] = 'g:Project_Open_Taubman'
let g:project_info['Taubman']['dump_func'] = 'g:Project_Dump_Taubman'
let g:project_info['Taubman']['category']  = 'Taubman'
let g:project_info['Taubman']['package']   = ''
let g:project_info['Taubman']['author']    = 'Reha Sterbin <reha@omniti.com>'
let g:project_info['Taubman']['copyright'] = 'Copyright (c) 2010 OmnitTI'
let g:project_info['Taubman']['license']   = ''
let g:project_info['Taubman']['link']      = ''
let g:project_info['Taubman']['version']   = ''

" Coding standards
let g:project_info['Taubman']['coding_standards'] = {
    \   'underscore_prefix'  : 'n',
    \   'docblocks'          : 'y',
    \   'tabs'               : 'n',
    \   'spaces'             : 'y',
    \   'methodauthorline'   : 'n',
    \   'methodsinceline'    : 'n',
    \   'propertysinceline'  : 'n',
    \   'constantsinceline'  : 'n',
    \   'zendloadclass'      : 'n',
    \   'requireclass'       : 'n',
    \   'classbracebelow'    : 'n',
    \   'methodbracebelow'   : 'n',
    \   'filedocblockorder'  : [ 'category', 'package', 'copyright', 'version', 'author' ],
    \   'classdocblockorder' : [ 'category', 'package', 'copyright' ],
    \}

" Enforce spaces and kill trailing whitespace
let b:enforceSpaces = 'y'
let b:enforceNoTrailingWhitespace = { 'html' : 'y', 'asp' : 'y', 'inc' : 'y', 'pm' : 'y' }

" Init function
fun! g:Project_Init_Taubman()
    let ext = expand("%:e")
    if ext == 'inc' || ext == 'html' || ext == 'asp'
        exe ":set ft=aspperl"
    endif
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

