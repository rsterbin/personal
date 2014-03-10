
" Project info
let g:project_info['OraTV']['open_func'] = 'g:Project_Open_OraTV'
let g:project_info['OraTV']['enter_func'] = 'g:Project_Enter_OraTV'
let g:project_info['OraTV']['init_func'] = 'g:Project_Init_OraTV'

" Init function (buffer setup)
fun! g:Project_Init_OraTV()

    " Configuration for the php template plugin
    let b:php_template_config = {
        \   'category'  : 'Ora',
        \   'package'   : '',
        \   'author'    : 'Reha Sterbin <reha@omniti.com>',
        \   'copyright' : 'Copyright (c) 2012 Ora Media, LLC',
        \   'license'   : '',
        \   'link'      : '',
        \   'version'   : '',
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
        \       'methodbracebelow'   : 'n',
        \       'parenspacing'       : 'n',
        \       'doxygenworkaround'  : 'n',
        \       'filedocblockorder'  : [ 'package', 'copyright', 'version', 'author' ],
        \       'classdocblockorder' : [ 'package', 'copyright' ],
        \}
    \}

    " Prep vim for spaces, enforce them, and kill trailing whitespace
    call g:ToggleTabsVsSpaces('spaces')
    let b:enforceSpaces = 'y'
    let b:enforceNoTrailingWhitespace = { 'php' : 'y', 'phtml' : 'y', 'js' : 'y', 'css' : 'y' }

endfun

" Enter buffer function
fun! g:Project_Enter_OraTV()
    call g:ToggleTabsVsSpaces('spaces')
endfun

" Class finder function
fun! g:Project_Open_OraTV()
    let parts = split(@", '_')
    let fileparts = []
    if parts[0] == 'Zend'
        call add(fileparts, 'application')
        call add(fileparts, 'library')
        call add(fileparts, 'Zend')
        let fileparts = fileparts + parts[1:]
    elseif parts[0] == 'Ora'
        call add(fileparts, 'application')
        call add(fileparts, 'library')
        call add(fileparts, 'Ora')
        let fileparts = fileparts + parts[1:]
    elseif parts[0] == 'Model'
        call add(fileparts, 'application')
        call add(fileparts, 'models')
        let fileparts = fileparts + parts[1:]
    elseif parts[0] == 'ViewHelper'
        call add(fileparts, 'application')
        call add(fileparts, 'views')
        call add(fileparts, 'helpers')
        let fileparts = fileparts + parts[1:]
    elseif parts[0] == 'Application'
        if parts[1] == 'Model'
            call add(fileparts, 'application')
            call add(fileparts, 'models')
            let fileparts = fileparts + parts[2:]
        elseif parts[1] == 'ViewHelper'
            call add(fileparts, 'application')
            call add(fileparts, 'views')
            call add(fileparts, 'helpers')
            let fileparts = fileparts + parts[2:]
        endif
    else
        call add(fileparts, 'application')
        call add(fileparts, 'library')
        call add(fileparts, parts[0])
        let fileparts = fileparts + parts[1:]
    endif
    let filepath = join(fileparts, '/') . '.php'
    echo filepath
    exe ':e ' . filepath
endfun

