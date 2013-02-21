
" Project info
let g:project_info['Alli']['open_func'] = 'g:Project_Open_Alli'

" Configuration for the php template plugin
let b:php_template_config = {
    \   'category'         : 'OmniTICMS',
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
    \       'classbracebelow'    : 'n',
    \       'methodbracebelow'   : 'n',
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
fun! g:Project_Open_Alli()
    let parts = split(@", '_')
    let fileparts = []
    if parts[0] == 'OmniTICMS'
        if parts[1] == 'Module'
            call add(fileparts, 'application')
            call add(fileparts, 'modules')
            call add(fileparts, parts[2])
            if parts[3] == 'Controller'
                call add(fileparts, 'controllers')
                let fileparts = fileparts + parts[4:]
            elseif parts[3] == 'Model'
                call add(fileparts, 'models')
                let fileparts = fileparts + parts[4:]
            elseif parts[3] == 'Forms'
                call add(fileparts, 'forms')
                let fileparts = fileparts + parts[4:]
            elseif (parts[3] == 'View' && parts[4] == 'Helper')
                call add(fileparts, 'views')
                call add(fileparts, 'helpers')
                let fileparts = fileparts + parts[5:]
            else
                let fileparts = fileparts + parts[3:]
            endif
        elseif parts[1] == 'Controller'
            call add(fileparts, 'application')
            call add(fileparts, 'controllers')
            let fileparts = fileparts + parts[2:]
        elseif parts[1] == 'Model'
            call add(fileparts, 'application')
            call add(fileparts, 'models')
            let fileparts = fileparts + parts[2:]
        elseif parts[1] == 'Forms'
            call add(fileparts, 'application')
            call add(fileparts, 'forms')
            let fileparts = fileparts + parts[2:]
        elseif (parts[1] == 'View' && parts[2] == 'Helper')
            call add(fileparts, 'application')
            call add(fileparts, 'views')
            call add(fileparts, 'helpers')
            let fileparts = fileparts + parts[3:]
        else
            call add(fileparts, 'lib')
            call add(fileparts, 'OmniTICMS')
            let fileparts = fileparts + parts[1:]
        endif
        let filepath = join(fileparts, '/') . '.php'
    else
        let filepath = 'lib/' . join(parts, '/') . '.php'
    endif
    exe ':e ' . filepath
endfun

