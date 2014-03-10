
" Project info
let g:project_info['DoodleDeals']['init_func'] = 'g:Project_Init_DoodleDeals'
let g:project_info['DoodleDeals']['enter_func'] = 'g:Project_Enter_DoodleDeals'
let g:project_info['DoodleDeals']['open_func'] = 'g:Project_Open_DoodleDeals'

" Init function (buffer setup)
fun! g:Project_Init_DoodleDeals()

    " Configuration for the php template plugin
    let b:php_template_config = {
        \   'category'         : 'DoodleDeals',
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
        \       'namespace'          : 'n',
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

" Enter buffer function
fun! g:Project_Enter_DoodleDeals()
    call g:ToggleTabsVsSpaces('spaces')
endfun

" Class finder function
fun! g:Project_Open_DoodleDeals()
    let parts = split(@", '_')
    if len(parts) == 1
        let parts = split(@", '\')
    endif
    let fileparts = []
    if parts[0] == 'DoodleDeals'
        call add(fileparts, 'lib')
        call add(fileparts, 'libdoodledeals')
        let fileparts = fileparts + parts[1:]
        let filepath = join(fileparts, '/') . '.php'
    elseif parts[0] == 'DDFront'
        call add(fileparts, 'servers')
        call add(fileparts, 'www.doodledeals.com')
        call add(fileparts, 'application')
        call add(fileparts, 'library')
        let fileparts = fileparts + parts[1:]
        let filepath = join(fileparts, '/') . '.php'
    elseif parts[0] == 'DDBack'
        call add(fileparts, 'servers')
        call add(fileparts, 'admin.doodledeals.com')
        call add(fileparts, 'application')
        call add(fileparts, 'library')
        let fileparts = fileparts + parts[1:]
        let filepath = join(fileparts, '/') . '.php'
    else
        call add(fileparts, 'lib')
        call add(fileparts, 'external')
        let fileparts = fileparts + parts
        let filepath = join(fileparts, '/') . '.php'
    endif
    exe ':e ' . filepath
endfun

