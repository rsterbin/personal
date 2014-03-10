
" Project info
let g:project_info['SoulCycle']['init_func'] = 'g:Project_Init_SoulCycle'

" Init function (buffer setup)
fun! g:Project_Init_SoulCycle()

    " Configuration for the php template plugin
    let b:php_template_config = {
        \   'category'         : 'SoulCycle',
        \   'package'          : '',
        \   'author'           : 'Reha Sterbin <reha@omniti.com>',
        \   'copyright'        : '',
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
        \       'classdocblockorder' : [ 'category', 'package' ],
        \}
    \}

endfun

