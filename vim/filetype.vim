" Function: detect when a file is xml
"
fun! DetectXML()
    if getline(1) =~ '^<?xml'
        setf xml
    endif
endfun

if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    " Recognize phpDocumentor tutorial DocBook files as XML
    au BufNewFile,BufRead *.pkg,*.cls,*.proc call DetectXML()
    " Zend view files
    au BufNewFile,BufRead *.phtml setf php
    " Apache conf files
    au BufNewFile,BufRead local*httpd.conf setf apache
    au BufNewFile,BufRead httpd*.conf setf apache
augroup END

