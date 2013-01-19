
" Project info
let g:project_info['HPHome']['open_func'] = 'g:Project_Open_HPHome'
let g:project_info['HPHome']['category']  = 'HPHome'
let g:project_info['HPHome']['package']   = ''
let g:project_info['HPHome']['author']    = 'Reha Sterbin <reha@sterbinsoftware.com>'
let g:project_info['HPHome']['copyright'] = 'Copyright (c) 2011 Sterbin Software'
let g:project_info['HPHome']['license']   = ''
let g:project_info['HPHome']['link']      = 'http://www.sterbinsoftware.com/'
let g:project_info['HPHome']['version']   = 'DATE'

" Coding standards
let g:project_info['HPHome']['coding_standards'] = {
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

