
" Project info
let g:project_info['fork_daemon']['init_func'] = 'g:Project_Init_fork_daemon'
let g:project_info['fork_daemon']['enter_func'] = 'g:Project_Enter_fork_daemon'

" Init function (buffer setup)
fun! g:Project_Init_fork_daemon()

    " Configuration for the php template plugin
    let b:php_template_config = {
        \   'category'         : 'system',
        \   'package'          : 'fork_daemon',
        \   'author'           : 'Reha Sterbin <rsterbin@gmail.com>',
        \   'copyright'        : '',
        \   'license'          : '',
        \   'link'             : '',
        \   'version'          : 'DATE',
        \   'coding_standards' : {
        \       'underscore_prefix'  : 'n',
        \       'docblocks'          : 'y',
        \       'tabs'               : 'y',
        \       'spaces'             : 'n',
        \       'methodauthorline'   : 'n',
        \       'methodsinceline'    : 'n',
        \       'propertysinceline'  : 'n',
        \       'constantsinceline'  : 'n',
        \       'zendloadclass'      : 'n',
        \       'requireclass'       : 'n',
        \       'classbracebelow'    : 'y',
        \       'methodbracebelow'   : 'y',
        \       'parenspacing'       : 'y',
        \       'doxygenworkaround'  : 'n',
        \       'filedocblockorder'  : [ 'category', 'package' ],
        \       'classdocblockorder' : [ ],
        \}
    \}

    " Prep vim for tabs, enforce them, and kill trailing whitespace
    call g:ToggleTabsVsSpaces('tabs')
    let b:enforceTabs = 'y'
    let b:enforceNoTrailingWhitespace = { 'php' : 'y' }

endfun

" Enter buffer function
fun! g:Project_Enter_fork_daemon()
    call g:ToggleTabsVsSpaces('tabs')
endfun

