" vim: set foldlevel=0 foldmethod=marker:

" {{{ Function: EnforceSpacesToTabs

" Replaces leading whitespace with tabs (up to 12 levels)
"
fun! g:EnforceSpacesToTabs()
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

" }}}
" {{{ Function: EnforceTabsToSpaces

" Replaces tabs with spaces
"
fun! g:EnforceTabsToSpaces()
    try
        exe ':%s/\t/    /g'
    catch
    endtry
endfun

" }}}
" {{{ Function: ToggleTabsVsSpaces

" Toggles vim settings between tabs and spaces
fun! g:ToggleTabsVsSpaces(which)
    if a:which == "tabs"
        set noexpandtab
        set shiftwidth=4
        set tabstop=4
        set softtabstop=0
        noremap <leader>tt :call g:EnforceSpacesToTabs()<CR>
        call g:EnforceSpacesToTabs()
    endif
    if a:which == "spaces"
        set expandtab
        set shiftwidth=4
        set tabstop=4
        set softtabstop=4
        noremap <leader>tt :call g:EnforceTabsToSpaces()<CR>
        call g:EnforceTabsToSpaces()
    endif
endfun

" }}}
" {{{ Function: EnforceTabsVsSpaces

" Detect whether we should use tabs or spaces for this buffer and set up
" accordingly
"
fun! g:EnforceTabsVsSpaces()
    let which = "maintain"
    if exists('b:enforceTabs') && b:enforceTabs == 'y'
        let which = "tabs"
    else
        if exists('b:enforceSpaces') && b:enforceSpaces == 'y'
            let which = "spaces"
        endif
    endif
    call g:ToggleTabsVsSpaces(which)
endfun

" }}}
" {{{ Function: EnforceTrailingWhitespace

" Detect whether we should clear out trailing whitespace on write
"
fun! g:EnforceTrailingWhitespace()
    let this_ext  = expand('%:e')
    let this_file = expand('%:t')
    if exists('b:enforceNoTrailingWhitespace') && has_key(b:enforceNoTrailingWhitespace, this_ext) && b:enforceNoTrailingWhitespace[this_ext] == 'y'
        if exists('b:ignoreTrailingWhitespace') && has_key(b:ignoreTrailingWhitespace, this_file) && b:ignoreTrailingWhitespace[this_file] == 'y'
        else
            :%s/\s\+$//e
        endif
    endif
endfun

" }}}

" Correct for tabs and spaces after read and before write
if &diff
else
    autocmd BufReadPost *.* :call g:EnforceTabsVsSpaces()
    autocmd BufWritePre *.* :call g:EnforceTabsVsSpaces()
    autocmd BufWritePre *.* :call g:EnforceTrailingWhitespace()
endif

