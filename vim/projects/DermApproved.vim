
" Project info
let g:project_info['DermApproved'] = {
    \   'directory' : [ 'dermapproved' ],
    \   'open_func' : 'g:Project_Open_DermApproved',
    \   'category'  : 'DermApproved',
    \   'package'   : '',
    \   'author'    : 'Reha Sterbin <reha@omniti.com>',
    \   'copyright' : '',
    \   'license'   : '',
    \   'link'      : '',
    \   'version'   : '',
    \}

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

" Class finder function
fun! g:Project_Open_DermApproved()
    let filepath = 'includes/' . substitute(@", '_', '/', 'g') . '.php'
    exe ':e ' . filepath
endfun

