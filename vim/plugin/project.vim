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

" {{{ Tabs versus spaces

" Function: replace leading whitespace with tabs (up to 12 levels)
fun! g:Project_LeadingSpacesToTabs()
    try
        exe ':%s/^    /\t'
        exe ':%s/^\t    /\t\t'
        exe ':%s/^\t\t    /\t\t\t'
        exe ':%s/^\t\t\t    /\t\t\t\t'
        exe ':%s/^\t\t\t\t    /\t\t\t\t\t'
        exe ':%s/^\t\t\t\t\t    /\t\t\t\t\t\t'
        exe ':%s/^\t\t\t\t\t\t    /\t\t\t\t\t\t\t'
        exe ':%s/^\t\t\t\t\t\t\t    /\t\t\t\t\t\t\t\t'
        exe ':%s/^\t\t\t\t\t\t\t\t    /\t\t\t\t\t\t\t\t\t'
        exe ':%s/^\t\t\t\t\t\t\t\t\t    /\t\t\t\t\t\t\t\t\t\t'
        exe ':%s/^\t\t\t\t\t\t\t\t\t\t    /\t\t\t\t\t\t\t\t\t\t\t'
        exe ':%s/^\t\t\t\t\t\t\t\t\t\t\t    /\t\t\t\t\t\t\t\t\t\t\t\t'
    catch
    endtry
endfun

" Function: replace tabs with spaces
fun! g:Project_LeadingTabsToSpaces()
    try
        exe ':%s/\t/    /g'
    catch
    endtry
endfun

" Function: toggle between tabs and spaces
fun! g:Project_ToggleTabsVsSpaces(which)
    if a:which == "tabs"
        set noexpandtab
        set shiftwidth=4
        set tabstop=4
        set softtabstop=0
        noremap <leader>tt :call g:Project_LeadingSpacesToTabs()<CR>
        call g:Project_LeadingSpacesToTabs()
    endif
    if a:which == "spaces"
        set expandtab
        set shiftwidth=4
        set tabstop=4
        set softtabstop=4
        noremap <leader>tt :call g:Project_LeadingTabsToSpaces()<CR>
        call g:Project_LeadingTabsToSpaces()
    endif
endfun

" Function: detect whether we should use tabs or spaces and set up accordingly
fun! g:Project_DetectTabsVsSpaces()
    let cp = g:DetectProject()
    if g:project_info[cp]['coding_standards']['tabs'] == 'y'
        let b:project_tabsVsSpaces = "tabs"
    else
        if g:project_info[cp]['coding_standards']['spaces'] == 'y'
            let b:project_tabsVsSpaces = "spaces"
        else
            let b:project_tabsVsSpaces = "maintain"
        endif
    endif
    call g:Project_ToggleTabsVsSpaces(b:project_tabsVsSpaces)
endfun

" Correct for tabs and spaces after read and before write
if &diff
else
    autocmd BufReadPost *.* :call g:Project_DetectTabsVsSpaces()
    autocmd BufWritePre *.* :call g:Project_DetectTabsVsSpaces()
endif


" }}}
" {{{ Convenience functions

" Function: open the class file in the @ register
fun! g:Project_OpenClassFile()
    let cp = b:current_project
    try
        exec "call " . g:project_info[cp]['open_func'] . "()"
    catch
        exec "call " . g:project_info['default']['open_func'] . "()"
    endtry
endfun

" Function: insert a dump line
fun! g:Project_AddDumpLine()
    let cp = b:current_project
    try
        exec "call " . g:project_info[cp]['dump_func'] . "()"
    catch
        exec "call " . g:project_info['default']['dump_func'] . "()"
    endtry
endfun

" }}}

