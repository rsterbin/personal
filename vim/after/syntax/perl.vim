
" Special fold region for big our-variable blocks
syn region perlOurVarFold start="^our [$@%][A-Z_]\+\s*=\s*[{(\[]\s*$" end="^\s*[})\]]\s*;\s*$" transparent fold keepend

" Special fold region for subs inside hashrefs
syn region perlHashrefSubFold start="^\z(\s*\)[a-zA-Z_]\+\s*=>\s*\<sub\>.*[^};]$" end="^\z1},\?\s*\%(#.*\)\=$" transparent fold keepend

