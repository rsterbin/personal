
" Project info
let g:project_info['DermApproved']['open_func'] = 'g:Project_Open_DermApproved'
let g:project_info['DermApproved']['category']  = 'DermApproved'
let g:project_info['DermApproved']['package']   = ''
let g:project_info['DermApproved']['author']    = 'Reha Sterbin <reha@omniti.com>'
let g:project_info['DermApproved']['copyright'] = ''
let g:project_info['DermApproved']['license']   = ''
let g:project_info['DermApproved']['link']      = ''
let g:project_info['DermApproved']['version']   = ''

" Coding standards
let g:project_info['DermApproved']['coding_standards'] = {
    \   'underscore_prefix'  : 'n',
    \   'docblocks'          : 'y',
    \   'tabs'               : 'n',
    \   'spaces'             : 'n',
    \   'methodauthorline'   : 'n',
    \   'methodsinceline'    : 'n',
    \   'propertysinceline'  : 'n',
    \   'constantsinceline'  : 'n',
    \   'zendloadclass'      : 'n',
    \   'requireclass'       : 'n',
    \   'classbracebelow'    : 'n',
    \   'methodbracebelow'   : 'n',
    \   'parenspacing'       : 'y',
    \   'doxygenworkaround'  : 'y',
    \   'filedocblockorder'  : [ 'package', 'author', 'version' ],
    \   'classdocblockorder' : [ 'package' ],
    \}

" Enforce spaces and kill trailing whitespace
let b:enforceSpaces = 'y'
let b:enforceNoTrailingWhitespace = { 'php' : 'y', 'phtml' : 'y', 'js' : 'y', 'css' : 'y' }

" Class finder function
fun! g:Project_Open_DermApproved()
    let filepath = 'includes/' . substitute(@", '_', '/', 'g') . '.php'
    exe ':e ' . filepath
endfun

