
" Project info
let g:project_info['default'] = {}
let g:project_info['default']['init_func'] = 'g:Project_Init_Default'
let g:project_info['default']['open_func'] = 'g:Project_Open_Default'
let g:project_info['default']['dump_func'] = 'g:Project_Dump_Default'
let g:project_info['default']['category']  = 'Default'
let g:project_info['default']['package']   = ''
let g:project_info['default']['author']    = 'Reha Sterbin <reha@sterbinsoftware.com>'
let g:project_info['default']['copyright'] = 'Copyright (c) 2011 Sterbin Software'
let g:project_info['default']['license']   = ''
let g:project_info['default']['link']      = 'http://www.sterbinsoftware.com/'
let g:project_info['default']['version']   = 'DATE'

" Coding standards
let g:project_info['default']['coding_standards'] = {
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
    \   'classbracebelow'    : 'y',
    \   'methodbracebelow'   : 'y',
    \   'parenspacing'       : 'n',
    \   'doxygenworkaround'  : 'n',
    \   'filedocblockorder'  : [ 'category', 'package', 'copyright', 'version', 'author', 'link', 'since' ],
    \   'classdocblockorder' : [ 'category', 'package', 'since' ],
    \}

" Init function
fun! g:Project_Init_Default()
endfun

" Class finder function
fun! g:Project_Open_Default()
    let filepath = substitute(@", '::', '/', 'g') . '.php'
    exe ':e ' . filepath
endfun

" Dump function
fun! g:Project_Dump_Default()
    let blank = "print '<pre style=\"color: red;\">' . \"\\n\"; var_dump(); print '</pre>' . \"\\n\";"
    let pos = line('.')
    call append(pos, blank)
    exe "normal j$9b"
endfun

