
" Project info
let g:project_info['HPHome']['init_func'] = 'g:Project_Init_HPHome'
let g:project_info['HPHome']['enter_func'] = 'g:Project_Enter_HPHome'
let g:project_info['HPHome']['open_func'] = 'g:Project_Open_HPHome'

" Init function (buffer setup)
fun! g:Project_Init_HPHome()

    " Configuration for the php template plugin
    let b:php_template_config = {
        \   'category'         : 'HPHome',
        \   'package'          : '',
        \   'author'           : 'Reha Sterbin <reha@sterbinsoftware.com>',
        \   'copyright'        : 'Copyright (c) 2011 Sterbin Software',
        \   'license'          : '',
        \   'link'             : 'http://www.sterbinsoftware.com/',
        \   'version'          : 'DATE',
        \   'coding_standards' : {
        \       'underscore_prefix'  : 'n',
        \       'docblocks'          : 'y',
        \       'tabs'               : 'n',
        \       'spaces'             : 'y',
        \       'methodauthorline'   : 'n',
        \       'methodsinceline'    : 'n',
        \       'propertysinceline'  : 'n',
        \       'constantsinceline'  : 'n',
        \       'zendloadclass'      : 'n',
        \       'requireclass'       : 'n',
        \       'classbracebelow'    : 'y',
        \       'methodbracebelow'   : 'y',
        \       'parenspacing'       : 'n',
        \       'doxygenworkaround'  : 'n',
        \       'filedocblockorder'  : [ 'category', 'package', 'copyright', 'version', 'author', 'link', 'since' ],
        \       'classdocblockorder' : [ 'category', 'package', 'since' ],
        \}
    \}

    " Prep vim for spaces, enforce them, and kill trailing whitespace
    call g:ToggleTabsVsSpaces('spaces')
    let b:enforceSpaces = 'y'
    let b:enforceNoTrailingWhitespace = { 'php' : 'y', 'phtml' : 'y', 'js' : 'y', 'css' : 'y' }

endfun

" Enter buffer function
fun! g:Project_Enter_HPHome()
    call g:ToggleTabsVsSpaces('spaces')
endfun

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

