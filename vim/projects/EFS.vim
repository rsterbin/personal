
" Project info
let g:project_info['EFS'] = {
    \   'directory' : [ 'EFS2' ],
    \   'open_func' : 'g:Project_Open_EFS',
    \   'dump_func' : 'g:Project_Dump_EFS',
    \   'category'  : '',
    \   'package'   : 'EFS2',
    \   'author'    : 'Reha Sterbin <rsterbin@efashionsolutions.com>',
    \   'copyright' : '2008-2009 eFashionSoutions',
    \   'license'   : '???',
    \   'link'      : '???',
    \   'version'   : 'Initial Release',
    \}

" Coding standards
let g:project_info['EFS']['coding_standards'] = {
    \   'underscore_prefix'  : 'y',
    \   'docblocks'          : 'y',
    \   'tabs'               : 'n',
    \   'spaces'             : 'y',
    \   'methodauthorline'   : 'y',
    \   'methodsinceline'    : 'n',
    \   'propertysinceline'  : 'n',
    \   'constantsinceline'  : 'n',
    \   'zendloadclass'      : 'y',
    \   'requireclass'       : 'n',
    \   'classbracebelow'    : 'y',
    \   'methodbracebelow'   : 'n',
    \   'parenspacing'       : 'n',
    \   'doxygenworkaround'  : 'n',
    \   'filedocblockorder'  : [ 'copyright', 'license', 'version', 'link', 'since', 'package', 'author' ],
    \   'classdocblockorder' : [ 'copyright', 'license', 'version', 'since', 'package', 'author' ],
    \}

" Class finder function
fun! g:Project_Open_EFS()
    let filepath = 'lib/' . substitute(@", '_', '/', 'g') . '.php'
    exe ':e ' . filepath
endfun

" Dump function
fun! g:Project_Dump_EFS()
    let blank = "EFS_Util::varDump();"
    let pos = line('.')
    call append(pos, blank)
    exe "normal j$b"
endfun

