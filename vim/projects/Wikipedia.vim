
" Project info
let g:project_info['Wikipedia']['init_func'] = 'g:Project_Init_Wikipedia'
let g:project_info['Wikipedia']['enter_func'] = 'g:Project_Enter_Wikipedia'
let g:project_info['Wikipedia']['open_func'] = 'g:Project_Open_Wikipedia'

" Init function (buffer setup)
fun! g:Project_Init_Wikipedia()

    " Configuration for the php template plugin
    let b:php_template_config = {
        \   'category'         : 'MediaWiki',
        \   'package'          : 'ArticleFeedback',
        \   'author'           : 'Reha Sterbin <reha@omniti.com>',
        \   'copyright'        : '',
        \   'license'          : '',
        \   'link'             : '',
        \   'version'          : '',
        \   'coding_standards' : {
        \       'underscore_prefix'  : 'n',
        \       'docblocks'          : 'y',
        \       'tabs'               : 'y',
        \       'spaces'             : 'n',
        \       'methodauthorline'   : 'n',
        \       'methodsinceline'    : 'n',
        \       'propertysinceline'  : 'n',
        \       'constantsinceline'  : 'n',
        \       'namespace'          : 'n',
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

    " Prep vim for tabs, enforce them, and kill trailing whitespace
    call g:ToggleTabsVsSpaces('tabs')
    let b:enforceTabs = 'y'
    let b:enforceNoTrailingWhitespace = { 'php' : 'y', 'phtml' : 'y', 'js' : 'y', 'css' : 'y' }
    let b:ignoreTrailingWhitespace = { 'ArticleFeedbackv5.i18n.php' : 'y' }

endfun

" Enter buffer function
fun! g:Project_Enter_Taubman()
    call g:ToggleTabsVsSpaces('tabs')
endfun

" Class finder function
fun! g:Project_Open_Wikipedia()
    let filepath = 'includes/' . substitute(@", '_', '/', 'g') . '.php'
    exe ':e ' . filepath
endfun

