
" Project info
let g:project_info['DoodleDeals'] = {
    \   'directory' : [ 'doodledeals' ],
    \   'open_func' : 'g:Project_Open_DoodleDeals',
    \   'category'  : 'DoodleDeals',
    \   'package'   : '',
    \   'author'    : 'Reha Sterbin <reha@omniti.com>',
    \   'copyright' : 'Copyright (c) 2010 OmnitTI',
    \   'license'   : '',
    \   'link'      : '',
    \   'version'   : '',
    \}

" Coding standards
let g:project_info['DoodleDeals']['coding_standards'] = {
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
    \   'filedocblockorder'  : [ 'category', 'package', 'copyright', 'version', 'author' ],
    \   'classdocblockorder' : [ 'category', 'package', 'copyright' ],
    \}

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

