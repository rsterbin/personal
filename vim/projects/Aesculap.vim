
" Project info
let g:project_info['Aesculap']['open_func'] = 'g:Project_Open_Aesculap'
let g:project_info['Aesculap']['category']  = ''
let g:project_info['Aesculap']['package']   = 'Aesculap'
let g:project_info['Aesculap']['author']    = 'Reha Sterbin <reha@omniti.com>'
let g:project_info['Aesculap']['copyright'] = 'Copyright (c) 2011 OmnitTI'
let g:project_info['Aesculap']['license']   = ''
let g:project_info['Aesculap']['link']      = ''
let g:project_info['Aesculap']['version']   = ''

" Coding standards
let g:project_info['Aesculap']['coding_standards'] = {
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
    \   'methodbracebelow'   : 'n',
    \   'parenspacing'       : 'n',
    \   'doxygenworkaround'  : 'n',
    \   'filedocblockorder'  : [ 'category', 'package', 'copyright', 'version', 'author' ],
    \   'classdocblockorder' : [],
    \}

" Class finder function
fun! g:Project_Open_Aesculap()
    let parts = split(@", '_')
    let fileparts = []
    if parts[0] == 'Aesculap'
        if parts[1] == 'Library'
            call add(fileparts, 'lib')
            let fileparts = fileparts + parts[2:]
        else
            call add(fileparts, 'lib')
            let fileparts = fileparts + parts[1:]
        endif
        let filepath = join(fileparts, '/') . '.php'
    elseif parts[0] == 'WorldConnect'
        call add(fileparts, 'app')
        if parts[1] == 'Model'
            call add(fileparts, 'models')
            let fileparts = fileparts + parts[2:]
        elseif parts[1] == 'Form'
            call add(fileparts, 'models')
            call add(fileparts, 'forms')
            let fileparts = fileparts + parts[2:]
        elseif parts[1] == 'Controller'
            call add(fileparts, 'controllers')
            let fileparts = fileparts + parts[2:]
        else
            let fileparts = fileparts + parts[1:]
        endif
        let filepath = join(fileparts, '/') . '.php'
    else
        let filepath = 'lib/vendor/' . join(parts, '/') . '.php'
    endif
    exe ':e ' . filepath
endfun

