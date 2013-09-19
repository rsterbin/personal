
" Project info
let g:project_info['EFS']['init_func'] = 'g:Project_Init_EFS'
let g:project_info['EFS']['enter_func'] = 'g:Project_Enter_EFS'
let g:project_info['EFS']['open_func'] = 'g:Project_Open_EFS'
let g:project_info['EFS']['dump_func'] = 'g:Project_Dump_EFS'

" Init function (buffer setup)
fun! g:Project_Init_EFS()

    " Configuration for the php template plugin
    let b:php_template_config = {
        \   'category'         : '',
        \   'package'          : 'EFS2',
        \   'author'           : 'Reha Sterbin <rsterbin@efashionsolutions.com>',
        \   'copyright'        : '2008-2009 eFashionSoutions',
        \   'license'          : '???',
        \   'link'             : '???',
        \   'version'          : 'Initial Release',
        \   'coding_standards' : {
        \       'underscore_prefix'  : 'y',
        \       'docblocks'          : 'y',
        \       'tabs'               : 'n',
        \       'spaces'             : 'y',
        \       'methodauthorline'   : 'y',
        \       'methodsinceline'    : 'n',
        \       'propertysinceline'  : 'n',
        \       'constantsinceline'  : 'n',
        \       'zendloadclass'      : 'y',
        \       'requireclass'       : 'n',
        \       'classbracebelow'    : 'y',
        \       'methodbracebelow'   : 'n',
        \       'parenspacing'       : 'n',
        \       'doxygenworkaround'  : 'n',
        \       'filedocblockorder'  : [ 'copyright', 'license', 'version', 'link', 'since', 'package', 'author' ],
        \       'classdocblockorder' : [ 'copyright', 'license', 'version', 'since', 'package', 'author' ],
        \}
    \}

    " Prep vim for tabs, enforce them, and kill trailing whitespace
    call g:ToggleTabsVsSpaces('tabs')
    let b:enforceTabs = 'y'
    let b:enforceNoTrailingWhitespace = { 'php' : 'y', 'phtml' : 'y', 'js' : 'y', 'css' : 'y' }

endfun

" Enter buffer function
fun! g:Project_Enter_EFS()
    call g:ToggleTabsVsSpaces('spaces')
endfun

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

