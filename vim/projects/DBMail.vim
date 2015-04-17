
" Project info
let g:project_info['DBMail']['init_func'] = 'g:Project_Init_DBMail'
let g:project_info['DBMail']['enter_func'] = 'g:Project_Enter_DBMail'

" Init function (buffer setup)
fun! g:Project_Init_DBMail()

    " Configuration for the php template plugin
    let b:php_template_config = {
        \   'category'         : 'DigitalBranding',
        \   'package'          : '',
        \   'author'           : 'Reha Sterbin <reha@omniti.com>',
        \   'copyright'        : '',
        \   'license'          : '',
        \   'link'             : '',
        \   'version'          : 'DATE',
        \   'coding_standards' : {
        \       'underscore_prefix'  : 'n',
        \       'docblocks'          : 'n',
        \       'tabs'               : 'n',
        \       'spaces'             : 'y',
        \       'methodauthorline'   : 'n',
        \       'methodsinceline'    : 'n',
        \       'propertysinceline'  : 'n',
        \       'constantsinceline'  : 'n',
        \       'namespace'          : 'y',
        \       'zendloadclass'      : 'n',
        \       'requireclass'       : 'n',
        \       'classbracebelow'    : 'y',
        \       'methodbracebelow'   : 'y',
        \       'parenspacing'       : 'n',
        \       'doxygenworkaround'  : 'n',
        \       'filedocblockorder'  : [],
        \       'classdocblockorder' : [],
        \}
    \}

    " Prep vim for spaces, enforce them, and kill trailing whitespace
    call g:ToggleTabsVsSpaces('spaces')
    let b:enforceSpaces = 'y'
    let b:enforceNoTrailingWhitespace = { 'php' : 'y', 'js' : 'y', 'css' : 'y' }

endfun

" Enter buffer function
fun! g:Project_Enter_DBMail()
    call g:ToggleTabsVsSpaces('spaces')
endfun

