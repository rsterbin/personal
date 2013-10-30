
" Special fold region for big our-variable blocks
syn region perlOurVarFold start="^our [$@%][A-Z_]\+\s*=\s*[{(\[]\s*$" end="^\s*[})\]]\s*;\s*$" transparent fold keepend

