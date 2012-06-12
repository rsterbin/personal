
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
        if parts[1] == 'Model' && len(parts) > 2
            call add(fileparts, 'lib')
            call add(fileparts, 'models')
            let fileparts = fileparts + parts[2:]
        elseif parts[1] == 'Front' && len(parts) > 2
            if parts[2] == 'Form' && len(parts) > 3
                call add(fileparts, 'sites')
                call add(fileparts, 'frontend')
                call add(fileparts, 'application')
                call add(fileparts, 'forms')
                let fileparts = fileparts + parts[3:]
            else
                call add(fileparts, 'sites')
                call add(fileparts, 'frontend')
                call add(fileparts, 'application')
                call add(fileparts, 'library')
                let fileparts = fileparts + parts[3:]
            endif
        elseif parts[1] == 'Admin' && len(parts) > 2
            if parts[2] == 'Form' && len(parts) > 3
                call add(fileparts, 'sites')
                call add(fileparts, 'admin')
                call add(fileparts, 'application')
                call add(fileparts, 'forms')
                let fileparts = fileparts + parts[3:]
            else
                call add(fileparts, 'sites')
                call add(fileparts, 'admin')
                call add(fileparts, 'application')
                call add(fileparts, 'library')
                let fileparts = fileparts + parts[3:]
            endif
        else
            call add(fileparts, 'lib')
            call add(fileparts, 'hphome')
            let fileparts = fileparts + parts[1:]
        endif
    else
        call add(fileparts, 'lib')
        let fileparts = fileparts + parts
    endif
    let filepath = join(fileparts, '/') . '.php'
    exe ':e ' . filepath
endfun

