
" Project info
let g:project_info['DermApproved']['init_func'] = 'g:Project_Init_DermApproved'
let g:project_info['DermApproved']['open_func'] = 'g:Project_Open_DermApproved'

" Init function (buffer setup)
fun! g:Project_Init_DermApproved()

    " Configuration for the php template plugin
    let b:php_template_config = {
        \   'category'  : 'DermApproved',
        \   'package'   : '',
        \   'author'    : 'Reha Sterbin <reha@omniti.com>',
        \   'copyright' : '',
        \   'license'   : '',
        \   'link'      : '',
        \   'version'   : '',
        \   'coding_standards' : {
        \       'underscore_prefix'  : 'n',
        \       'docblocks'          : 'y',
        \       'tabs'               : 'n',
        \       'spaces'             : 'n',
        \       'methodauthorline'   : 'n',
        \       'methodsinceline'    : 'n',
        \       'propertysinceline'  : 'n',
        \       'constantsinceline'  : 'n',
        \       'zendloadclass'      : 'n',
        \       'requireclass'       : 'n',
        \       'classbracebelow'    : 'n',
        \       'methodbracebelow'   : 'n',
        \       'parenspacing'       : 'y',
        \       'doxygenworkaround'  : 'y',
        \       'filedocblockorder'  : [ 'package', 'author', 'version' ],
        \       'classdocblockorder' : [ 'package' ],
        \}
    \}

    " Prep vim for spaces, enforce them, and kill trailing whitespace
    call g:ToggleTabsVsSpaces('spaces')
    let b:enforceSpaces = 'y'
    let b:enforceNoTrailingWhitespace = { 'php' : 'y', 'phtml' : 'y', 'js' : 'y', 'css' : 'y' }

endfun

" Class finder function
fun! g:Project_Open_DermApproved()
    let filepath = 'includes/' . substitute(@", '_', '/', 'g') . '.php'
    exe ':e ' . filepath
endfun

