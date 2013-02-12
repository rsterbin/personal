" vim: set foldlevel=0 foldmethod=marker:

" {{{ Function: FindDocblockVariable

" Look for a particular docblock variable in the file
"
" @param  string docvar the name of the variable (e.g., 'category')
" @return string the value, if found
"
fun! g:FindDocblockVariable(docvar)
    call cursor(1, 1)
    let [foundLine, foundCol] = searchpos("@" . a:docvar, "n")
    if foundLine == 0
        return ""
    else
        let full = getline(foundLine)
        let tmp = strpart(full, foundCol + strlen(a:docvar) + 1)
        let stripped = substitute(tmp, "^\\s\\+\\|\\s\\+$", "", "g") 
        return stripped
    endif
endfun

" }}}
" {{{ Function: DetectProject

" Detect the project of the current buffer
"
" @return string the current project
"
fun! g:DetectProject()

    " do we already have it?
    if exists("b:current_project")
        return b:current_project
    endif

    " do we have a catetory/package/subpackage?
    let category = g:FindDocblockVariable("category")
    let package = g:FindDocblockVariable("package")
    for p in keys(g:project_info)
        if has_key(g:project_info[p], 'category') && g:project_info[p]['category'] == category
            call g:SetProject(p)
            return b:current_project
        elseif has_key(g:project_info[p], 'package') && g:project_info[p]['package'] == package
            call g:SetProject(p)
            return b:current_project
        endif
    endfor

    " check the environment variable, for single-project zones
    if exists("$VIM_PROJECT")
        call g:SetProject($VIM_PROJECT)
        return b:current_project
    endif

    " check the path, for multiple-project working copies
    let fullpath = expand("%:p")
    for p in keys(g:project_info)
        if has_key(g:project_info[p], 'directory')
            for dir in (g:project_info[p]['directory'])
                if match(fullpath, dir) != -1
                    call g:SetProject(p)
                    return b:current_project
                endif
            endfor
        endif
    endfor

    " give up
    call g:SetProject('default')
    return b:current_project

endfun

" }}}
" {{{ Function: SetProject

" Sets the project directly
"
" @param string project the project name
"
fun! g:SetProject(project)
    let b:current_project = a:project
    let filename = '~/.vim/projects/' . b:current_project . '.vim'
    echo filename
    " try
        exec "source " . filename
    " catch
    " endtry
    if has_key(g:project_info[b:current_project], 'init_func')
        try
            exec "call " . g:project_info[b:current_project]['init_func'] . "()"
        catch
        endtry
    endif
endfun

" }}}

" Call DetectProject() on read
autocmd BufReadPost *.* :call g:DetectProject()

" {{{ Convenience functions

" Default class finder function
fun! g:Project_Open_Default()
    let filepath = substitute(@", '::', '/', 'g') . '.php'
    exe ':e ' . filepath
endfun

" Default dump function
fun! g:Project_Dump_Default()
    let blank = "print '<pre style=\"color: red;\">' . \"\\n\"; var_dump(); print '</pre>' . \"\\n\";"
    let pos = line('.')
    call append(pos, blank)
    exe "normal j$9b"
endfun

" Function: open the class file in the @ register
fun! g:Project_OpenClassFile()
    let cp = b:current_project
    try
        exec "call " . g:project_info[cp]['open_func'] . "()"
    catch
        exec "call g:Project_Open_Default()"
    endtry
endfun

" Function: insert a dump line
fun! g:Project_AddDumpLine()
    let cp = b:current_project
    try
        exec "call " . g:project_info[cp]['dump_func'] . "()"
    catch
        exec "call g:Project_Dump_Default()"
    endtry
endfun

" }}}

