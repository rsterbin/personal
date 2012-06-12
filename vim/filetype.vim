"
" Recognize phpDocumentor tutorial DocBook files as XML
"
fun! DetectXML()
    if getline(1) =~ '^<?xml'
        setf xml
    endif
endfun

augroup filetypedetect
au BufNewFile,BufRead *.pkg,*.cls,*.proc call DetectXML()
augroup END

"
" Zend view files
"
augroup filetypedetect
au BufNewFile,BufRead *.phtml setf php
augroup END

"
" Apache conf files
"
au BufNewFile,BufRead local*httpd.conf setf apache 
au BufNewFile,BufRead httpd*.conf setf apache 

