
" Project info
let g:project_info['Agora']['init_func'] = 'g:Project_Init_Agora'

" Init function (buffer setup)
fun! g:Project_Init_Agora()

    " Configuration for the php template plugin
    let b:php_template_config = {
        \   'category'         : 'Agora',
        \   'package'          : '',
        \   'author'           : 'Reha Sterbin <reha@omniti.com>',
        \   'copyright'        : 'Copyright (c) 2016 Message Systems',
        \   'license'          : '',
        \   'link'             : 'http://www.messagesystems.com/',
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
        \       'namespace'          : 'n',
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

endfun

