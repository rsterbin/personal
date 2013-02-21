
" Project info
let g:project_info['OmniCMS']['open_func'] = 'g:Project_Open_OmniCMS'

" Configuration for the php template plugin
let b:php_template_config = {
    \   'category'         : 'OmniCMS',
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

" Class finder function
fun! g:Project_Open_OmniCMS()
    let parts = split(@", '_')
    let fileparts = []
    if parts[0] == 'Zend'
        call add(fileparts, 'core')
        call add(fileparts, 'Zend')
        let fileparts = fileparts + parts[1:]
    elseif parts[0] == 'OmniCMS'
        if parts[1] == 'Model' && len(parts) > 2
            call add(fileparts, 'core')
            call add(fileparts, 'models')
            let fileparts = fileparts + parts[2:]
        elseif parts[1] == 'Form' && len(parts) > 2
            call add(fileparts, 'core')
            call add(fileparts, 'forms')
            let fileparts = fileparts + parts[2:]
        else
            call add(fileparts, 'core')
            call add(fileparts, 'library')
            let fileparts = fileparts + parts[1:]
        endif
    elseif parts[0] == 'OmniModule'
        if parts[2] == 'Model' && len(parts) > 2
            call add(fileparts, 'modules')
            call add(fileparts, tolower(parts[1]))
            call add(fileparts, 'models')
            let fileparts = fileparts + parts[3:]
        elseif parts[2] == 'Form' && len(parts) > 2
            call add(fileparts, 'modules')
            call add(fileparts, tolower(parts[1]))
            call add(fileparts, 'forms')
            let fileparts = fileparts + parts[3:]
        else
            call add(fileparts, 'modules')
            call add(fileparts, tolower(parts[1]))
            call add(fileparts, 'library')
            let fileparts = fileparts + parts[2:]
        endif
    elseif parts[0] == 'OmniPlugin'
        call add(fileparts, 'plugins')
        let fileparts = fileparts + parts[1:]
    else
        call add(fileparts, 'plugins')
        call add(fileparts, parts[0])
        call add(fileparts, 'library')
        let fileparts = fileparts + parts[1:]
    endif
    let filepath = join(fileparts, '/') . '.php'
    exe ':e ' . filepath
endfun

