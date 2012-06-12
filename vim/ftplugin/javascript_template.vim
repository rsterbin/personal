" Vim filetype plugin file for code templates for Protoype development. The
" code is formatted according to house coding standards.
"
" The provided templates are:
"  - Blank file
"  - Function
"  - Class file
"  - Class (file header and footer removed)
"  - Extended class
"  - Method
"  - Get and set methods
"  - Property + get and set methods
"  - Property + get, add, and clear methods
"  - 'Whether' method
"  - Property
"
" {{{ config

if exists("b:did_jsclass_plugin")
  finish
endif
let b:did_jsclass_plugin = 1

" Mappings
nnoremap <leader>fi  :call InsertFile()<CR>
nnoremap <leader>fu  :call InsertFunction()<CR>
nnoremap <leader>cl  :call InsertClass()<CR>
nnoremap <leader>sc  :call InsertSubclass()<CR>
nnoremap <leader>ec  :call InsertExtendedClass()<CR>
nnoremap <leader>me  :call InsertMethod()<CR>
nnoremap <leader>gs  :call InsertGetSet()<CR>
nnoremap <leader>pgs :call InsertPropertyGetSet()<CR>
nnoremap <leader>pac :call InsertPropertyGetAddClear()<CR>
nnoremap <leader>wh  :call InsertWhether()<CR>
nnoremap <leader>pr  :call InsertProperty()<CR>

" Make sure we are in vim mode
let s:save_cpo = &cpo
set cpo&vim
let s:indent = ''

" }}}
" {{{ Insert Methods
"   {{{ InsertFile()

function! InsertFile() range

    let text = s:jstemplate_file

    let package = input("Package name? ")
    if package == 'Q'
        return
    endif
    let text = substitute(text, '%package%', package, 'g')

    let subpackage = input('Subpackage name? ')
    let text = substitute(text, '%subpackageline%', s:getDocLine('subpackage', subpackage, ' '), 'g')

    let text = substitute(text, '%copyright%', s:getCopyright(package, subpackage), 'g')
    let text = substitute(text, '%license%', s:getLicense(package, subpackage), 'g')
    let text = substitute(text, '%version%', s:getVersion(package, subpackage, 'n'), 'g')
    let text = substitute(text, '%link%', s:getLink(package, subpackage), 'g')
    let text = substitute(text, '%author%', s:getAuthor(package, subpackage), 'g')

    let text = s:parameterize_template(text, "Description? ", '%description%', '')
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

    let text = s:jstemplate_function

    let text = substitute(text, '%function%', functionname, 'g')
    let text = s:parameterize_template(text, "Description? ", '%description%', '')

    let paramstemplate = "\n * @param  %type% $%name% %desc%"
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
        let paramdesc = input('Description? ')
        let paramdefault = input('Default? ')
        if paramdefault != ''
            let paramname = paramname . ' = ' . paramdefault
            let paramdesc = '[optional] ' . paramdesc
        endif
        let thisparams = substitute(thisparams, '%desc%', paramdesc, 'g')
        if paramsdec == ''
            let paramsdec = '$' . paramname
        else
            let paramsdec = paramsdec . ', $' . paramname
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
        let returntemplate = substitute(returntemplate, '%desc%', input('Description? '), 'g')
        let returnline = returntemplate
    endif
    let text = substitute(text, '%returnline%', returnline, 'g')

    let package    = s:getPackage('n')
    let subpackage = s:getSubpackage('n')
    let pkgvrsn    = s:getVersion(package, subpackage, 'n')
    let filvrsn    = s:getFileVersion()
    if pkgvrsn != filvrsn
        let pkgvrsnline = "\n *\n * @since " . pkgvrsn
    else
        let pkgvrsnline = ""
    endif
    let text = substitute(text, '%funcversion%', pkgvrsnline, 'g')
    let text = substitute(text, '%author%', s:getAuthor(package, subpackage), 'g')

    normal o
    call s:append_text(line('.'), text)
    normal ddj}kk$zx
endfunction

"   }}}
"   {{{ InsertClass()

function! InsertClass() range

    let package = input("Package name? ")
    if package == 'Q'
        return
    endif

    let text = s:jstemplate_class
    let text = substitute(text, '%package%', package, 'g')

    let subpackage = input('Subpackage name? ')
    let text = substitute(text, '%subpackageline%', s:getDocLine('subpackage', subpackage, ' '), 'g')

    let text = substitute(text, '%copyright%', s:getCopyright(package, subpackage), 'g')
    let text = substitute(text, '%license%', s:getLicense(package, subpackage), 'g')
    let text = substitute(text, '%version%', s:getVersion(package, subpackage, 'n'), 'g')
    let text = substitute(text, '%link%', s:getLink(package, subpackage), 'g')
    let text = substitute(text, '%author%', s:getAuthor(package, subpackage), 'g')

    let text = s:parameterize_template(text, "Class name? ", '%classname%', '')
    let text = s:parameterize_template(text, "Description? ", '%description%', '')
    call s:append_text(line('.'), text)
    normal dd
    set expandtab tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=marker foldlevel=0
endfunction

"   }}}
"   {{{ InsertExtendedClass()

function! InsertExtendedClass() range

    let package = input("Package name? ")
    if package == 'Q'
        return
    endif

    let text = s:jstemplate_extclass
    let text = substitute(text, '%package%', package, 'g')

    let subpackage = input('Subpackage name? ')
    let text = substitute(text, '%subpackageline%', s:getDocLine('subpackage', subpackage, ' '), 'g')

    let text = substitute(text, '%copyright%', s:getCopyright(package, subpackage), 'g')
    let text = substitute(text, '%license%', s:getLicense(package, subpackage), 'g')
    let text = substitute(text, '%version%', s:getVersion(package, subpackage, 'n'), 'g')
    let text = substitute(text, '%link%', s:getLink(package, subpackage), 'g')
    let text = substitute(text, '%author%', s:getAuthor(package, subpackage), 'g')

    let text = s:parameterize_template(text, "Class name? ", '%classname%', '')
    let text = s:parameterize_template(text, "Extends? ", '%parentclass%', '')
    let text = s:parameterize_template(text, "Description? ", '%description%', '')
    call s:append_text(line('.'), text)
    normal dd
    set expandtab tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=marker foldlevel=0
endfunction

"   }}}
"   {{{ InsertSubclass()

function! InsertSubclass() range

    let package = s:getPackage('y')
    if package == 'Q'
        return
    endif

    let text = s:jstemplate_subclass
    let text = substitute(text, '%package%', package, 'g')

    let subpackage = input('Subpackage name? ')
    let text = substitute(text, '%subpackageline%', s:getDocLine('subpackage', subpackage, ' '), 'g')

    let text = substitute(text, '%copyright%', s:getCopyright(package, subpackage), 'g')
    let text = substitute(text, '%license%', s:getLicense(package, subpackage), 'g')
    let text = substitute(text, '%version%', s:getVersion(package, subpackage, 'n'), 'g')
    let text = substitute(text, '%link%', s:getLink(package, subpackage), 'g')
    let text = substitute(text, '%author%', s:getAuthor(package, subpackage), 'g')

    let text = s:parameterize_template(text, "Class name? ", '%classname%', '')
    let text = s:parameterize_template(text, "Description? ", '%description%', '')

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

    let text = s:jstemplate_method

    let text = substitute(text, '%function%', functionname, 'g')
    let text = s:parameterize_template(text, "Description? ", '%description%', '')

    let paramstemplate = "\n     * @param  %type% %name% %desc%"
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
        let paramdesc = input('Description? ')
        let paramdefault = input('Default? ')
        if paramdefault != ''
            let paramname = paramname . ' = ' . paramdefault
            let paramdesc = '[optional] ' . paramdesc
        endif
        let thisparams = substitute(thisparams, '%desc%', paramdesc, 'g')
        if paramsdec == ''
            let paramsdec = paramname
        else
            let paramsdec = paramsdec . ', ' . paramname
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
        let returntemplate = substitute(returntemplate, '%desc%', input('Description? '), 'g')
        let returnline = returntemplate
    endif
    let text = substitute(text, '%returnline%', returnline, 'g')

    let package    = s:getPackage('n')
    let subpackage = s:getSubpackage('n')
    let pkgvrsn    = s:getVersion(package, subpackage, 'n')
    let clavrsn    = s:getClassVersion()
    if pkgvrsn != clavrsn
        let pkgvrsnline = "\n     *\n     * @since " . pkgvrsn
    else
        let pkgvrsnline = ""
    endif
    let text = substitute(text, '%methodversion%', pkgvrsnline, 'g')
    let text = substitute(text, '%author%', s:getAuthor(package, subpackage), 'g')

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

    let text = s:jstemplate_getset

    let capvarname = input('Method Variable Name? (blank to capitalize) ')
    if capvarname == ''
        let capvarname = substitute(varname, '^\([a-z]\)', '\U\1\E', 'g')
    endif
    let inpvarname = input('Input Variable Name? (blank to copy) ')
    if inpvarname == ''
        let inpvarname = varname
    endif
    let text = s:parameterize_template(text, "Description? ", '%description%', '')
    let text = s:parameterize_template(text, "Type? ", '%type%', '')
    let text = substitute(text, '%varname%', varname, 'g')
    let text = substitute(text, '%capvarname%', capvarname, 'g')
    let text = substitute(text, '%inpvarname%', inpvarname, 'g')

    let package    = s:getPackage('n')
    let subpackage = s:getSubpackage('n')
    let pkgvrsn    = s:getVersion(package, subpackage, 'n')
    let clavrsn    = s:getClassVersion()
    if pkgvrsn != clavrsn
        let pkgvrsnline = "\n     *\n     * @since " . pkgvrsn
    else
        let pkgvrsnline = ""
    endif
    let text = substitute(text, '%methodversion%', pkgvrsnline, 'g')
    let text = substitute(text, '%author%', s:getAuthor(package, subpackage), 'g')

    normal o
    call s:append_text(line('.'), text)
    normal ddj}kk$zx
endfunction

"   }}}
"   {{{ InsertPropertyGetSet()

function! InsertPropertyGetSet() range

    let varname = input('Variable Name? ')
    if varname == 'Q'
        return
    endif

    let text = s:jstemplate_propgetset

    let capvarname = input('Method Variable Name? (blank to capitalize) ')
    if capvarname == ''
        let capvarname = substitute(varname, '^\([a-z]\)', '\U\1\E', 'g')
    endif
    let inpvarname = input('Input Variable Name? (blank to copy) ')
    if inpvarname == ''
        let inpvarname = varname
    endif
    let descr = input("Description? ")
    let capdescr = substitute(descr, '^\([a-z]\)', '\U\1\E', 'g')
    let text = substitute(text, '%description%', descr, 'g')
    let text = substitute(text, '%capdescription%', capdescr, 'g')
    let text = s:parameterize_template(text, "Type? ", '%type%', '')
    let text = substitute(text, '%varname%', varname, 'g')
    let text = substitute(text, '%capvarname%', capvarname, 'g')
    let text = substitute(text, '%inpvarname%', inpvarname, 'g')

    let package    = s:getPackage('n')
    let subpackage = s:getSubpackage('n')
    let pkgvrsn    = s:getVersion(package, subpackage, 'n')
    let clavrsn    = s:getClassVersion()
    if pkgvrsn != clavrsn
        let pkgvrsnline = "\n     *\n     * @since " . pkgvrsn
    else
        let pkgvrsnline = ""
    endif
    let text = substitute(text, '%methodversion%', pkgvrsnline, 'g')
    let text = substitute(text, '%author%', s:getAuthor(package, subpackage), 'g')

    normal o
    call s:append_text(line('.'), text)
    normal ddj}kk$zx5j
endfunction

"   }}}
"   {{{ InsertPropertyGetAddClear()

function! InsertPropertyGetAddClear() range

    let varname = input('Variable Name? ')
    if varname == 'Q'
        return
    endif

    let text = s:jstemplate_propgetaddclear

    let capvarname = input('Method Variable Name? (blank to capitalize) ')
    if capvarname == ''
        let capvarname = substitute(varname, '^\([a-z]\)', '\U\1\E', 'g')
    endif
    let inpvarname = input('Singular Variable Name? (blank to copy) ')
    if inpvarname == ''
        let inpvarname = varname
    endif
    let descr = input("Description? ")
    let capdescr = substitute(descr, '^\([a-z]\)', '\U\1\E', 'g')
    let text = substitute(text, '%description%', descr, 'g')
    let text = substitute(text, '%capdescription%', capdescr, 'g')
    let singdescr = input("Singular Description? (blank to copy)")
    if singdescr == ''
        let singdescr = descr
    endif
    let text = substitute(text, '%singdescription%', singdescr, 'g')
    let text = s:parameterize_template(text, "Type? ", '%type%', '')

    let text = substitute(text, '%varname%', varname, 'g')
    let text = substitute(text, '%capvarname%', capvarname, 'g')
    let text = substitute(text, '%inpvarname%', inpvarname, 'g')

    let package    = s:getPackage('n')
    let subpackage = s:getSubpackage('n')
    let pkgvrsn    = s:getVersion(package, subpackage, 'n')
    let clavrsn    = s:getClassVersion()
    if pkgvrsn != clavrsn
        let pkgvrsnline = "\n     *\n     * @since " . pkgvrsn
    else
        let pkgvrsnline = ""
    endif
    let text = substitute(text, '%methodversion%', pkgvrsnline, 'g')
    let text = substitute(text, '%author%', s:getAuthor(package, subpackage), 'g')

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

    let text = s:jstemplate_whether

    let text = substitute(text, '%method%', methodname, 'g')
    let text = s:parameterize_template(text, "Whether...? ", '%whether%', '')

    let package    = s:getPackage('n')
    let subpackage = s:getSubpackage('n')
    let pkgvrsn    = s:getVersion(package, subpackage, 'n')
    let clavrsn    = s:getClassVersion()
    if pkgvrsn != clavrsn
        let pkgvrsnline = "\n     *\n     * @since " . pkgvrsn
    else
        let pkgvrsnline = ""
    endif
    let text = substitute(text, '%methodversion%', pkgvrsnline, 'g')
    let text = substitute(text, '%author%', s:getAuthor(package, subpackage), 'g')

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

    let text = s:jstemplate_property

    let text = substitute(text, '%varname%', varname, 'g')
    let text = s:parameterize_template(text, "Description? ", '%description%', '')
    let text = s:parameterize_template(text, "Type? ", '%type%', '')

    let pkgvrsn = s:getVersion(s:getPackage('n'), s:getSubpackage('n'), 'n')
    let clavrsn = s:getClassVersion()
    if pkgvrsn != clavrsn
        let pkgvrsnline = "\n     *\n     * @since " . pkgvrsn
    else
        let pkgvrsnline = ""
    endif
    let text = substitute(text, '%propversion%', pkgvrsnline, 'g')

    normal o
    call s:append_text(line('.'), text)
    normal ddj}kk$zxjj
endfunction

"   }}}
" }}}
" {{{ Helper Methods
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
"   {{{ getPackage()

function! s:getPackage(ask)
    try
        exe "normal mbgg/@package\<CR>wwvey`b"
        let package = @"
    catch
        let package = ''
    endtry
    if a:ask == 'y'
        if package == ''
            let package = input("Package name? ")
        endif
    endif
    return package
endfunction

"   }}}
"   {{{ getSubpackage()

function! s:getSubpackage(ask)
    try
        exe "normal mbgg/@subpackage\<CR>wwvey`b"
        let subpackage = @"
    catch
        let subpackage = ''
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

function! s:getCopyright(package, subpackage)
    if (exists('g:' . a:subpackage . '_copyright'))
        exec "let copyright = g:" . a:subpackage . "_copyright"
    elseif (exists('g:' . a:package . '_copyright'))
        exec "let copyright = g:" . a:package . "_copyright"
    else
        let copyright = g:copyright_efs
    endif
    return copyright
endfunction

"   }}}
"   {{{ getVersion()

function! s:getVersion(package, subpackage, ask)
    if (exists('g:' . a:package . '_version'))
        exec "let versionnum = g:" . a:package . "_version"
    elseif (exists('g:' . a:subpackage . '_version'))
        exec "let versionnum = g:" . a:subpackage . "_version"
    elseif a:ask == 'y'
        let versionnum = input("Since? ")
    else
        let versionnum = "0.1"
    endif
    if versionnum == 'DATE'
        let versionnum = strftime('%Y-%m-%d')
    endif
    return versionnum
endfunction

"   }}}
"   {{{ getAuthor()

function! s:getAuthor(package, subpackage)
    if (exists('g:' . a:subpackage . '_author'))
        exec "let author = g:" . a:subpackage . "_author"
    elseif (exists('g:' . a:package . '_author'))
        exec "let author = g:" . a:package . "_author"
    else
        let author = g:author_efs
    endif
    return author
endfunction

"   }}}
"   {{{ getLicense()

function! s:getLicense(package, subpackage)
    if (exists('g:' . a:subpackage . '_license'))
        exec "let license = g:" . a:subpackage . "_license"
    elseif (exists('g:' . a:package . '_license'))
        exec "let license = g:" . a:package . "_license"
    else
        let license = g:license_efs
    endif
    return license
endfunction

"   }}}
"   {{{ getLink()

function! s:getLink(package, subpackage)
    if (exists('g:' . a:subpackage . '_link'))
        exec "let link = g:" . a:subpackage . "_link"
    elseif (exists('g:' . a:package . '_link'))
        exec "let link = g:" . a:package . "_link"
    else
        let link = g:link_efs
    endif
    return link
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
" }}}
" {{{ Templates
"   {{{ File

if exists("b:jstemplate_file")
  let s:jstemplate_file = b:jstemplate_file
else
  let s:jstemplate_file =
    \ "/**\n" .
    \ " * %description%\n" .
    \ " *\n" .
    \ " * @copyright  %copyright%\n" .
    \ " * @license    %license%\n" .
    \ " * @version    $Id$\n" .
    \ " * @link       %link%\n" .
    \ " * @since      %version%\n" .
    \ " * @package    %package%%subpackageline%\n" .
    \ " * @author     %author%\n" .
    \ " */\n"
endif

"   }}}
"   {{{ Function

if exists("b:jstemplate_function")
  let s:jstemplate_function = b:jstemplate_function
else
  let s:jstemplate_function =
    \ "/**\n" .
    \ " * %description%%funcversion%\n" .
    \ " *%paramsline%%returnline%\n" .
    \ " * @author %author%\n" .
    \ " */\n" .
    \ "function %function%(%paramsdec%) {\n" .
    \ "}\n"
endif

"   }}}
"   {{{ Class File

if exists("b:jstemplate_class")
  let s:jstemplate_class = b:jstemplate_class
else
  let s:jstemplate_class =
    \ "/**\n" .
    \ " * %classname% class\n" .
    \ " *\n" .
    \ " * @copyright  %copyright%\n" .
    \ " * @license    %license%\n" .
    \ " * @version    $Id$\n" .
    \ " * @link       %link%\n" .
    \ " * @since      %version%\n" .
    \ " * @package    %package%%subpackageline%\n" .
    \ " * @author     %author%\n" .
    \ " */\n" .
    \ "\n" .
    \ "/**\n" .
    \ " * %description%\n" .
    \ " *\n" .
    \ " * @copyright  %copyright%\n" .
    \ " * @license    %license%\n" .
    \ " * @version    $Id$\n" .
    \ " * @since      %version%\n" .
    \ " * @package    %package%%subpackageline%\n" .
    \ " * @author     %author%\n" .
    \ " */\n" .
    \ "var %classname% = Class.create({\n" .
    \ "    /**\n" .
    \ "\t * Constructor\n" .
    \ "\t *\n" .
    \ "\t * @author %author%\n" .
    \ "\t */\n" .
    \ "\tinitialize: function() {\n" .
    \ "\t},\n" .
    \ "});\n"
endif

"   }}}
"   {{{ Class not in a new file

if exists("b:jstemplate_subclass")
  let s:jstemplate_subclass = b:jstemplate_subclass
else
  let s:jstemplate_subclass =
    \ "/**\n" .
    \ " * %description%\n" .
    \ " *\n" .
    \ " * @copyright  %copyright%\n" .
    \ " * @license    %license%\n" .
    \ " * @version    $Id$\n" .
    \ " * @since      %version%\n" .
    \ " * @package    %package%%subpackageline%\n" .
    \ " * @author     %author%\n" .
    \ " */\n" .
    \ "var %classname% = Class.create({\n" .
    \ "});\n"
endif

"   }}}
"   {{{ Extended Class File

if exists("b:jstemplate_extclass")
  let s:jstemplate_extclass = b:jstemplate_extclass
else
  let s:jstemplate_extclass =
    \ "/**\n" .
    \ " * %classname% class\n" .
    \ " *\n" .
    \ " * @copyright  %copyright%\n" .
    \ " * @license    %license%\n" .
    \ " * @version    $Id$\n" .
    \ " * @link       %link%\n" .
    \ " * @since      %version%\n" .
    \ " * @package    %package%%subpackageline%\n" .
    \ " * @author     %author%\n" .
    \ " */\n" .
    \ "\n" .
    \ "/**\n" .
    \ " * %description%\n" .
    \ " *\n" .
    \ " * @copyright  %copyright%\n" .
    \ " * @license    %license%\n" .
    \ " * @version    $Id$\n" .
    \ " * @since      %version%\n" .
    \ " * @package    %package%%subpackageline%\n" .
    \ " * @author     %author%\n" .
    \ " */\n" .
    \ "var %classname% = Class.create(%parentclass%, {\n" .
    \ "\t/**\n" .
    \ "\t * Constructor\n" .
    \ "\t *\n" .
    \ "\t * @author %author%\n" .
    \ "\t */\n" .
    \ "\tinitialize: function($super) {\n" .
    \ "\t\t$super();\n" .
    \ "\t},\n" .
    \ "});\n"
endif

"   }}}
"   {{{ Method

if exists("b:jstemplate_method")
  let s:jstemplate_method = b:jstemplate_method
else
  let s:jstemplate_method =
    \ "\t/**\n" .
    \ "\t * %description%%methodversion%\n" .
    \ "\t *%paramsline%%returnline%\n" .
    \ "\t * @author %author%\n" .
    \ "\t */\n" .
    \ "\t%function%: function(%paramsdec%) {\n" .
    \ "\t},\n"
endif

"   }}}
"   {{{ Get and Set Methods

if exists("b:jstemplate_getset")
  let s:jstemplate_getset = b:jstemplate_getset
else
  let s:jstemplate_getset =
    \ "\t    /**\n" .
    \ "\t * Gets %description%%methodversion%\n" .
    \ "\t *\n" .
    \ "\t * @return %type% %description%\n" .
    \ "\t * @author %author%\n" .
    \ "\t */\n" .
    \ "\tget%capvarname%: function() {\n" .
    \ "\t\treturn this.%varname%;\n" .
    \ "\t},\n" .
    \ "\t\n" .
    \ "\t/**\n" .
    \ "\t * Sets %description%%methodversion%\n" .
    \ "\t *\n" .
    \ "\t * @param %type% %inpvarname% %description%\n" .
    \ "\t * @author %author%\n" .
    \ "\t */\n" .
    \ "\tset%capvarname%: function(%inpvarname%) {\n" .
    \ "\t\tthis.%varname% = %inpvarname%;\n" .
    \ "\t},\n"
endif

"   }}}
"   {{{ Property

if exists("b:jstemplate_property")
  let s:jstemplate_property = b:jstemplate_property
else
  let s:jstemplate_property =
    \ "\t/**\n" .
    \ "\t * %description%%propversion%\n" .
    \ "\t *\n" .
    \ "\t * @var %type%\n" .
    \ "\t */\n" .
    \ "\tthis.%varname%,\n"
endif

"   }}}
"   {{{ Property + Get and Set Methods

if exists("b:jstemplate_propgetset")
  let s:jstemplate_propgetset = b:jstemplate_propgetset
else
  let s:jstemplate_propgetset =
    \ "\t/**\n" .
    \ "\t * %capdescription%%methodversion%\n" .
    \ "\t *\n" .
    \ "\t * @var %type%\n" .
    \ "\t */\n" .
    \ "\tthis.%varname%,\n" .
    \ "\n" .
    \ "\t/**\n" .
    \ "\t * Gets %description%%methodversion%\n" .
    \ "\t *\n" .
    \ "\t * @return %type% %description%\n" .
    \ "\t * @author %author%\n" .
    \ "\t */\n" .
    \ "\tget%capvarname% function() {\n" .
    \ "\t\treturn this.%varname%;\n" .
    \ "\t},\n" .
    \ "\n" .
    \ "\t/**\n" .
    \ "\t * Sets %description%%methodversion%\n" .
    \ "\t *\n" .
    \ "\t * @param %type% %inpvarname% %description%\n" .
    \ "\t * @author %author%\n" .
    \ "\t */\n" .
    \ "\tset%capvarname%: function(%inpvarname%) {\n" .
    \ "\t\tthis.%varname% = %inpvarname%;\n" .
    \ "\t},\n"
endif

"   }}}
"   {{{ Property + Get, Add, and Clear Methods

if exists("b:jstemplate_propgetaddclear")
  let s:jstemplate_propgetaddclear = b:jstemplate_propgetaddclear
else
  let s:jstemplate_propgetaddclear =
    \ "\t/**\n" .
    \ "\t * %capdescription%%methodversion%\n" .
    \ "\t *\n" .
    \ "\t * @var %type%\n" .
    \ "\t */\n" .
    \ "\tthis.%varname% = new Array(),\n" .
    \ "\n" .
    \ "\t/**\n" .
    \ "\t * Gets %description%%methodversion%\n" .
    \ "\t *\n" .
    \ "\t * @return array %description%\n" .
    \ "\t * @author %author%\n" .
    \ "\t */\n" .
    \ "\tpublic function get%capvarname%() {\n" .
    \ "\t\treturn this.%varname%;\n" .
    \ "\t},\n" .
    \ "\n" .
    \ "\t/**\n" .
    \ "\t * Adds %singdescription%%methodversion%\n" .
    \ "\t *\n" .
    \ "\t * @param %type% $%inpvarname% %singdescription%\n" .
    \ "\t * @author %author%\n" .
    \ "\t */\n" .
    \ "\tpublic function add%capvarname%(%typehint%$%inpvarname%) {\n" .
    \ "\t\tthis.%varname%[] = %inpvarname%;\n" .
    \ "\t},\n" .
    \ "\n" .
    \ "\t/**\n" .
    \ "\t * Clears %description%%methodversion%\n" .
    \ "\t *\n" .
    \ "\t * @author %author%\n" .
    \ "\t */\n" .
    \ "\tpublic function clear%capvarname%() {\n" .
    \ "\t\tthis.%varname% = new Array();\n" .
    \ "\t},\n" .
    \ "\n"
endif

"   }}}
"   {{{ Whether Method

if exists("b:jstemplate_whether")
  let s:jstemplate_whether = b:jstemplate_whether
else
  let s:jstemplate_whether =
    \"\t/**\n" .
    \"\t * Returns whether %whether%%methodversion%\n" .
    \"\t *\n" .
    \"\t * @return bool whether %whether%\n" .
    \"\t * @author %author%\n" .
    \"\t */\n" .
    \"\tfunction %method%() {\n" .
    \"\t},\n"
endif

"   }}}
" }}}

