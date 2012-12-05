
" Project info
let g:project_info['HPHome'] = {
    \   'directory' : [ 'hphome' ],
    \   'open_func' : 'g:Project_Open_HPHome',
    \   'category'  : 'HPHome',
    \   'package'   : '',
    \   'author'    : 'Reha Sterbin <reha@sterbinsoftware.com>',
    \   'copyright' : 'Copyright (c) 2011 Sterbin Software',
    \   'license'   : '',
    \   'link'      : 'http://www.sterbinsoftware.com/',
    \   'version'   : 'DATE',
    \}

" Coding standards
let g:project_info['HPHome']['coding_standards'] = {
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

" Class finder function
fun! g:Project_Open_HPHome()
    let parts = split(@", '_')
    let fileparts = []
    if parts[0] == 'Zend'
        call add(fileparts, 'lib')
        call add(fileparts, 'Zend')
        let fileparts = fileparts + parts[1:]
    elseif parts[0] == 'HPHome'
        call add(fileparts, 'lib')
        call add(fileparts, 'HPHome')
        let fileparts = fileparts + parts[1:]
    elseif parts[0] == 'HPAdmin'
        call add(fileparts, 'sites')
        call add(fileparts, 'admin')
        call add(fileparts, 'application')
        call add(fileparts, 'lib')
        let fileparts = fileparts + parts[1:]
    elseif parts[0] == 'HPFront'
        call add(fileparts, 'sites')
        call add(fileparts, 'frontend')
        call add(fileparts, 'application')
        call add(fileparts, 'lib')
        let fileparts = fileparts + parts[1:]
    else
        call add(fileparts, 'lib')
        let fileparts = fileparts + parts
    endif
    let filepath = join(fileparts, '/') . '.php'
    exe ':e ' . filepath
endfun

