
" 20060125 (rsterbin) Set up folds
"
set foldmethod=marker
set foldlevel=0
set foldcolumn=0
hi Folded ctermfg=11 ctermbg=0
hi FoldColumn ctermfg=12

nnoremap <leader>z0 :set foldlevel=0<CR>
nnoremap <leader>z1 :set foldlevel=1<CR>
nnoremap <leader>z2 :set foldlevel=2<CR>
nnoremap <leader>zy :set invfoldenable<CR>
nnoremap <leader>zc /^class<CR>zazj

exe "normal ,zc"

