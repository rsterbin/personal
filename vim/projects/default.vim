
" Project info
let g:project_info['default'] = {
    \   'directory' : [],
    \   'init_func' : 'g:Project_Init_Default',
    \   'open_func' : 'g:Project_Open_Default',
    \   'dump_func' : 'g:Project_Dump_Default',
    \   'category'  : 'Default',
    \   'package'   : '',
    \   'author'    : 'Reha Sterbin <reha@sterbinsoftware.com>',
    \   'copyright' : 'Copyright (c) 2011 Sterbin Software',
    \   'license'   : '',
    \   'link'      : 'http://www.sterbinsoftware.com/',
    \   'version'   : 'DATE',
    \}

" Coding standards
let g:project_info['default']['coding_standards'] = {
    \   'underscore_prefix'  : 'n',
    \   'docblocks'          : 'y',
    \   'tabs'               : 'n',
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

