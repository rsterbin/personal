
" Project info
let g:project_info['default']['init_func'] = 'g:Project_Init_Default'

" Init function (buffer setup)
fun! g:Project_Init_Default()

    " Configuration for the php template plugin
    let b:php_template_config = {
        \   'category'         : 'Default',
        \   'package'          : '',
        \   'author'           : 'Reha Sterbin <reha@sterbinsoftware.com>',
        \   'copyright'        : 'Copyright (c) 2011 Sterbin Software',
        \   'license'          : '',
        \   'link'             : 'http://www.sterbinsoftware.com/',
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

    " Prep vim for spaces
    call g:ToggleTabsVsSpaces('spaces')

endfun

