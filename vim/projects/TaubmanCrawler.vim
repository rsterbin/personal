
" Project info
let g:project_info['TaubmanCrawler']['init_func'] = 'g:Project_Init_TaubmanCrawler'

" Init function (buffer setup)
fun! g:Project_Init_TaubmanCrawler()

    " Prep vim for spaces
    call g:ToggleTabsVsSpaces('spaces')

    " Python: fold by indents
    set foldmethod=indent

endfun

