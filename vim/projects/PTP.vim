
" Project info
let g:project_info['PTP']['init_func'] = 'g:Project_Init_PTP'

" Init function (buffer setup)
fun! g:Project_Init_PTP()

    " Configuration for the php template plugin
    let b:php_template_config = {
        \   'category'         : 'PTP',
        \   'package'          : '',
        \   'author'           : 'Reha Sterbin <reha@omniti.com>',
        \   'copyright'        : 'Copyright (c) 2015 Pass The Plate',
        \   'license'          : '',
        \   'link'             : 'http://www.passtheplate.com/',
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
        \       'namespace'          : 'y',
        \       'zendloadclass'      : 'n',
        \       'requireclass'       : 'n',
        \       'classbracebelow'    : 'y',
        \       'methodbracebelow'   : 'y',
        \       'parenspacing'       : 'n',
        \       'doxygenworkaround'  : 'n',
        \       'filedocblockorder'  : [ 'category', 'version', 'author', 'since' ],
        \       'classdocblockorder' : [ 'category', 'since' ],
        \}
    \}

    " Prep vim for spaces
    call g:ToggleTabsVsSpaces('spaces')

endfun

