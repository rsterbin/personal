
" Project info
let g:project_info['Rainbow']['init_func'] = 'g:Project_Init_Rainbow'

" Init function (buffer setup)
fun! g:Project_Init_Rainbow()

    " Configuration for the php template plugin
    let b:php_template_config = {
        \   'category'         : 'Rainbow',
        \   'package'          : '',
        \   'author'           : 'Reha Sterbin <reha@omniti.com>',
        \   'copyright'        : 'Copyright (c) 2010 OmnitTI',
        \   'license'          : '',
        \   'link'             : '',
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
        \       'filedocblockorder'  : [ 'category', 'package', 'copyright', 'version', 'author' ],
        \       'classdocblockorder' : [ 'category', 'package' ],
        \}
    \}

    " Prep vim for spaces
    call g:ToggleTabsVsSpaces('spaces')

endfun

