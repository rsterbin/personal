
" Project info
let g:project_info['Wikipedia']['open_func'] = 'g:Project_Open_Wikipedia'
let g:project_info['Wikipedia']['category']  = 'MediaWiki'
let g:project_info['Wikipedia']['package']   = 'ArticleFeedback'
let g:project_info['Wikipedia']['author']    = 'Reha Sterbin <reha@omniti.com>'
let g:project_info['Wikipedia']['copyright'] = ''
let g:project_info['Wikipedia']['license']   = ''
let g:project_info['Wikipedia']['link']      = ''
let g:project_info['Wikipedia']['version']   = ''

" Coding standards
let g:project_info['Wikipedia']['coding_standards'] = {
    \   'underscore_prefix'  : 'n',
    \   'docblocks'          : 'y',
    \   'tabs'               : 'y',
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
fun! g:Project_Open_Wikipedia()
    let filepath = 'includes/' . substitute(@", '_', '/', 'g') . '.php'
    exe ':e ' . filepath
endfun

