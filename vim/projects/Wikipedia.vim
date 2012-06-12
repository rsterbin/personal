
" Project info
let g:project_info['Wikipedia'] = {
    \   'directory' : [ 'mediawiki', 'wiki-commit', 'wiki-internal', 'wiki-external' ],
    \   'open_func' : 'g:Project_Open_Wikipedia',
    \   'category'  : 'MediaWiki',
    \   'package'   : 'ArticleFeedback',
    \   'author'    : 'Reha Sterbin <reha@omniti.com>',
    \   'copyright' : '',
    \   'license'   : '',
    \   'link'      : '',
    \   'version'   : '',
    \}

" Coding standards
let g:project_info['Wikipedia']['coding_standards'] = {
    \   'underscore_prefix'  : 'n',
    \   'docblocks'          : 'y',
    \   'tabs'               : 'y',
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

