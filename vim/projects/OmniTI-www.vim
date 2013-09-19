
" Project info
let g:project_info['OmniTI-www']['init_func'] = 'g:Project_Init_OmniTIwww'
let g:project_info['OmniTI-www']['open_func'] = 'g:Project_Open_OmniTIwww'

" Init function (buffer setup)
fun! g:Project_Init_OmniTIwww()

    " Configuration for the php template plugin
    let b:php_template_config = {
        \   'category'         : 'OmniTI-www',
        \   'package'          : '',
        \   'author'           : 'Reha Sterbin <reha@omniti.com>',
        \   'copyright'        : 'Copyright (c) 2010 OmnitTI',
        \   'license'          : '',
        \   'link'             : '',
        \   'version'          : '',
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
        \       'filedocblockorder'  : [ 'category', 'package', 'copyright', 'version', 'author' ],
        \       'classdocblockorder' : [ 'category', 'package', 'copyright' ],
        \}
    \}

    " Prep vim for spaces, enforce them, and kill trailing whitespace
    call g:ToggleTabsVsSpaces('spaces')
    let b:enforceSpaces = 'y'
    let b:enforceNoTrailingWhitespace = { 'php' : 'y', 'phtml' : 'y', 'js' : 'y', 'css' : 'y' }

endfun

" Class finder function
fun! g:Project_Open_OmniTIwww()
    let parts = split(@", '_')
    let fileparts = []
    if parts[0] == 'Zend'
        call add(fileparts, 'lib')
        call add(fileparts, 'external')
        call add(fileparts, 'Zend')
        let fileparts = fileparts + parts[1:]
        let filepath = join(fileparts, '/') . '.php'
    elseif parts[0] == 'OmniWeb'
        call add(fileparts, 'lib')
        call add(fileparts, 'omniti')
        let fileparts = fileparts + parts[1:]
        let filepath = join(fileparts, '/') . '.php'
    elseif parts[0] == 'OmniAdmin'
        call add(fileparts, 'admin-app')
        call add(fileparts, 'lib')
        let fileparts = fileparts + parts[1:]
        let filepath = join(fileparts, '/') . '.php'
    elseif parts[0] == 'OmniFront'
        call add(fileparts, 'app')
        call add(fileparts, 'lib')
        let fileparts = fileparts + parts[1:]
        let filepath = join(fileparts, '/') . '.php'
    else
        call add(fileparts, 'app')
        call add(fileparts, 'model')
        let fileparts = fileparts + parts
        let filepath = join(fileparts, '_') . '.php'
    endif
    exe ':e ' . filepath
endfun

