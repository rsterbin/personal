
" Project info
let g:project_info['OraTV']['open_func'] = 'g:Project_Open_OraTV'

" Configuration for the php template plugin
let b:php_template_config = {
    \   'category'  : 'Ora',
    \   'package'   : '',
    \   'author'    : 'Reha Sterbin <reha@omniti.com>',
    \   'copyright' : 'Copyright (c) 2012 Ora Media, LLC',
    \   'license'   : '',
    \   'link'      : '',
    \   'version'   : '',
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
    \       'methodbracebelow'   : 'n',
    \       'parenspacing'       : 'n',
    \       'doxygenworkaround'  : 'n',
    \       'filedocblockorder'  : [ 'package', 'copyright', 'version', 'author' ],
    \       'classdocblockorder' : [ 'package', 'copyright' ],
    \}
\}

" Enforce spaces and kill trailing whitespace
let b:enforceSpaces = 'y'
let b:enforceNoTrailingWhitespace = { 'php' : 'y', 'phtml' : 'y', 'js' : 'y', 'css' : 'y' }

" Class finder function
fun! g:Project_Open_OraTV()
    let filepath = 'includes/' . substitute(@", '_', '/', 'g') . '.php'
    exe ':e ' . filepath
endfun

