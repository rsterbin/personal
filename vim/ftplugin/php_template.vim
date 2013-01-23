" vim: set foldlevel=0 foldmethod=marker:

" Vim filetype plugin file for code templates for PHP 4 and 5 development. The
" code is formatted according to house coding standards.
"
" The provided templates are:
"  - Blank file
"  - Function
"  - Class file
"  - Class (file header and footer removed)
"  - Extended class
"  - Model subclass
"  - Method
"  - Get and set methods
"  - Property + get and set methods
"  - Property + get, add, and clear methods
"  - 'Whether' method
"  - Property
"  - Constant
"  - Test file
"  - Test method
"
"  Uses project.vim to automatically set the coding standards and category

" {{{ config

if exists("b:did_phpclass_plugin")
  finish
endif
let b:did_phpclass_plugin = 1

" Mappings
nnoremap <leader>fi  :call InsertFile()<CR>
nnoremap <leader>fu  :call InsertFunction()<CR>
nnoremap <leader>cl  :call InsertClass()<CR>
nnoremap <leader>sc  :call InsertSubclass()<CR>
nnoremap <leader>ec  :call InsertExtendedClass()<CR>
nnoremap <leader>me  :call InsertMethod()<CR>
nnoremap <leader>gs  :call InsertGetSet()<CR>
nnoremap <leader>gac :call InsertGetAddClear()<CR>
nnoremap <leader>pgs :call InsertPropertyGetSet()<CR>
nnoremap <leader>pac :call InsertPropertyGetAddClear()<CR>
nnoremap <leader>wh  :call InsertWhether()<CR>
nnoremap <leader>pr  :call InsertProperty()<CR>
nnoremap <leader>cn  :call InsertConstant()<CR>
nnoremap <leader>tf  :call InsertTestFile()<CR>
nnoremap <leader>tm  :call InsertTestMethod()<CR>

" Make sure we are in vim mode
let s:save_cpo = &cpo
set cpo&vim
let s:indent = ''

" }}}
" {{{ Insert Methods
"   {{{ InsertFile()

function! InsertFile() range
    let category = s:getCategory('y')
    if category == 'Q'
        return
    endif
    let package = s:getPackage('y')
    if package == 'Q'
        return
    endif

    call s:setStandards()
    let text = s:get_template_file()
    let text = substitute(text, '%category%', category, 'g')
    let text = substitute(text, '%package%', package, 'g')

    if s:coding_standard_docblocks == 'y'
        let subpackage = input('Subpackage name? ')
        if subpackage == 'Q'
            return
        endif
        let text = substitute(text, '%subpackageline%', s:getDocLine('subpackage', subpackage, ' '), 'g')
    else
        let subpackage = ''
    endif

    let text = substitute(text, '%copyright%', s:getCopyright(), 'g')
    let text = substitute(text, '%license%', s:getLicense(), 'g')
    let text = substitute(text, '%since%', s:getVersion(), 'g')
    let text = substitute(text, '%link%', s:getLink(), 'g')
    let text = substitute(text, '%author%', s:getAuthor(), 'g')

    if s:coding_standard_docblocks == 'y'
        let text = s:parameterize_template(text, "Description? ", '%description%', '')
    endif
    call s:append_text(line('.'), text)
    normal dd
    set expandtab tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=marker foldlevel=0
endfunction

"   }}}
"   {{{ InsertFunction()

function! InsertFunction() range

    let functionname = input("Function name? ")
    if functionname == 'Q'
        return
    endif

    let category = s:getCategory('y')
    let package  = s:getPackage('n')

    call s:setStandards()
    let text = s:get_template_function()
    let text = substitute(text, '%function%', functionname, 'g')
    if s:coding_standard_docblocks == 'y'
        let text = s:parameterize_template(text, "Description? ", '%description%', '')
    endif

    if s:coding_standard_doxygenworkaround == 'y'
        let paramstemplate = "\n * @param  $%name% %type% %desc%"
    else
        let paramstemplate = "\n * @param  %type% $%name% %desc%"
    endif
    let paramsline = ''
    let paramsdec  = ''
    let param = input('Add parameter? (n/y) ')
    while param == 'y'
        let thisparams = paramstemplate
        let paramname = input('Name? ')
        let paramtype = input('Type? ')
        if paramtype == ''
            paramtype = 'mixed'
        endif
        let thisparams = substitute(thisparams, '%name%', paramname, 'g')
        let thisparams = substitute(thisparams, '%type%', paramtype, 'g')
        if s:coding_standard_docblocks == 'y'
            let paramdesc = input('Description? ')
        else
            let paramdesc = ''
        endif
        let paramdefault = input('Default? ')
        if paramdefault != ''
            let paramname = paramname . ' = ' . paramdefault
            let paramdesc = '[optional] ' . paramdesc
        endif
        let thisparams = substitute(thisparams, '%desc%', paramdesc, 'g')
        if paramsdec != ''
            let paramsdec = paramsdec . ', '
        endif
        if paramtype == 'string' || paramtype == 'int' || paramtype == 'mixed' || paramtype == 'bool' || paramtype == 'float' || paramtype == 'void'
            let paramsdec = paramsdec . '$' . paramname
        else
            let paramsdec = paramsdec . paramtype . ' $' . paramname
        endif
        let paramsline = paramsline . thisparams
        let param = input('Add parameter? (n/y) ')
    endwhile
    let text = substitute(text, '%paramsline%', paramsline, 'g')
    let text = substitute(text, '%paramsdec%', paramsdec, 'g')
    let returntemplate = "\n * @return %type% %desc%"
    let returnline = ''
    let returnval  = input('Return? (n/y) ')
    if returnval == 'y'
        let returntype = input('Type? ')
        if returntype == ''
            returntype = 'mixed'
        endif
        let returntemplate = substitute(returntemplate, '%type%', returntype, 'g')
        if s:coding_standard_docblocks == 'y'
            let returntemplate = substitute(returntemplate, '%desc%', input('Description? '), 'g')
        else
            let returntemplate = substitute(returntemplate, '%desc%', '', 'g')
        endif
        let returnline = returntemplate
    endif
    let text = substitute(text, '%returnline%', returnline, 'g')

    let subpackage = s:getSubpackage('n')
    if (s:coding_standard_methodsinceline == 'y')
        let pkgvrsn    = s:getVersion()
        let filvrsn    = s:getFileVersion()
        if pkgvrsn != filvrsn
            let pkgvrsnline = "\n *\n * @since " . pkgvrsn
        else
            let pkgvrsnline = ""
        endif
        let text = substitute(text, '%funcversion%', pkgvrsnline, 'g')
    endif
    let text = substitute(text, '%author%', s:getAuthor(), 'g')

    normal o
    call s:append_text(line('.'), text)
    normal ddj}kk$zx
endfunction

"   }}}
"   {{{ InsertClass()

function! InsertClass() range

    let category = s:getCategory('y')
    if category == 'Q'
        return
    endif
    let package = s:getPackage('y')
    if package == 'Q'
        return
    endif

    call s:setStandards()
    let text = s:get_template_class()
    let text = substitute(text, '%category%', category, 'g')
    let text = substitute(text, '%package%', package, 'g')

    if s:coding_standard_docblocks == 'y'
        let subpackage = input('Subpackage name? ')
        let text = substitute(text, '%subpackageline%', s:getDocLine('subpackage', subpackage, ' '), 'g')
    else
        let subpackage = ''
    endif

    let text = substitute(text, '%copyright%', s:getCopyright(), 'g')
    let text = substitute(text, '%license%', s:getLicense(), 'g')
    let text = substitute(text, '%since%', s:getVersion(), 'g')
    let text = substitute(text, '%link%', s:getLink(), 'g')
    let text = substitute(text, '%author%', s:getAuthor(), 'g')

    let text = s:parameterize_template(text, "Class name? ", '%classname%', '')
    if s:coding_standard_docblocks == 'y'
        let text = s:parameterize_template(text, "Description? ", '%description%', '')
    endif
    call s:append_text(line('.'), text)
    normal dd
    set expandtab tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=marker foldlevel=0
endfunction

"   }}}
"   {{{ InsertExtendedClass()

function! InsertExtendedClass() range

    let category = s:getCategory('y')
    if category == 'Q'
        return
    endif
    let package = s:getPackage('y')
    if package == 'Q'
        return
    endif

    call s:setStandards()
    let text = s:get_template_extclass()
    let text = substitute(text, '%category%', category, 'g')
    let text = substitute(text, '%package%', package, 'g')

    if s:coding_standard_docblocks == 'y'
        let subpackage = input('Subpackage name? ')
        let text = substitute(text, '%subpackageline%', s:getDocLine('subpackage', subpackage, ' '), 'g')
    else
        let subpackage = ''
    endif

    let text = substitute(text, '%copyright%', s:getCopyright(), 'g')
    let text = substitute(text, '%license%', s:getLicense(), 'g')
    let text = substitute(text, '%since%', s:getVersion(), 'g')
    let text = substitute(text, '%link%', s:getLink(), 'g')
    let text = substitute(text, '%author%', s:getAuthor(), 'g')

    let text = s:parameterize_template(text, "Class name? ", '%classname%', '')
    let text = s:parameterize_template(text, "Extends? ", '%parentclass%', '')
    if s:coding_standard_docblocks == 'y'
        let text = s:parameterize_template(text, "Description? ", '%description%', '')
    endif
    call s:append_text(line('.'), text)
    normal dd
    set expandtab tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=marker foldlevel=0
endfunction

"   }}}
"   {{{ InsertSubclass()

function! InsertSubclass() range

    let category = s:getCategory('y')
    if category == 'Q'
        return
    endif
    let package = s:getPackage('y')
    if package == 'Q'
        return
    endif

    call s:setStandards()
    let text = s:get_template_subclass()
    let text = substitute(text, '%category%', category, 'g')
    let text = substitute(text, '%package%', package, 'g')

    if s:coding_standard_docblocks == 'y'
        let subpackage = input('Subpackage name? ')
        let text = substitute(text, '%subpackageline%', s:getDocLine('subpackage', subpackage, ' '), 'g')
    else
        let subpackage = ''
    endif

    let text = substitute(text, '%copyright%', s:getCopyright(), 'g')
    let text = substitute(text, '%license%', s:getLicense(), 'g')
    let text = substitute(text, '%since%', s:getVersion(), 'g')
    let text = substitute(text, '%link%', s:getLink(), 'g')
    let text = substitute(text, '%author%', s:getAuthor(), 'g')

    let text = s:parameterize_template(text, "Class name? ", '%classname%', '')
    if s:coding_standard_docblocks == 'y'
        let text = s:parameterize_template(text, "Description? ", '%description%', '')
    endif

    normal o
    call s:append_text(line('.'), text)
    normal ddj}kk$zx
endfunction

"   }}}
"   {{{ InsertMethod()

function! InsertMethod() range

    let functionname = input("Function name? ")
    if functionname == 'Q'
        return
    endif

    let category = s:getCategory('n')
    let package = s:getPackage('n')

    call s:setStandards()
    let text = s:get_template_method()
    let text = substitute(text, '%function%', functionname, 'g')
    if s:coding_standard_docblocks == 'y'
        let text = s:parameterize_template(text, "Description? ", '%description%', '')
    endif
    let text = s:parameterize_template(text, "Access level? (public/private/protected) ", '%access%', 'public')

    let abstractval  = input('Abstract? (n/y) ')
    let abstractline = ''
    let abstractcontents = ''
    if abstractval == 'y'
        let text = substitute(text, '%declarestyle%', ';', 'g')
        let abstractline = "\n     * @abstract"
        let abstractcontents = 'abstract '
    else
        if s:coding_standard_methodbracebelow == 'y'
            let text = substitute(text, '%declarestyle%', "\n\t{\n\t}", 'g')
        else
            let text = substitute(text, '%declarestyle%', " {\n\t}", 'g')
        endif
    endif
    let text = substitute(text, '%abstract%', abstractcontents, 'g')
    let text = substitute(text, '%abstractline%', abstractline, 'g')

    let isstatic = ''
    let staticline = ''
    let static = input("Static? (n/y) ")
    if static == 'y'
        let isstatic = ' static'
        let staticline = "\n     * @static"
    endif
    let text = substitute(text, '%static%', isstatic, 'g')
    let text = substitute(text, '%staticline%', staticline, 'g')

    if s:coding_standard_doxygenworkaround == 'y'
        let paramstemplate = "\n     * @param  $%name% %type% %desc%"
    else
        let paramstemplate = "\n     * @param  %type% $%name% %desc%"
    endif
    let paramsline = ''
    let paramsdec  = ''
    let param = input('Add parameter? (n/y) ')
    while param == 'y'
        let thisparams = paramstemplate
        let paramname = input('Name? ')
        let paramtype = input('Type? ')
        if paramtype == ''
            let paramtype = 'mixed'
        endif
        let thisparams = substitute(thisparams, '%name%', paramname, 'g')
        let thisparams = substitute(thisparams, '%type%', paramtype, 'g')
        if s:coding_standard_docblocks == 'y'
            let paramdesc = input('Description? ')
        else
            let paramdesc = ''
        endif
        let paramdefault = input('Default? ')
        if paramdefault != ''
            let paramname = paramname . ' = ' . paramdefault
            let paramdesc = '[optional] ' . paramdesc
        endif
        let thisparams = substitute(thisparams, '%desc%', paramdesc, 'g')
        if paramsdec != ''
            let paramsdec = paramsdec . ', '
        endif
        if paramtype == 'string' || paramtype == 'int' || paramtype == 'mixed' || paramtype == 'bool' || paramtype == 'float' || paramtype == 'void'
            let paramsdec = paramsdec . '$' . paramname
        else
            let paramsdec = paramsdec . paramtype . ' $' . paramname
        endif
        let paramsline = paramsline . thisparams
        let param = input('Add parameter? (n/y) ')
    endwhile
    let text = substitute(text, '%paramsline%', paramsline, 'g')
    let text = substitute(text, '%paramsdec%', paramsdec, 'g')
    let returntemplate = "\n     * @return %type% %desc%"
    let returnline = ''
    let returnval  = input('Return? (n/y) ')
    if returnval == 'y'
        let returntype = input('Type? ')
        if returntype == ''
            returntype = 'mixed'
        endif
        let returntemplate = substitute(returntemplate, '%type%', returntype, 'g')
        if s:coding_standard_docblocks == 'y'
            let returntemplate = substitute(returntemplate, '%desc%', input('Description? '), 'g')
        else
            let returntemplate = substitute(returntemplate, '%desc%', '', 'g')
        endif
        let returnline = returntemplate
    endif
    let text = substitute(text, '%returnline%', returnline, 'g')

    let subpackage = s:getSubpackage('n')
    if (s:coding_standard_methodsinceline == 'y')
        let pkgvrsn = s:getVersion()
        let clavrsn = s:getClassVersion()
        if pkgvrsn != clavrsn
            let pkgvrsnline = "\n\t *\n\t * @since " . pkgvrsn
        else
            let pkgvrsnline = ""
        endif
        let text = substitute(text, '%methodversion%', pkgvrsnline, 'g')
    else
        let text = substitute(text, '%methodversion%', '', 'g')
    endif
    let text = substitute(text, '%author%', s:getAuthor(), 'g')

    normal o
    call s:append_text(line('.'), text)
    normal ddj}kk$zx
endfunction

"   }}}
"   {{{ InsertGetSet()

function! InsertGetSet() range

    let varname = input('Variable Name? ')
    if varname == 'Q'
        return
    endif

    let category = s:getCategory('n')
    let package = s:getPackage('n')

    call s:setStandards()
    let text = s:get_template_getset()
    let capvarname = input('Method Variable Name? (blank to capitalize) ')
    if capvarname == ''
        let capvarname = substitute(varname, '^\([a-z]\)', '\U\1\E', 'g')
    endif
    let inpvarname = input('Input Variable Name? (blank to copy) ')
    if inpvarname == ''
        let inpvarname = varname
    endif
    if s:coding_standard_docblocks == 'y'
        let text = s:parameterize_template(text, "Description? ", '%description%', '')
    endif
    let vtype = input('Type? ')
    if vtype == 'string' || vtype == 'int' || vtype == 'array' || vtype == 'bool' || vtype == 'float' || vtype == 'void'
        let text = substitute(text, '%type%', vtype, 'g')
        let text = substitute(text, '%typehint%', '', 'g')
    else
        let text = substitute(text, '%type%', vtype, 'g')
        let text = substitute(text, '%typehint%', vtype . ' ', 'g')
    endif
    let text = substitute(text, '%varname%', varname, 'g')
    let text = substitute(text, '%capvarname%', capvarname, 'g')
    let text = substitute(text, '%inpvarname%', inpvarname, 'g')

    let subpackage = s:getSubpackage('n')
    if (s:coding_standard_methodsinceline == 'y')
        let pkgvrsn = s:getVersion()
        let clavrsn = s:getClassVersion()
        if pkgvrsn != clavrsn
            let pkgvrsnline = "\n\t *\n\t * @since " . pkgvrsn
        else
            let pkgvrsnline = ""
        endif
        let text = substitute(text, '%methodversion%', pkgvrsnline, 'g')
    else
        let text = substitute(text, '%methodversion%', '', 'g')
    endif
    let text = substitute(text, '%author%', s:getAuthor(), 'g')

    normal o
    call s:append_text(line('.'), text)
    normal ddj}kk$zx
endfunction

"   }}}
"   {{{ InsertGetAddClear()

function! InsertGetAddClear() range

    let varname = input('Variable Name? ')
    if varname == 'Q'
        return
    endif

    let category = s:getCategory('n')
    let package = s:getPackage('n')

    call s:setStandards()
    let text = s:get_template_getaddclear()
    let capvarname = input('Method Variable Name? (blank to capitalize) ')
    if capvarname == ''
        let capvarname = substitute(varname, '^\([a-z]\)', '\U\1\E', 'g')
    endif
    let inpvarname = input('Singular Variable Name? (blank to copy) ')
    if inpvarname == ''
        let inpvarname = varname
    endif
    if s:coding_standard_docblocks == 'y'
        let descr = input("Description? ")
        let capdescr = substitute(descr, '^\([a-z]\)', '\U\1\E', 'g')
        let text = substitute(text, '%description%', descr, 'g')
        let text = substitute(text, '%capdescription%', capdescr, 'g')
        let singdescr = input("Singular Description? (blank to copy)")
        if singdescr == ''
            let singdescr = descr
        endif
        let text = substitute(text, '%singdescription%', singdescr, 'g')
    endif
    let vtype = input('Type? ')
    if vtype == 'string' || vtype == 'int' || vtype == 'array' || vtype == 'bool' || vtype == 'float' || vtype == 'void'
        let text = substitute(text, '%type%', vtype, 'g')
        let text = substitute(text, '%typehint%', '', 'g')
    else
        let text = substitute(text, '%type%', vtype, 'g')
        let text = substitute(text, '%typehint%', vtype . ' ', 'g')
    endif

    let accesslvl = input("Access level? (public/private/protected) ")
    if accesslvl == ""
        let accesslvl = 'private'
    endif
    let text = substitute(text, '%access%', accesslvl, 'g')

    if accesslvl == "private"
        let varname = "_" . varname
    endif

    let text = substitute(text, '%varname%', varname, 'g')
    let text = substitute(text, '%capvarname%', capvarname, 'g')
    let text = substitute(text, '%inpvarname%', inpvarname, 'g')

    let subpackage = s:getSubpackage('n')
    if (s:coding_standard_methodsinceline == 'y')
        let pkgvrsn = s:getVersion()
        let clavrsn = s:getClassVersion()
        if pkgvrsn != clavrsn
            let pkgvrsnline = "\n\t *\n\t * @since " . pkgvrsn
        else
            let pkgvrsnline = ""
        endif
        let text = substitute(text, '%methodversion%', pkgvrsnline, 'g')
    else
        let text = substitute(text, '%methodversion%', '', 'g')
    endif
    let text = substitute(text, '%author%', s:getAuthor(), 'g')

    normal o
    call s:append_text(line('.'), text)
    normal ddj}kk$zx5j
endfunction

"   }}}
"   {{{ InsertPropertyGetSet()

function! InsertPropertyGetSet() range

    let varname = input('Variable Name? ')
    if varname == 'Q'
        return
    endif

    let category = s:getCategory('n')
    let package = s:getPackage('n')

    call s:setStandards()
    let text = s:get_template_propgetset()
    let capvarname = input('Method Variable Name? (blank to capitalize) ')
    if capvarname == ''
        let capvarname = substitute(varname, '^\([a-z]\)', '\U\1\E', 'g')
    endif
    let inpvarname = input('Input Variable Name? (blank to copy) ')
    if inpvarname == ''
        let inpvarname = varname
    endif
    if s:coding_standard_docblocks == 'y'
        let descr = input("Description? ")
        let capdescr = substitute(descr, '^\([a-z]\)', '\U\1\E', 'g')
        let text = substitute(text, '%description%', descr, 'g')
        let text = substitute(text, '%capdescription%', capdescr, 'g')
    endif
    let vtype = input('Type? ')
    if vtype == 'string' || vtype == 'int' || vtype == 'array' || vtype == 'bool' || vtype == 'float' || vtype == 'void'
        let text = substitute(text, '%type%', vtype, 'g')
        let text = substitute(text, '%typehint%', '', 'g')
    else
        let text = substitute(text, '%type%', vtype, 'g')
        let text = substitute(text, '%typehint%', vtype . ' ', 'g')
    endif

    let accesslvl = input("Access level? (public/private/protected) ")
    if accesslvl == ""
        let accesslvl = 'private'
    endif
    let text = substitute(text, '%access%', accesslvl, 'g')

    if s:coding_standard_underscore_prefix == "y"
        if accesslvl == "private" || accesslvl == "protected"
            let varname = "_" . varname
        endif
    endif

    let text = substitute(text, '%varname%', varname, 'g')
    let text = substitute(text, '%capvarname%', capvarname, 'g')
    let text = substitute(text, '%inpvarname%', inpvarname, 'g')

    let subpackage = s:getSubpackage('n')
    if (s:coding_standard_methodsinceline == 'y')
        let pkgvrsn = s:getVersion()
        let clavrsn = s:getClassVersion()
        if pkgvrsn != clavrsn
            let pkgvrsnline = "\n\t *\n\t * @since " . pkgvrsn
        else
            let pkgvrsnline = ""
        endif
        let text = substitute(text, '%methodversion%', pkgvrsnline, 'g')
    else
        let text = substitute(text, '%methodversion%', '', 'g')
    endif
    let text = substitute(text, '%author%', s:getAuthor(), 'g')

    normal o
    call s:append_text(line('.'), text)
    normal ddj}kk$zx5j}}
endfunction

"   }}}
"   {{{ InsertPropertyGetAddClear()

function! InsertPropertyGetAddClear() range

    let inpvarname = input('Singular Variable Name? ')
    if inpvarname == 'Q'
        return
    endif
    let capinpvarname = input('Singular Method Variable Name? (blank to capitalize) ')
    if capinpvarname == ''
        let capinpvarname = substitute(inpvarname, '^\([a-z]\)', '\U\1\E', 'g')
    endif

    let varname = input('Plural Variable Name? (blank to add "s") ')
    if varname == ''
        let varname = inpvarname . 's'
    endif
    let capvarname = input('Plural Method Variable Name? (blank to capitalize) ')
    if capvarname == ''
        let capvarname = substitute(varname, '^\([a-z]\)', '\U\1\E', 'g')
    endif

    let category = s:getCategory('n')
    let package = s:getPackage('n')

    call s:setStandards()
    let text = s:get_template_propgetaddclear()
    if s:coding_standard_docblocks == 'y'
        let descr = input("Plural Description? ")
        let capdescr = substitute(descr, '^\([a-z]\)', '\U\1\E', 'g')
        let text = substitute(text, '%description%', descr, 'g')
        let text = substitute(text, '%capdescription%', capdescr, 'g')
        let singdescr = input("Singular Description? (blank to copy) ")
        if singdescr == ''
            let singdescr = descr
        endif
        let text = substitute(text, '%singdescription%', singdescr, 'g')
    endif
    let vtype = input('Type? ')
    if vtype == 'string' || vtype == 'int' || vtype == 'mixed' || vtype == 'bool' || vtype == 'float' || vtype == 'void'
        let text = substitute(text, '%type%', vtype, 'g')
        let text = substitute(text, '%typehint%', '', 'g')
    else
        let text = substitute(text, '%type%', vtype, 'g')
        let text = substitute(text, '%typehint%', vtype . ' ', 'g')
    endif

    let accesslvl = input("Access level? (public/private/protected) ")
    if accesslvl == ""
        let accesslvl = 'private'
    endif
    let text = substitute(text, '%access%', accesslvl, 'g')

    let inpvarname2 = varname
    if s:coding_standard_underscore_prefix == 'y'
        if accesslvl == "private" || accesslvl == "protected"
            let varname = "_" . varname
        endif
    endif

    let text = substitute(text, '%varname%', varname, 'g')
    let text = substitute(text, '%capvarname%', capvarname, 'g')
    let text = substitute(text, '%inpvarname%', inpvarname, 'g')
    let text = substitute(text, '%inpvarname2%', inpvarname2, 'g')
    let text = substitute(text, '%capinpvarname%', capinpvarname, 'g')

    let subpackage = s:getSubpackage('n')
    if (s:coding_standard_methodsinceline == 'y')
        let pkgvrsn = s:getVersion()
        let clavrsn = s:getClassVersion()
        if pkgvrsn != clavrsn
            let pkgvrsnline = "\n\t *\n\t * @since " . pkgvrsn
        else
            let pkgvrsnline = ""
        endif
        let text = substitute(text, '%methodversion%', pkgvrsnline, 'g')
    else
        let text = substitute(text, '%methodversion%', '', 'g')
    endif
    let text = substitute(text, '%author%', s:getAuthor(), 'g')

    normal o
    call s:append_text(line('.'), text)
    normal ddj}kk$zx5j
endfunction

"   }}}
"   {{{ InsertWhether()

function! InsertWhether() range

    let methodname = input('Method Name? ')
    if methodname == 'Q'
        return
    endif

    let category = s:getCategory('n')
    let package = s:getPackage('n')

    call s:setStandards()
    let text = s:get_template_whether()
    let text = substitute(text, '%method%', methodname, 'g')
    if s:coding_standard_docblocks == 'y'
        let text = s:parameterize_template(text, "Whether...? ", '%whether%', '')
    endif

    let subpackage = s:getSubpackage('n')
    if (s:coding_standard_methodsinceline == 'y')
        let pkgvrsn    = s:getVersion()
        let clavrsn    = s:getClassVersion()
        if pkgvrsn != clavrsn
            let pkgvrsnline = "\n\t *\n\t * @since " . pkgvrsn
        else
            let pkgvrsnline = ""
        endif
        let text = substitute(text, '%methodversion%', pkgvrsnline, 'g')
    else
        let text = substitute(text, '%methodversion%', '', 'g')
    endif
    let text = substitute(text, '%author%', s:getAuthor(), 'g')

    normal o
    call s:append_text(line('.'), text)
    normal ddj}kk$zx
endfunction

"   }}}
"   {{{ InsertProperty()

function! InsertProperty() range

    let varname = input("Variable name? ")
    if varname == 'Q'
        return
    endif

    let category = s:getCategory('n')
    let package = s:getPackage('n')

    call s:setStandards()
    let text = s:get_template_property()
    if s:coding_standard_docblocks == 'y'
        let text = s:parameterize_template(text, "Description? ", '%description%', '')
    endif
    let text = s:parameterize_template(text, "Type? ", '%type%', '')

    let accesslvl = input("Access level? (public/private/protected) ")
    if accesslvl == ""
        let accesslvl = 'private'
    endif
    let text = substitute(text, '%access%', accesslvl, 'g')

    if s:coding_standard_underscore_prefix == "y"
        if accesslvl == "private" || accesslvl == "protected"
            let varname = "_" . varname
        endif
    endif
    let text = substitute(text, '%varname%', varname, 'g')

    if (s:coding_standard_methodsinceline == 'y')
        let pkgvrsn = s:getVersion()
        let clavrsn = s:getClassVersion()
        if pkgvrsn != clavrsn
            let pkgvrsnline = "\n\t *\n\t * @since " . pkgvrsn
        else
            let pkgvrsnline = ""
        endif
        let text = substitute(text, '%propversion%', pkgvrsnline, 'g')
    else
        let text = substitute(text, '%propversion%', '', 'g')
    endif

    normal o
    call s:append_text(line('.'), text)
    normal ddj}kk$zxjj
endfunction

"   }}}
"   {{{ InsertConstant()

function! InsertConstant() range

    let constname = input("Constant name? ")
    if constname == 'Q'
        return
    endif

    let category = s:getCategory('n')
    let package = s:getPackage('n')

    call s:setStandards()
    let text = s:get_template_constant()
    let text = substitute(text, '%constname%', constname, 'g')
    if s:coding_standard_docblocks == 'y'
        let text = s:parameterize_template(text, "Description? ", '%description%', '')
    endif
    let text = s:parameterize_template(text, "Value? ", '%value%', '')

    if (s:coding_standard_methodsinceline == 'y')
        let pkgvrsn = s:getVersion()
        let clavrsn = s:getClassVersion()
        if pkgvrsn != clavrsn
            let pkgvrsnline = "\n\t *\n\t * @since " . pkgvrsn
        else
            let pkgvrsnline = ""
        endif
        let text = substitute(text, '%constversion%', pkgvrsnline, 'g')
    else
        let text = substitute(text, '%constversion%', '', 'g')
    endif

    normal o
    call s:append_text(line('.'), text)
    normal ddj}kk$zxjj
endfunction

"   }}}
"   {{{ InsertTestFile()

function! InsertTestFile() range

    let category = input("Category name? ")
    if category == 'Q'
        return
    endif

    if category == 'EFS2' || category == 'EFS'
        let package = category
    else
        let package = input("Package name? ")
    endif

    call s:setStandards()
    let text = s:get_template_testfile()
    let text = substitute(text, '%category%', category, 'g')
    let text = substitute(text, '%package%', package, 'g')

    if s:coding_standard_docblocks == 'y'
        let subpackage = input('Subpackage name? ')
        let text = substitute(text, '%subpackageline%', s:getDocLine('subpackage', subpackage, ' '), 'g')
    else
        let subpackage = ''
    endif

    let text = substitute(text, '%copyright%', s:getCopyright(), 'g')
    let text = substitute(text, '%license%', s:getLicense(), 'g')
    let text = substitute(text, '%since%', s:getVersion(), 'g')
    let text = substitute(text, '%link%', s:getLink(), 'g')
    let text = substitute(text, '%author%', s:getAuthor(), 'g')

    let text = s:parameterize_template(text, "File? ", '%file%', '')
    let text = s:parameterize_template(text, "Class name? ", '%classname%', '')
    if s:coding_standard_docblocks == 'y'
        let text = s:parameterize_template(text, "Description? ", '%description%', '')
    endif
    call s:append_text(line('.'), text)
    normal dd
    set expandtab tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=marker foldlevel=0
endfunction

"   }}}
"   {{{ InsertTestMethod()

function! InsertTestMethod() range

    let functionname = input("Test name? ")
    if functionname == 'Q'
        return
    endif

    let category = s:getCategory('n')
    let package = s:getPackage('n')

    call s:setStandards()
    let text = s:get_template_testmethod()
    let text = substitute(text, '%function%', functionname, 'g')
    if s:coding_standard_docblocks == 'y'
        let text = s:parameterize_template(text, "Description? ", '%description%', '')
    endif

    let subpackage = s:getSubpackage('n')
    if (s:coding_standard_methodsinceline == 'y')
        let pkgvrsn    = s:getVersion()
        let clavrsn    = s:getClassVersion()
        if pkgvrsn != clavrsn
            let pkgvrsnline = "\n\t *\n\t * @since " . pkgvrsn
        else
            let pkgvrsnline = ""
        endif
        let text = substitute(text, '%methodversion%', pkgvrsnline, 'g')
    else
        let text = substitute(text, '%methodversion%', '', 'g')
    endif
    let text = substitute(text, '%author%', s:getAuthor(), 'g')

    normal o
    call s:append_text(line('.'), text)
    normal ddj}kk$zx
endfunction

"   }}}
" }}}
" {{{ Helper Methods
"   {{{ setStandards()

function! s:setStandards()
    try
        let standards = g:project_info[b:current_project]['coding_standards']
    catch
        let standards = g:project_info['default']['coding_standards']
    endtry

    " Whether to make sure that private/protected varibales start with an
    " underscore
    let s:coding_standard_underscore_prefix  = standards['underscore_prefix']
    " Whether to include docblocks at all
    let s:coding_standard_docblocks          = standards['docblocks']
    " Whether to use tabs rather than spaces
    let s:coding_standard_tabs               = standards['tabs']
    " Whether to add an @author tag on methods
    let s:coding_standard_methodauthorline   = standards['methodauthorline']
    " Whether to add a @since tag on methods
    let s:coding_standard_methodsinceline    = standards['methodsinceline']
    " Whether to use Zend_Loader to load the parent of an extended class
    let s:coding_standard_zendloadclass      = standards['zendloadclass']
    " Whether to use require_once to load the parent of an extended class
    let s:coding_standard_requireclass       = standards['requireclass']
    " Whether to put the brace below the declaration on classes
    let s:coding_standard_classbracebelow    = standards['classbracebelow']
    " Whether to put the brace below the declaration on methods
    let s:coding_standard_methodbracebelow   = standards['methodbracebelow']
    " An array of the order of doc tags for files
    let s:coding_standard_filedocblockorder  = standards['filedocblockorder']
    " An array of the order of doc tags for classes
    let s:coding_standard_classdocblockorder = standards['classdocblockorder']
    " Whether to insert spaces within parens:
    "  n is for method($param) and control($test)
    "  y is for method( $param ) and control ( $test )
    let s:coding_standard_parenspacing       = standards['parenspacing']
    " Doxygen has a bug that makes @param type $varname description fail;
    " use @param $varname description instead
    let s:coding_standard_doxygenworkaround  = standards['doxygenworkaround']
endfunction

"   }}}
"   {{{ parameterize_template()

function! s:parameterize_template(template, prompt, marker, default)
    let filltext = input(a:prompt)
    if filltext == ""
        let filltext = a:default
    endif
    return substitute(a:template, a:marker, filltext, 'g')
endfunction

"   }}}
"   {{{ append_text()

function! s:append_text(pos, text)
    let pos = a:pos
    let string = a:text

    while 1
      let len = stridx(string, "\n")

      if len == -1
        call append(pos, s:indent . string)
        break
      endif

      call append(pos, s:indent . strpart(string, 0, len))

      let pos = pos + 1
      let string = strpart(string, len + 1)

    endwhile
endfunction

"   }}}
"   {{{ to_camel_case()

function! s:to_camel_case(original)
    let camel = a:original
    let camel = substitute(camel, '^\([a-z]\)', '\U\1\E', '')
    let camel = substitute(camel, '_\([a-z]\)', '_\U\1\E', 'g')
    let camel = substitute(camel, '_', '', 'g')
    return camel
endfunction

"   }}}
"   {{{ getCategory()

function! s:getCategory(ask)
    try
        exe "silent mbgg/@category\<CR>wwv$hy`b"
        let category = @"
    catch
        try
            let category = g:project_info[b:current_project]['category']
        catch
            let category = ''
        endtry
    endtry
    if a:ask == 'y' && category == ''
        let category = input("Category name? ")
    endif
    return category
endfunction

"   }}}
"   {{{ getPackage()

function! s:getPackage(ask)
    try
        exe "normal mbgg/@package\<CR>wwv$hy`b"
        let package = @"
    catch
        try
            let package = g:project_info[b:current_project]['package']
        catch
            let package = ''
        endtry
    endtry
    if a:ask == 'y' && package == ''
        let package = input("Package name? ")
    endif
    return package
endfunction

"   }}}
"   {{{ getSubpackage()

function! s:getSubpackage(ask)
    try
        exe "normal mbgg/@subpackage\<CR>wwv$hy`b"
        let subpackage = @"
    catch
        try
            let subpackage = g:project_info[b:current_project]['subpackage']
        catch
            let subpackage = ''
        endtry
    endtry
    if a:ask == 'y'
        if subpackage == ''
            let subpackage = input("Subpackage name? ")
        endif
    endif
    return subpackage
endfunction

"   }}}
"   {{{ getFileVersion()

function! s:getFileVersion()
    try
        exe "normal mbgg/@since\<CR>wwv$hy`b"
        let fileversion = @"
    catch
        let fileversion = ''
    endtry
    return fileversion
endfunction

"   }}}
"   {{{ getClassVersion()

function! s:getClassVersion()
    try
        exe "normal mb?^{\<CR>?@since\<CR>wwv$hy`b"
        let classversion = @"
    catch
        let classversion = ''
    endtry
    return classversion
endfunction

"   }}}
"   {{{ getCopyright()

function! s:getCopyright()
    let cp = g:DetectProject()
    try
        return g:project_info[cp]['copyright']
    catch
        return g:project_info['default']['copyright']
    endtry
endfunction

"   }}}
"   {{{ getVersion()

function! s:getVersion()
    let cp = g:DetectProject()
    try
        let versionnum = g:project_info[cp]['version']
    catch
        let versionnum = g:project_info['default']['version']
    endtry
    if versionnum == 'DATE'
        let versionnum = strftime('%Y-%m-%d')
    endif
    return versionnum
endfunction

"   }}}
"   {{{ getAuthor()

function! s:getAuthor()
    let cp = g:DetectProject()
    try
        return g:project_info[cp]['author']
    catch
        return g:project_info['default']['author']
    endtry
endfunction

"   }}}
"   {{{ getLicense()

function! s:getLicense()
    let cp = g:DetectProject()
    try
        return g:project_info[cp]['license']
    catch
        return g:project_info['default']['license']
    endtry
endfunction

"   }}}
"   {{{ getLink()

function! s:getLink()
    let cp = g:DetectProject()
    try
        return g:project_info[cp]['link']
    catch
        return g:project_info['default']['link']
    endtry
endfunction

"   }}}
"   {{{ getDocLine()

function! s:getDocLine(doctag, docvalue, docspaces)
    if a:doctag == 'copyright'
        let spacer = '  '
    else
        let spacer = ' '
    endif
    if a:docvalue == ''
        let docline = ''
    else
        let docline = "\n" . a:docspaces . "* @" . a:doctag . spacer . a:docvalue
    endif
    return docline
endfunction

"   }}}
"   {{{ buildDocBlockTemplate()

function! s:buildDocBlockTemplate(taglist)
    let template = ''
    for tagname in (a:taglist)
        if tagname == 'version'
            let tagvalue = '$Id$'
        elseif tagname == 'package'
            let tagvalue = '%package%%subpackageline%'
        else
            let tagvalue = '%' . tagname . '%'
        endif
        let tagspacing = repeat(' ', 10 - strlen(tagname)) . ' '
        let template = template . " * @" . tagname . tagspacing . tagvalue . "\n"
    endfor
    return template
endfunction

"   }}}
" }}}
" {{{ Templates
"   {{{ File

function! s:get_template_file()
    if s:coding_standard_docblocks == 'n'
        let template = "<?php\n"
    else
        let template =
            \ "<?php\n" .
            \ "/**\n" .
            \ " * %description%\n" .
            \ " *\n" .
            \ s:buildDocBlockTemplate(s:coding_standard_filedocblockorder) .
            \ " */\n"
    endif
    if s:coding_standard_tabs == 'y'
        return template
    else
        return substitute(template, "\t", "    ", 'g')
    endif
endfunction

"   }}}
"   {{{ Function

function! s:get_template_function()
    if s:coding_standard_docblocks == 'y'
        let template =
            \ "/**\n" .
            \ " * %description%%funcversion%\n" .
            \ " *%paramsline%%returnline%\n"
        if s:coding_standard_methodauthorline == 'y'
            let template = template .
                \ " * @author %author%\n"
        endif
        let template = template .
            \ " */\n"
    endif
    if s:coding_standard_parenspacing == 'y'
        let template = template .
            \ "function %function%( %paramsdec% ) {\n"
    else
        let template = template .
            \ "function %function%(%paramsdec%) {\n"
    endif
    let template = template .
        \ "}\n"
    if s:coding_standard_tabs == 'y'
        return template
    else
        return substitute(template, "\t", "    ", 'g')
    endif
endfunction

"   }}}
"   {{{ Class File

function! s:get_template_class()
    if s:coding_standard_docblocks == 'n'
        let template =
            \ "<?php\n" .
            \ "\n" .
            \ "class %classname%"
        if s:coding_standard_classbracebelow == 'y'
            let template = template . "\n{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \ "\n" .
            \ "\tpublic function __construct()"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \ "\t}\n" .
            \ "\n" .
            \ "}\n"
    else
        let template =
            \ "<?php\n" .
            \ "/**\n" .
            \ " * %classname% class\n" .
            \ " *\n" .
            \ s:buildDocBlockTemplate(s:coding_standard_filedocblockorder) .
            \ " */\n" .
            \ "\n" .
            \ "/**\n" .
            \ " * %description%\n" .
            \ " *\n" .
            \ s:buildDocBlockTemplate(s:coding_standard_classdocblockorder) .
            \ " */\n" .
            \ "class %classname%"
        if s:coding_standard_classbracebelow == 'y'
            let template = template . "\n{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \ "\n" .
            \ "\t/**\n" .
            \ "\t * Constructor\n"
        if s:coding_standard_methodauthorline == 'y'
            let template = template .
                \ "\t *\n" .
                \ "\t * @author %author%\n"
        endif
        let template = template .
            \ "\t */\n" .
            \ "\tpublic function __construct()"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \ "\t}\n" .
            \ "\n" .
            \ "}\n"
    endif
    if s:coding_standard_tabs == 'y'
        return template
    else
        return substitute(template, "\t", "    ", 'g')
    endif
endfunction

"   }}}
"   {{{ Extended Class File

function! s:get_template_extclass()
    if s:coding_standard_docblocks == 'n'
        let template =
            \ "<?php\n" .
            \ "\n" .
        if s:coding_standard_requireclass == 'y'
            let template = template .
                \ "require_once '%parentfile%';\n" .
                \ "\n"
        elseif s:coding_standard_zendloadclass == 'y'
            let template = template .
                \ "Zend_Loader::loadClass(" .
            if s:coding_standard_parenspacing == 'y'
                let template = template . " '%parentclass%' "
            else
                let template = template . "'%parentclass%'"
            endif
            let template = template . ");\n" .
                \ "\n"
        endif
        let template = template .
            \ "class %classname% extends %parentclass%"
        if s:coding_standard_classbracebelow == 'y'
            let template = template . "\n{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \ "\n" .
            \ "\tpublic function __construct()"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \ "\t\tparent::__construct();\n" .
            \ "\t}\n" .
            \ "\n" .
            \ "}\n"
    else
        let template =
            \ "<?php\n" .
            \ "/**\n" .
            \ " * %classname% class\n" .
            \ " *\n" .
            \ s:buildDocBlockTemplate(s:coding_standard_filedocblockorder) .
            \ " */\n" .
            \ "\n"
        if s:coding_standard_requireclass == 'y'
            let template = template .
                \ "\/** @see %parentclass% **/\n" .
                \ "require_once '%parentfile%';\n" .
                \ "\n"
        elseif s:coding_standard_zendloadclass == 'y'
            let template = template .
                \ "\/** @see %parentclass% **/\n" .
                \ "Zend_Loader::loadClass('%parentclass%');\n" .
                \ "\n"
        endif
        let template = template .
            \ "/**\n" .
            \ " * %description%\n" .
            \ " *\n" .
            \ s:buildDocBlockTemplate(s:coding_standard_classdocblockorder) .
            \ " */\n" .
            \ "class %classname% extends %parentclass%"
    if s:coding_standard_classbracebelow == 'y'
        let template = template . "\n{\n"
    else
        let template = template . " {\n"
    endif
    let template = template .
            \ "\n" .
            \ "\t/**\n" .
            \ "\t * Constructor\n"
        if s:coding_standard_methodauthorline == 'y'
            let template = template .
                \ "\t *\n" .
                \ "\t * @author %author%\n"
        endif
        let template = template .
            \ "\t */\n" .
            \ "\tpublic function __construct()"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \ "\t\tparent::__construct();\n" .
            \ "\t}\n" .
            \ "\n" .
            \ "}\n"
    endif
    if s:coding_standard_tabs == 'y'
        return template
    else
        return substitute(template, "\t", "    ", 'g')
    endif
endfunction

"   }}}
"   {{{ Class not in a new file

function! s:get_template_subclass()
    if s:coding_standard_docblocks == 'n'
        let template =
            \ "class %classname%"
        if s:coding_standard_classbracebelow == 'y'
            let template = template . "\n{\n"
        else
            let template = template . " {\n"
        endif
        let template = template . "}\n"
    else
        let template =
            \ "/**\n" .
            \ " * %description%\n" .
            \ " *\n" .
            \ s:buildDocBlockTemplate(s:coding_standard_classdocblockorder) .
            \ " */\n" .
            \ "class %classname%"
        if s:coding_standard_classbracebelow == 'y'
            let template = template . "\n{\n"
        else
            let template = template . " {\n"
        endif
        let template = template . "}\n"
    endif
    if s:coding_standard_tabs == 'y'
        return template
    else
        return substitute(template, "\t", "    ", 'g')
    endif
endfunction

"   }}}
"   {{{ Method

function! s:get_template_method()
    if s:coding_standard_docblocks == 'y'
        let template =
            \ "\t/**\n" .
            \ "\t * %description%%methodversion%\n" .
            \ "\t *%paramsline%%returnline%\n"
        if s:coding_standard_methodauthorline == 'y'
            let template = template .
                \ "\t * @author %author%\n"
        endif
        let template = template .
            \ "\t */\n"
    endif
    let template = template .
        \ "\t%abstract%%access%%static% function %function%("
    if s:coding_standard_parenspacing == 'y'
        let template = template . " %paramsdec% "
    else
        let template = template . "%paramsdec%"
    endif
    let template = template . ")%declarestyle%\n"
    if s:coding_standard_tabs == 'y'
        return template
    else
        return substitute(template, "\t", "    ", 'g')
    endif
endfunction

"   }}}
"   {{{ Get and Set Methods

function! s:get_template_getset()
    if s:coding_standard_docblocks == 'n'
        let template =
            \ "\tpublic function get%capvarname%()"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \ "\t\treturn $this->%varname%;\n" .
            \ "\t}\n" .
            \ "\t\n"
        if s:coding_standard_parenspacing == 'y'
            let template = template .
                \ "\tpublic function set%capvarname%( %typehint%$%inpvarname% )"
        else
            let template = template .
                \ "\tpublic function set%capvarname%(%typehint%$%inpvarname%)"
        endif
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \ "\t\t$this->%varname% = $%inpvarname%;\n" .
            \ "\t}\n"
    else
        let template =
            \ "\t/**\n" .
            \ "\t * Gets %description%%methodversion%\n" .
            \ "\t *\n" .
            \ "\t * @return %type% %description%\n"
        if s:coding_standard_methodauthorline == 'y'
            let template = template .
                \ "\t * @author %author%\n"
        endif
        let template = template .
            \ "\t */\n" .
            \ "\tpublic function get%capvarname%()"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \ "\t\treturn $this->%varname%;\n" .
            \ "\t}\n" .
            \ "\t\n" .
            \ "\t/**\n" .
            \ "\t * Sets %description%%methodversion%\n" .
            \ "\t *\n"
        if s:coding_standard_doxygenworkaround == 'y'
            let template = template .
                \ "\t * @param $%inpvarname% %type% %description%\n"
        else
            let template = template .
                \ "\t * @param %type% $%inpvarname% %description%\n"
        endif
        if s:coding_standard_methodauthorline == 'y'
            let template = template .
                \ "\t * @author %author%\n"
        endif
        let template = template .
            \ "\t */\n"
        if s:coding_standard_parenspacing == 'y'
            let template = template .
                \ "\tpublic function set%capvarname%( %typehint%$%inpvarname% )"
        else
            let template = template .
                \ "\tpublic function set%capvarname%(%typehint%$%inpvarname%)"
        endif
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \ "\t\t$this->%varname% = $%inpvarname%;\n" .
            \ "\t}\n"
    endif
    if s:coding_standard_tabs == 'y'
        return template
    else
        return substitute(template, "\t", "    ", 'g')
    endif
endfunction

"   }}}
"   {{{ Get, Add, and Clear Methods

function! s:get_template_getaddclear()
    if s:coding_standard_docblocks == 'n'
        let template =
            \ "\tpublic function get%capvarname%() {\n" .
            \ "\t\treturn $this->%varname%;\n" .
            \ "\t}\n" .
            \ "\n" .
            \ "\tpublic function add%capvarname%(%typehint%$%inpvarname%)"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        if s:coding_standard_parenspacing == 'y'
            let template = template .
                \ "\t\tif ( !is_array( $this->%varname% ) ) {\n" .
        else
            let template = template .
                \ "\t\tif (!is_array($this->%varname%)) {\n" .
        endif
        let template = template .
            \ "\t\t\t$this->%varname% = array();\n" .
            \ "\t\t}\n" .
            \ "\t\t$this->%varname%[] = $%inpvarname%;\n" .
            \ "\t}\n" .
            \ "\n" .
            \ "\tpublic function clear%capvarname%()"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \ "\t\t$this->%varname% = array();\n" .
            \ "\t}\n" .
            \ "\n"
    else
        let template =
            \ "\t/**\n" .
            \ "\t * Gets %description%%methodversion%\n" .
            \ "\t *\n" .
            \ "\t * @return array %description%\n"
        if s:coding_standard_methodauthorline == 'y'
            let template = template .
                \ "\t * @author %author%\n"
        endif
        let template = template .
            \ "\t */\n" .
            \ "\tpublic function get%capvarname%()"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \ "\t\treturn $this->%varname%;\n" .
            \ "\t}\n" .
            \ "\n" .
            \ "\t/**\n" .
            \ "\t * Adds %singdescription%%methodversion%\n" .
            \ "\t *\n"
        if s:coding_standard_doxygenworkaround == 'y'
            let template = template .
                \ "\t * @param $%inpvarname% %type% %singdescription%\n"
        else
            let template = template .
                \ "\t * @param %type% $%inpvarname% %singdescription%\n"
        endif
        if s:coding_standard_methodauthorline == 'y'
            let template = template .
                \ "\t * @author %author%\n"
        endif
        let template = template .
            \ "\t */\n"
        if s:coding_standard_parenspacing == 'y'
            let template = template .
                \ "\tpublic function add%capvarname%( %typehint%$%inpvarname% )"
        else
            let template = template .
                \ "\tpublic function add%capvarname%(%typehint%$%inpvarname%)"
        endif
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        if s:coding_standard_parenspacing == 'y'
            let template = template .
                \ "\t\tif ( !is_array( $this->%varname% ) ) {\n" .
        else
            let template = template .
                \ "\t\tif (!is_array($this->%varname%)) {\n" .
        endif
        let template = template .
            \ "\t\t\t$this->%varname% = array();\n" .
            \ "\t\t}\n" .
            \ "\t\t$this->%varname%[] = $%inpvarname%;\n" .
            \ "\t}\n" .
            \ "\n" .
            \ "\t/**\n" .
            \ "\t * Clears %description%%methodversion%\n"
        if s:coding_standard_methodauthorline == 'y'
            let template = template .
                \ "\t *\n" .
                \ "\t * @author %author%\n"
        endif
        let template = template .
            \ "\t */\n" .
            \ "\tpublic function clear%capvarname%()"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \ "\t\t$this->%varname% = array();\n" .
            \ "\t}\n" .
            \ "\n"
    endif
    if s:coding_standard_tabs == 'y'
        return template
    else
        return substitute(template, "\t", "    ", 'g')
    endif
endfunction

"   }}}
"   {{{ Property

function! s:get_template_property()
    if s:coding_standard_docblocks == 'n'
        let template = "\t%access% $%varname%;\n"
    else
        let template =
            \ "\t/**\n" .
            \ "\t * %description%%propversion%\n" .
            \ "\t *\n" .
            \ "\t * @var %type%\n" .
            \ "\t */\n" .
            \ "\t%access% $%varname%;\n"
    endif
    if s:coding_standard_tabs == 'y'
        return template
    else
        return substitute(template, "\t", "    ", 'g')
    endif
endfunction

"   }}}
"   {{{ Property + Get and Set Methods

function! s:get_template_propgetset()
    if s:coding_standard_docblocks == 'n'
        let template =
            \ "\t%access% $%varname%;\n" .
            \ "\n" .
            \ "\tpublic function get%capvarname%()"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \ "\t\treturn $this->%varname%;\n" .
            \ "\t}\n" .
            \ "\n"
        if s:coding_standard_parenspacing == 'y'
            let template = template .
                \ "\tpublic function set%capvarname%( %typehint%$%inpvarname% )"
        else
            let template = template .
                \ "\tpublic function set%capvarname%(%typehint%$%inpvarname%)"
        endif
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \ "\t\t$this->%varname% = $%inpvarname%;\n" .
            \ "\t}\n"
    else
        let template =
            \ "\t/**\n" .
            \ "\t * %capdescription%%methodversion%\n" .
            \ "\t *\n" .
            \ "\t * @var %type%\n" .
            \ "\t */\n" .
            \ "\t%access% $%varname%;\n" .
            \ "\n" .
            \ "\t/**\n" .
            \ "\t * Gets %description%%methodversion%\n" .
            \ "\t *\n" .
            \ "\t * @return %type% %description%\n"
        if s:coding_standard_methodauthorline == 'y'
            let template = template .
                \ "\t * @author %author%\n"
        endif
        let template = template .
            \ "\t */\n" .
            \ "\tpublic function get%capvarname%()"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \ "\t\treturn $this->%varname%;\n" .
            \ "\t}\n" .
            \ "\n" .
            \ "\t/**\n" .
            \ "\t * Sets %description%%methodversion%\n" .
            \ "\t *\n"
        if s:coding_standard_doxygenworkaround == 'y'
            let template = template .
                \ "\t * @param $%inpvarname% %type% %description%\n"
        else
            let template = template .
                \ "\t * @param  %type% $%inpvarname% %description%\n"
        endif
        if s:coding_standard_methodauthorline == 'y'
            let template = template .
                \ "\t * @author %author%\n"
        endif
        let template = template .
            \ "\t */\n"
        if s:coding_standard_parenspacing == 'y'
            let template = template .
                \ "\tpublic function set%capvarname%( %typehint%$%inpvarname% )"
        else
            let template = template .
                \ "\tpublic function set%capvarname%(%typehint%$%inpvarname%)"
        endif
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \ "\t\t$this->%varname% = $%inpvarname%;\n" .
            \ "\t}\n"
    endif
    if s:coding_standard_tabs == 'y'
        return template
    else
        return substitute(template, "\t", "    ", 'g')
    endif
endfunction

"   }}}
"   {{{ Property + Get, Add, and Clear Methods

function! s:get_template_propgetaddclear()
    if s:coding_standard_docblocks == 'n'
        let template =
            \ "\t%access% $%varname%;\n" .
            \ "\n" .
            \ "\tpublic function get%capvarname%() {\n"
        if s:coding_standard_parenspacing == 'y'
            let template = template .
                \ "\t\tif ( !is_array( $this->%varname% ) ) {\n"
        else
            let template = template .
                \ "\t\tif (!is_array($this->%varname%)) {\n"
        endif
        let template = template .
            \ "\t\t\t$this->%varname% = array();\n" .
            \ "\t\t}\n" .
            \ "\t\treturn $this->%varname%;\n" .
            \ "\t}\n" .
            \ "\n"
        if s:coding_standard_parenspacing == 'y'
            let template = template .
                \ "\tpublic function set%capvarname%( array $%inpvarname2% )"
        else
            let template = template .
                \ "\tpublic function set%capvarname%(array $%inpvarname2%)"
        endif
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \ "\t\t$this->%varname% = $%inpvarname2%;\n" .
            \ "\t}\n" .
            \ "\n"
        if s:coding_standard_parenspacing == 'y'
            let template = template .
                \ "\tpublic function add%capinpvarname%( %typehint%$%inpvarname% )"
        else
            let template = template .
                \ "\tpublic function add%capinpvarname%(%typehint%$%inpvarname%)"
        endif
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        if s:coding_standard_parenspacing == 'y'
            let template = template .
                \ "\t\tif ( !is_array( $this->%varname% ) ) {\n"
        else
            let template = template .
                \ "\t\tif (!is_array($this->%varname%)) {\n"
        endif
        let template = template .
            \ "\t\t\t$this->%varname% = array();\n" .
            \ "\t\t}\n" .
            \ "\t\t$this->%varname%[] = $%inpvarname%;\n" .
            \ "\t}\n" .
            \ "\n" .
            \ "\tpublic function clear%capvarname%()"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \ "\t\t$this->%varname% = array();\n" .
            \ "\t}\n"
    else
        let template =
            \ "\t/**\n" .
            \ "\t * %capdescription%%methodversion%\n" .
            \ "\t *\n" .
            \ "\t * @var array\n" .
            \ "\t */\n" .
            \ "\t%access% $%varname%;\n" .
            \ "\n" .
            \ "\t/**\n" .
            \ "\t * Gets %description%%methodversion%\n" .
            \ "\t *\n" .
            \ "\t * @return array %description%\n"
        if s:coding_standard_methodauthorline == 'y'
            let template = template .
                \ "\t * @author %author%\n"
        endif
        let template = template .
            \ "\t */\n" .
            \ "\tpublic function get%capvarname%()"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        if s:coding_standard_parenspacing == 'y'
            let template = template .
                \ "\t\tif ( !is_array( $this->%varname% ) ) {\n"
        else
            let template = template .
                \ "\t\tif (!is_array($this->%varname%)) {\n"
        endif
        let template = template .
            \ "\t\t\t$this->%varname% = array();\n" .
            \ "\t\t}\n" .
            \ "\t\treturn $this->%varname%;\n" .
            \ "\t}\n" .
            \ "\n" .
            \ "\t/**\n" .
            \ "\t * Sets %description%%methodversion%\n" .
            \ "\t *\n"
        if s:coding_standard_doxygenworkaround == 'y'
            let template = template .
                \ "\t * @param $%varname% %type% %description%\n"
        else
            let template = template .
                \ "\t * @param array $%varname% %description%\n"
        endif
        if s:coding_standard_methodauthorline == 'y'
            let template = template .
                \ "\t * @author %author%\n"
        endif
        let template = template .
            \ "\t */\n"
        if s:coding_standard_parenspacing == 'y'
            let template = template .
                \ "\tpublic function set%capvarname%( array $%inpvarname2% )"
        else
            let template = template .
                \ "\tpublic function set%capvarname%(array $%inpvarname2%)"
        endif
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \ "\t\t$this->%varname% = $%inpvarname2%;\n" .
            \ "\t}\n" .
            \ "\n" .
            \ "\t/**\n" .
            \ "\t * Adds %singdescription%%methodversion%\n" .
            \ "\t *\n"
        if s:coding_standard_doxygenworkaround == 'y'
            let template = template .
                \ "\t * @param $%inpvarname% %type% %singdescription%\n"
        else
            let template = template .
                \ "\t * @param %type% $%inpvarname% %singdescription%\n"
        endif
        if s:coding_standard_methodauthorline == 'y'
            let template = template .
                \ "\t * @author %author%\n"
        endif
        let template = template .
            \ "\t */\n"
        if s:coding_standard_parenspacing == 'y'
            let template = template .
                \ "\tpublic function add%capinpvarname%( %typehint%$%inpvarname% )"
        else
            let template = template .
                \ "\tpublic function add%capinpvarname%(%typehint%$%inpvarname%)"
        endif
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        if s:coding_standard_parenspacing == 'y'
            let template = template .
                \ "\t\tif (!is_array($this->%varname%)) {\n"
        else
            let template = template .
                \ "\t\tif ( !is_array( $this->%varname% ) ) {\n"
        endif
        let template = template .
            \ "\t\t\t$this->%varname% = array();\n" .
            \ "\t\t}\n" .
            \ "\t\t$this->%varname%[] = $%inpvarname%;\n" .
            \ "\t}\n" .
            \ "\n" .
            \ "\t/**\n" .
            \ "\t * Clears %description%%methodversion%\n"
        if s:coding_standard_methodauthorline == 'y'
            let template = template .
                \ "\t *\n" .
                \ "\t * @author %author%\n"
        endif
        let template = template .
            \ "\t */\n" .
            \ "\tpublic function clear%capvarname%()"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \ "\t\t$this->%varname% = array();\n" .
            \ "\t}\n"
    endif
    if s:coding_standard_tabs == 'y'
        return template
    else
        return substitute(template, "\t", "    ", 'g')
    endif
endfunction

"   }}}
"   {{{ Constant

function! s:get_template_constant()
    if s:coding_standard_docblocks == 'n'
        let template = "\tconst %constname% = %value%;\n"
    else
        let template =
            \ "\t/**\n" .
            \ "\t * %description%%constversion%\n" .
            \ "\t */\n" .
            \ "\tconst %constname% = %value%;\n"
    endif
    if s:coding_standard_tabs == 'y'
        return template
    else
        return substitute(template, "\t", "    ", 'g')
    endif
endfunction

"   }}}
"   {{{ Test File

function! s:get_template_testfile()
    if s:coding_standard_docblocks == 'n'
        let template =
            \"<?php\n" .
            \"\n" .
            \"// Call %classname%_Test::main() if this source file is executed directly.\n"
        if s:coding_standard_parenspacing == 'y'
            let template = template .
                \"if ( !defined( 'PHPUNIT_MAIN_METHOD' ) ) {\n" .
                \"    define( 'PHPUNIT_MAIN_METHOD', '%classname%_Test::main' );\n"
        else
            let template = template .
                \"if (!defined('PHPUNIT_MAIN_METHOD')) {\n" .
                \"    define('PHPUNIT_MAIN_METHOD', '%classname%_Test::main');\n"
        endif
        let template = template .
            \"}\n" .
            \"\n" .
            \"require_once 'PHPUnit/Framework/TestCase.php';\n" .
            \"require_once 'PHPUnit/Framework/TestSuite.php';\n" .
            \"require_once 'PHPUnit/Framework/IncompleteTestError.php';\n" .
            \"\n" .
            \"require_once '%file%';\n" .
            \"\n" .
            \"class %classname%_Test extends PHPUnit_Framework_TestCase"
        if s:coding_standard_classbracebelow == 'y'
            let template = template . "\n{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \"\tpublic static function main()"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \"\t\trequire_once 'PHPUnit/TextUI/TestRunner.php';\n"
        if s:coding_standard_parenspacing == 'y'
            let template = template .
                \"\t\t$suite  = new PHPUnit_Framework_TestSuite( '%classname%_Test' );\n" .
                \"\t\t$result = PHPUnit_TextUI_TestRunner::run( $suite );\n"
        else
            let template = template .
                \"\t\t$suite  = new PHPUnit_Framework_TestSuite('%classname%_Test');\n" .
                \"\t\t$result = PHPUnit_TextUI_TestRunner::run($suite);\n"
        endif
        let template = template .
            \"\t}\n" .
            \"\n" .
            \"\tprotected function setUp()"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \"\t}\n" .
            \"\n" .
            \"\tprotected function tearDown()"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \"\t}\n" .
            \"}\n" .
            \"\n" .
            \"// Call %classname%_Test::main() if this source file is executed directly.\n"
        if s:coding_standard_parenspacing == 'y'
            let template = template .
                \"if ( PHPUNIT_MAIN_METHOD == '%classname%_Test::main' ) {\n" .
        else
            let template = template .
                \"if (PHPUNIT_MAIN_METHOD == '%classname%_Test::main') {\n" .
        endif
        let template = template .
            \"\t%classname%_Test::main();\n" .
            \"}\n" .
            \"\n"
    else
        let template =
            \"<?php\n" .
            \"/**\n" .
            \" * Tests %description%\n" .
            \" *\n" .
            \ s:buildDocBlockTemplate(s:coding_standard_filedocblockorder) .
            \" */\n" .
            \"\n" .
            \"// {{{ configuration\n" .
            \"\n" .
            \"// Call %classname%_Test::main() if this source file is executed directly.\n"
        if s:coding_standard_parenspacing == 'y'
            let template = template .
                \"if ( !defined( 'PHPUNIT_MAIN_METHOD' ) ) {\n" .
                \"    define( 'PHPUNIT_MAIN_METHOD', '%classname%_Test::main' );\n"
        else
            let template = template .
                \"if (!defined('PHPUNIT_MAIN_METHOD')) {\n" .
                \"    define('PHPUNIT_MAIN_METHOD', '%classname%_Test::main');\n"
        endif
        let template = template .
            \"}\n" .
            \"\n" .
            \"/**\n" .
            \" * Requires PHP Unit files\n" .
            \" */\n" .
            \"require_once 'PHPUnit/Framework/TestCase.php';\n" .
            \"require_once 'PHPUnit/Framework/TestSuite.php';\n" .
            \"require_once 'PHPUnit/Framework/IncompleteTestError.php';\n" .
            \"\n" .
            \"/**\n" .
            \" * Requires %description%\n" .
            \" */\n" .
            \"require_once '%file%';\n" .
            \"\n" .
            \"// }}}\n" .
            \"// {{{ %classname%_Test\n" .
            \"\n" .
            \"/**\n" .
            \" * Tests %description%\n" .
            \" *\n" .
            \ s:buildDocBlockTemplate(s:coding_standard_classdocblockorder) .
            \" */\n" .
            \"class %classname%_Test extends PHPUnit_Framework_TestCase"
        if s:coding_standard_classbracebelow == 'y'
            let template = template . "\n{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \"\t/**\n" .
            \"\t * Runs the test methods of this class.\n"
        if s:coding_standard_methodauthorline == 'y'
            let template = template .
                \ "\n"
                \ "\t * @author %author%\n"
        endif
        let template = template .
            \"\t */\n" .
            \"\tpublic static function main()"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \"\t\trequire_once 'PHPUnit/TextUI/TestRunner.php';\n"
        if s:coding_standard_parenspacing == 'y'
            let template = template .
                \"\t\t$suite  = new PHPUnit_Framework_TestSuite( '%classname%_Test' );\n" .
                \"\t\t$result = PHPUnit_TextUI_TestRunner::run( $suite );\n"
        else
            let template = template .
                \"\t\t$suite  = new PHPUnit_Framework_TestSuite('%classname%_Test');\n" .
                \"\t\t$result = PHPUnit_TextUI_TestRunner::run($suite);\n"
        endif
        let template = template .
            \"\t}\n" .
            \"\n" .
            \"\t/**\n" .
            \"\t * Sets up the fixture.\n"
        if s:coding_standard_methodauthorline == 'y'
            let template = template .
                \ "\n"
                \ "\t * @author %author%\n"
        endif
        let template = template .
            \"\t */\n" .
            \"\tprotected function setUp()"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \"\t}\n" .
            \"\n" .
            \"\t/**\n" .
            \"\t * Tears down the fixture.\n"
        if s:coding_standard_methodauthorline == 'y'
            let template = template .
                \ "\n"
                \ "\t * @author %author%\n"
        endif
        let template = template .
            \"\t */\n" .
            \"\tprotected function tearDown()"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \"\t}\n" .
            \"}\n" .
            \"\n" .
            \"// }}}\n" .
            \"// {{{ run the test\n" .
            \"\n" .
            \"// Call %classname%_Test::main() if this source file is executed directly.\n"
        if s:coding_standard_parenspacing == 'y'
            let template = template . "if ( PHPUNIT_MAIN_METHOD == '%classname%_Test::main' ) {\n"
        else
            let template = template . "if (PHPUNIT_MAIN_METHOD == '%classname%_Test::main') {\n"
        endif
        let template = template .
            \"\t%classname%_Test::main();\n" .
            \"}\n" .
            \"\n" .
            \"// }}}\n"
    endif
    if s:coding_standard_tabs == 'y'
        return template
    else
        return substitute(template, "\t", "    ", 'g')
    endif
endfunction

"   }}}
"   {{{ Test Method

function! s:get_template_testmethod()
    if s:coding_standard_docblocks == 'n'
        let template =
            \"\tpublic function test%function%()"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \"\t\tthrow new PHPUnit_Framework_IncompleteTestError;\n" .
            \"\t}\n"
    else
        let template =
            \"\t/**\n" .
            \"\t * %description%%methodversion%\n"
        if s:coding_standard_methodauthorline == 'y'
            let template = template .
                \ "\t * @author %author%\n"
        endif
        let template = template .
            \"\t */\n" .
            \"\tpublic function test%function%()"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \"\t\tthrow new PHPUnit_Framework_IncompleteTestError;\n" .
            \"\t}\n"
    endif
    if s:coding_standard_tabs == 'y'
        return template
    else
        return substitute(template, "\t", "    ", 'g')
    endif
endfunction

"   }}}
"   {{{ Whether Method

function! s:get_template_whether()
    if s:coding_standard_docblocks == 'n'
        let template =
            \"\tpublic function %method%() {\n" .
            \"\t}\n"
    else
        let template =
            \"\t/**\n" .
            \"\t * Returns whether %whether%%methodversion%\n" .
            \"\t *\n" .
            \"\t * @return bool whether %whether%\n"
        if s:coding_standard_methodauthorline == 'y'
            let template = template .
                \ "\t * @author %author%\n"
        endif
        let template = template .
            \"\t */\n" .
            \"\tpublic function %method%()"
        if s:coding_standard_methodbracebelow == 'y'
            let template = template . "\n\t{\n"
        else
            let template = template . " {\n"
        endif
        let template = template .
            \"\t}\n"
    endif
    if s:coding_standard_tabs == 'y'
        return template
    else
        return substitute(template, "\t", "    ", 'g')
    endif
endfunction

"   }}}
" }}}

