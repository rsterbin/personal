" RTO classes
syn keyword phpRTOClasses BBBBBBBBBBBBBBBBBBB

" RTO functions
syn keyword	phpRTOLibFunctions AAAAAAAAAAAAAAAAAAA

" RTO defined constants
syn keyword phpRTOConstants CCCCCCCCCCCCCCCCCCC


" Create RTOfunctions highlighting group and higlight blue
hi RTOfunctions ctermfg=12

" Link function list to RTOfunctions group
hi link phpRTOLibFunctions RTOfunctions

" Link constants list to RTOfunctions group
hi link phpRTOConstants RTOfunctions

" Link classes list to RTOfunctions group
hi link phpRTOClasses RTOfunctions

" Add functions to the within-php-tags cluster
syn cluster phpClConst add=phpRTOLibFunctions

" Add constants to the within-php-tags cluster
syn cluster phpClConst add=phpRTOConstants

" Add functions to the within-php-tags cluster
syn cluster phpClConst add=phpRTOClasses

" Add functions to the within-object-methods match
syn match	phpMethodsVar	"->\h\w*"	contained contains=phpMemberSelector,phpRTOLibFunctions display

