" vim: set foldlevel=0 foldmethod=marker:

" {{{ Option settings

" Turn on filetype plugins
filetype plugin on

" I usually write code, so turn this on
set autoindent

" Automatically save modifications to files when you use critical (rxternal) commands.
set autowrite

" Allow backspacing over autoindent, line breaks, and start of insert
set backspace=2

" DO NOT let Vim behave like VI.
set nocompatible

" TODO: Research this; might be useful to know what these mean
" comments default: sr:/*,mb:*,el:*/,://,b:#,:%,:XCOMM,n:>,fb:-
set comments=s1:/*,mb:*,ex:*/,b:#,:%,fb:-,n:>

" Where is the dictionary?
set dictionary=/usr/dict/words

" Turn off the system beep
set noerrorbells

" Allow usage of cursor keys within insert mode
set esckeys

" Options for the 'text format' command ('gq'). TODO: Research this, as it is
" totally useless to me in most projects, and I might be able to fix it.
" Nevermind; autoformat is really just not worth it.
" set formatoptions=croqan
set formatoptions=
set textwidth=0
set wrapmargin=0

" Don't tell Vim how to set the help window height; let it happen automatically.
set helpheight=0

" Keep buffers open in the background (faster!)
set hidden

" Highlight settings:
"   Meta/special keys       reverse
"   Directories             bold
"   Error messsages         standout
"   Mode                    reverse
"   Line number             underline
"   Questions               standout
"   Status line             reverse
"   Titles                  bold
"   Visual mode             reverse
"   Warning messages        standout
set highlight=8r,db,es,hs,mb,Mr,nu,rs,sr,tb,vr,ws

" Highlight search - show the current search pattern
" This is a nice feature sometimes - but it sure can get in the
" way sometimes when you edit, so turn it off by default.
set nohlsearch

" Do not ignore the case in search patterns
set noignorecase

" Insert two spaces after a period with every joining of lines.  File under "I
" like it, typographers don't."
set joinspaces

" Show status line? Yes, always! Even for only one buffer.
set laststatus=2

" Do not update screen while executing macros
set lazyredraw

" Allow mouse use only on normal mode
set mouse=n

" Toggle paste mode on and off with F2 and F3
map <F2> :set paste<CR>
map <F3> :set nopaste<CR>
imap <F2> <C-O>:set paste<CR>
imap <F3> <nop>
set pastetoggle=<F3>

" report: show a report when N lines were changed.
" report=0 thus means "show all changes"!
set report=0

" ruler: show cursor position? Yep!
set ruler

" Decide what do do about the shell command
if has("dos16") || has("dos32")
let shell='command.com'
endif
if has("unix")
let &shell="bash\ -l"
endif

" Kind of messages to show. Abbreviate them all!
" New since vim-5.0v: flag 'I' to suppress 'intro message'.
set shortmess=at

" Show current uncompleted command? Absolutely!
set showcmd

" Show the matching bracket for the last ')'? Yep.
set showmatch

" Show the current mode? YEEEEEEEEESSSSSSSSSSS!
set showmode

" No, do not jump to first character with page commands. Keep the cursor in the
" current column.
set nostartofline

" When splitting, the new window goes below the current one
set splitbelow

" What info to store from an editing session in the viminfo file; can be used
" at next session.
set viminfo=%,'50,\"100,:100,n~/.viminfo

" Terminal's visual bell - turned off to make Vim quiet!  Please use this as to
" not annoy co-workers in the same room.
set visualbell
set t_vb=

" Allow the cursor to move from the beginning of one line to the end of another,
" or vice versa, using: left arrow, right arrow, h, and l
set whichwrap=<,>,h,l

" Use tab instead of C^E for text completion on the command line
set wildchar=<TAB>

" Don't spawn extra copies; assume I did what I meant to do
set nowritebackup

" Set up tabs to use ExuberantCTags
set tags=TAGS;/

" Set the error format for linting
set errorformat=%m\ in\ %f\ on\ line\ %l

" Adjust word boundaries to include "\" for use with PHP namespaces
set iskeyword=@,48-57,_,192-255,\

" Allow modelines to work
set modeline
set modelines=3

" Turn off spellcheck; it is useless when coding
set nospell

" }}}
" {{{ Abbreviations

" Correcting those typos. (I almost never get these right.)
iab alos also
iab aslo also
iab bianry binary
iab charcter character
iab charcters characters
iab exmaple example
iab shoudl should
iab seperate separate
iab teh the
iab tpyo typo
iab vidoe video

" }}}
" {{{ Mappings

" Caveat: Mapping must be "prefix free", ie no mapping must be the
" prefix of any other mapping. Example: "map ,abc foo" and
" "map ,abcd bar" will give you the error message "Ambigous mapping".

let mapleader = ","

" The following maps get rid of some basic problems:

" 980527 I often reformat a paragraph to fit some textwidth -
" and I use the following mapping to adjust it to the
" current position of the cursor:
noremap #tw :set textwidth=<C-R>=col(".")<C-M>

" Disable the command 'K' (keyword lookup) by mapping it
" to an empty command. (see ':help Nop')
noremap K <Nop>

" Disable the suspend for ^Z.
" I use Vim under "screen" where a suspend would lose the
" connection to the " terminal - which is what I want to avoid.
noremap <C-Z> :shell<CR>

" Make CTRL-^ rebound to the *column* in the previous file
noremap <C-^> <C-^>`"

" Make "gf" rebound to last cursor position (line *and* column)
noremap gf gf`"

" When I let Vim write the current buffer I frequently mistype the
" command ":w" as ":W" - so I have to remap it to correct this typo:
nmap :W :w

" Additional codes for that 'English' keyboard at the Xterminal
cnoremap <ESC>[D <Left>
cnoremap <ESC>[C <Right>

" Editing and updating the vimrc:
nnoremap <leader>uu :source ~/.vimrc<CR>
nnoremap <leader>vv :e ~/.vimrc<CR>

" Surround // Mappings
vnoremap <Leader>s" :call Surround('"', '"')<CR>
vnoremap <Leader>s( :call Surround('(', ')')<CR>
vnoremap <Leader>s[ :call Surround('[', ']')<CR>
vnoremap <Leader>s{ :call Surround('{', '}')<CR>
vnoremap <Leader>sc :call Surround('/*', '*/')<CR>

" 20050316 (rsterbin) Toggle text formatting:
" House coding style at RTO calls for long lines; however, I don't
" want to have to hand-wrap my English text.
noremap <C-E> :set formatoptions=troqan<c-m>
noremap <C-C> :set formatoptions=croqan<c-m>

" 20050406 (rsterbin) Fix notice error:
vnoremap <leader>Nea "zdiisset(<C-R>z) && <C-R>z<ESC>
vnoremap <leader>Net "zdiisset(<C-R>z) ? <C-R>z : 
vnoremap <leader>Nee "zdi!empty(<C-R>z)<ESC>

" 20050727 (rsterbin) Insert a line break at the cursor and go back
" into normal mode:
nnoremap <leader>b i<CR><ESC>

" 20050727 (rsterbin) Turn autoindent on and off
nnoremap <leader>ni :set noautoindent<C-M>
nnoremap <leader>ai :set autoindent<C-M>

" 20050906 (rsterbin) Toggle line numbering <vimtip #983>
nnoremap <leader>ln :set invnu<C-M>

" 20051114 (rsterbin) Re-align a /** WHATEVER **/ line
nnoremap <leader>al :s/\*//g<C-M>:s/\///g<C-M>:center<C-M>hhv0r*r/:s/$/**********************************************************************************************<C-M>:s/\(.\{80\}\).*/\1/<C-M>$r/

" 20051216 (rsterbin) Swap two arguments in a function
" -- works over the current line
nnoremap <leader>sw :s/(\([^,]\+\), \([^)]\+\))/(\2, \1)/g<C-M>

" 20060105 (rsterbin) Get php inline help (tip #1090)
noremap <leader>ph "vyiw:new<CR>:execute "r!links -dump http://us3.php.net/manual/en/function.".substitute(@v, '_', '-', 'g').".php"<CR>:1<CR>/Description<CR>zz

" 20060105 (rsterbin) Close help window generated above
noremap <leader>ch :bd!<CR>

" 20060126 (rsterbin) Toggle highlighted search
nnoremap <leader>hs :set invhlsearch<C-M>

" 20060321 (rsterbin) Put /* and */ around a visual selection
vnoremap <leader>co <esc>`>a*/<esc>`<i/*<esc>

" 20060331 (rsterbin) Remove trailing whitespace
" - from normal: over file
nnoremap <leader>rt :%s/\s\+$//<CR>
" - from visual: over selection
vnoremap <leader>rt :s/\s\+$//<CR>

" 20060331 (rsterbin) Align php doc block comments
" - from normal: over a single line
nnoremap <leader>pd :AlignCtrl p0P1Wllll:<CR>:Align \S\+<CR>:s/\(@return\s\+\S\+\s\+\S\+\)\s\+/\1 /e<CR>V,rt
" - from visual: over a selection
vnoremap <leader>pd :<BS><BS><BS><BS><BS>AlignCtrl p0P1Wllll:<CR>gv:Align \S\+<CR>gv:s/\(@return\s\+\S\+\s\+\S\+\)\s\+/\1 /e<CR>gv,rt

" 20060515 (rsterbin) Fold up PHP files with no fold tags
nnoremap <leader>ff :call FoldUnmarkedFiles()<CR>

" 20060626 (rsterbin) Fold up PHP files with fold tags
nnoremap <leader>fc :call FoldMarkedFiles()<CR>

" 20060626 (rsterbin) Align some text on commas
vnoremap <leader>ac \t,gv:s/\(\s\+\),/,\1/g<CR>

" 20070820 (rsterbin) Add a doc block to a method
noremap <leader>adb :call AddDocBlock()<CR>

" 20090313 (rsterbin) Turn a class name on a single line into a Zend_Loader::loadClass() line
noremap <leader>zlc ^iZend_Loader::loadClass('<ESC>ea');<ESC>bhvbyO/** @see <ESC>pa */<ESC>jj

" 20090317 (rsterbin) Open a class file
noremap <leader>gc viwy:call g:Project_OpenClassFile()<CR>

" 20090326 (rsterbin) Show/hide tabs
nnoremap <leader>st /\t<CR>:set hlsearch<CR>
nnoremap <leader>ht :set nohlsearch<CR>

" 20090406 (rsterbin) add a var dump line
nnoremap <leader>vd :call g:Project_AddDumpLine()<CR>a

" 20090406 (rsterbin) add a handler dump line
nnoremap <leader>vh oZend_Registry::get('errorHandler')->handle(new EFS_Exception(''));<ESC>$bla

" 20090708 (rsterbin) toggle tabs vs spaces
nnoremap <leader>ta :call g:ToggleTabsVsSpaces('tabs')<CR>
nnoremap <leader>sp :call g:ToggleTabsVsSpaces('spaces')<CR>
nnoremap <leader>to :call g:EnforceTabsVsSpaces()<CR>

" 20120132 (rsterbin) Put the current file name into the paste register
nnoremap <leader>cp :let @" = expand('%')<CR>

" }}}
" {{{ General Editing - Reformatting Text

" NOTE: The following mapping require formatoptions to include 'r'
" and 'comments' to include 'n:>' (ie 'nested' comments with '>').

" Formatting the current paragraph according to
" the current 'textwidth' with ^J (control-j):
inoremap <C-J> <c-o>gqap
noremap <C-J> gqap

" ,j = join line in commented text
" (can be used anywhere on the line)
nnoremap <leader>j Vjgq

" ,B = break line at current position *and* join the next line
nnoremap <leader>B r<CR>Vjgq

" }}}
" {{{ Mapping of special keys - arrow keys and function keys.

" Keyboard mapping for cursor keys
" [works for XTerminals - 970818]
noremap <ESC>[A <Up>
noremap <ESC>[B <Down>
noremap <ESC>[C <Right>
noremap <ESC>[D <Left>
inoremap <ESC>[A <Up>
inoremap <ESC>[B <Down>
inoremap <ESC>[C <Right>
inoremap <ESC>[D <Left>

" Paging up and down should work.
noremap <PageUp> <C-B>
noremap <PageDown> <C-F>

" Make [[, ][, ]], and [] work on non-first-column { and }"
noremap [[ ?{<CR>w99[{
noremap ][ /}<CR>b99]}
noremap ]] j0[[%/{<CR>
noremap [] k$][%?}<CR>

" }}}
" {{{ Invoke Pathogen

call pathogen#infect()

" }}}
" {{{ Plugin configuration

" MiniBufExplorer configuration
if &diff
else
    " Configuration: Put the explorer on the right side
    let g:miniBufExplVSplit = 25
    " Configuration: Put the explorer on the top
    " let g:miniBufExplSplitBelow = 0
    " Configuration: Don't report anything but serious bugs
    let g:miniBufExplorerDebugLevel = 0
    " Configuration: Set the debug mode to write to a file
    let g:miniBufExplorerDebugMode = 2
    " Configuration: Always open the explorer
    " let g:miniBufExplorerMoreThanOne = 1
    " Mapping: get to the window
    nnoremap <leader>mb :MiniBufExplorer<CR>
    " Mapping: toggle the window
    nnoremap <leader>mt :TMiniBufExplorer<CR>
    " Mapping: update the window
    nnoremap <leader>mu :UMiniBufExplorer<CR>
    " Highlighting: set colors for edited/unedited files
    hi MBENormal ctermfg=darkblue
    hi MBEChanged ctermfg=darkgreen
    hi MBEVisibleNormal ctermfg=magenta
    hi MBEVisibleChanged ctermfg=magenta
endif

" NERDTree configuration
if &diff
else
    " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
endif

" Projects
let g:project_info = {
    \ 'Aesculap' : {
    \   'directory' : [ 'aesculap' ],
    \   'package'   : 'Aesculap',
    \},
    \ 'Agora' : {
    \   'directory' : [ 'agora' ],
    \   'package'   : 'Agora',
    \},
    \ 'Alli' : {
    \   'directory' : [ 'allisports' ],
    \   'category'  : 'OmniTICMS',
    \},
    \ 'Corpweb' : {
    \   'directory' : [ 'omniti-web-node' ],
    \},
    \ 'DBMail' : {
    \   'directory' : [ 'dbmail' ],
    \   'category'  : 'DigitalBranding',
    \},
    \ 'DermApproved' : {
    \   'directory' : [ 'dermapproved' ],
    \   'category'  : 'DermApproved',
    \},
    \ 'DevOpsDictionary' : {
    \   'directory' : [ 'devopsdict' ],
    \   'category'  : 'DevOpsDictionary',
    \},
    \ 'DoodleDeals' : {
    \   'directory' : [ 'doodledeals' ],
    \   'category'  : 'DoodleDeals',
    \},
    \ 'EFS' : {
    \   'directory' : [ 'EFS2' ],
    \   'package'   : 'EFS2',
    \},
    \ 'fork_daemon' : {
    \   'directory' : [ 'forkdaemon-php' ],
    \   'category'  : 'system',
    \   'package'   : 'fork_daemon',
    \},
    \ 'HPHome' : {
    \   'directory' : [ 'hphome' ],
    \   'category'  : 'HPHome',
    \},
    \ 'NatGeo' : {
    \   'directory' : [ 'nge', 'nge-static' ],
    \   'category'  : 'NatGeo',
    \},
    \ 'OmniCMS' : {
    \   'directory' : [ 'omnicms' ],
    \   'category'  : 'OmniCMS',
    \},
    \ 'OmniTI-www' : {
    \   'directory' : [ 'corpweb' ],
    \   'category'  : 'OmniTI-www',
    \},
    \ 'OraTV' : {
    \   'directory' : [ 'ora' ],
    \   'category'  : 'Ora',
    \},
    \ 'PTP' : {
    \   'directory' : [ 'pass-the-plate' ],
    \   'category'  : 'PTP',
    \},
    \ 'Rainbow' : {
    \   'directory' : [ 'rrc' ],
    \   'category'  : 'Rainbow',
    \},
    \ 'SoulCycle' : {
    \   'directory' : [],
    \   'category'  : 'SoulCycle',
    \},
    \ 'Taubman' : {
    \   'directory' : [ 'taubman' ],
    \   'category'  : 'Taubman',
    \},
    \ 'Taskman' : {
    \   'directory' : [ 'taskman' ],
    \   'category'  : 'Taskman',
    \},
    \ 'TaubmanCrawler' : {
    \   'directory' : [ 'url-finder' ],
    \   'category'  : 'Taubman',
    \},
    \ 'Wikipedia' : {
    \   'directory' : [ 'mediawiki', 'wiki-commit', 'wiki-internal', 'wiki-external' ],
    \   'category'  : 'MediaWiki',
    \   'package'   : 'ArticleFeedback',
    \},
\}

" }}}
" {{{ Functions

" {{{ Surround visual selection with text - Tip #988

" Surround // Main Function
fun! Surround(s1, s2) range
    exe "normal vgvmboma\<ESC>"
    normal `a
    let lineA = line(".")
    let columnA = col(".")

    normal `b
    let lineB = line(".")
    let columnB = col(".")

    " exchange marks
    if lineA > lineB || lineA <= lineB && columnA > columnB
    " save b in c
    normal mc
    " store a in b
    normal `amb
    " set a to old b
    normal `cma
    endif

    exe "normal `ba" . a:s2 . "\<ESC>`ai" . a:s1 . "\<ESC>"
endfun

" Surround // XML-Specific Function
fun! XMLSurround(tagname) range
    call Surround("<".a:tagname."\>", "</".a:tagname.">")
endfun

" Surround // Commands
" Example:
" :'<,'>Sur (<\ - -\ >)
" yeilds
" bla bla (< -Selected Text- >) bla bla
command! -range -nargs=* Sur call Surround(<f-args>)
" Example:
" :'<,'>Xtags tagname
" yeilds
" bla bla <tagname>Selected Text</tagname> bla bla
command! -range -nargs=* Xtags call XMLSurround(<f-args>)

" }}}
" {{{ 20060125 (rsterbin) Set up folds (but not in diff mode)

" Folds // fold when all methods are surrounded by fold markers
fun! FoldMarkedFiles()
    set foldmethod=marker
    set foldlevel=0
    set foldcolumn=0
    nnoremap <leader>z0 :set foldlevel=0<CR>
    nnoremap <leader>z1 :set foldlevel=1<CR>
    nnoremap <leader>z2 :set foldlevel=2<CR>
    nnoremap <leader>zy :set invfoldenable<CR>
    exe "normal ggzjzazz"
endfun

" Folds // fold when methods are not surrounded by fold markers
fun! FoldUnmarkedFiles()
    let php_folding=0
    EnableFastPHPFolds
    try
        exe "normal /^class\\|^abstract class\\|^interface\<CR>"
        exe "normal zozj"
    catch
        try
            exe "normal Mza"
        catch
            " no folds; just go to the middle line
            exe "normal M"
        endtry
    endtry
endfun

" }}}
" {{{ 20060127 (rsterbin) Set indention on xml and html files

fun! XMLIndent()
    setlocal expandtab
    setlocal tabstop=2
    setlocal softtabstop=2
    setlocal shiftwidth=2
endfun

" }}}
" {{{ 20070820 (rsterbin) Add a docblock to a method

fun! AddDocBlock()
    let blankdocblock =
        \" /**\n" .
        \" * Method description...\n" .
        \" *\n" .
        \" * @since version\n" .
        \" *\n" .
        \" * @param type $param description...\n" .
        \" * @return type description...\n" .
        \" * @throws type\n" .
        \" */"
    exe "normal k"
    let string = blankdocblock
    let pos = line('.')
    while 1
        let len = stridx(string, "\n")
        if len == -1
            call append(pos, string)
            break
        endif
        call append(pos, strpart(string, 0, len))
        let pos = pos + 1
        let string = strpart(string, len + 1)
    endwhile
    exe "normal jj^w"
endfun

" }}}
" {{{ 20120612 (rsterbin) Default class finder function

fun! g:Project_Open_Default()
    let filepath = substitute(@", '::', '/', 'g') . '.php'
    exe ':e ' . filepath
endfun

" }}}
" {{{ 20120612 (rsterbin) Default dump function

fun! g:Project_Dump_Default()
    let blank = "print '<pre style=\"color: red;\">' . \"\\n\"; var_dump(); print '</pre>' . \"\\n\";"
    let pos = line('.')
    call append(pos, blank)
    exe "normal j$9b"
endfun

" }}}
" {{{ 20120612 (rsterbin) Open the class file in the @ register

fun! g:Project_OpenClassFile()
    let cp = b:current_project
    try
        exec "call " . g:project_info[cp]['open_func'] . "()"
    catch
        exec "call g:Project_Open_Default()"
    endtry
endfun

" }}}
" {{{ 20120612 (rsterbin) Insert a dump line

fun! g:Project_AddDumpLine()
    let cp = b:current_project
    try
        exec "call " . g:project_info[cp]['dump_func'] . "()"
    catch
        exec "call g:Project_Dump_Default()"
    endtry
endfun

" }}}

" }}}
" {{{ Syntax highlighting

" Syntax *always* on!
syntax on

" Colors are better on 256 if we use the light background option
set background=light

" Use cyan for comments, so they don't look like anything else
hi! Comment term=bold ctermfg=Cyan guifg=Blue

" Folded sections aren't legible with the lighter blue I use in my terminal
" windows, so set them to yellow and black.
hi Folded term=bold ctermfg=Brown ctermbg=Black
hi FoldColumn term=bold ctermfg=Brown ctermbg=Black

" Diffs have crappy colors
highlight DiffAdd cterm=NONE ctermfg=Black ctermbg=Green gui=NONE guifg=Black guibg=Green
highlight DiffDelete cterm=NONE ctermfg=Black ctermbg=Red gui=NONE guifg=Black guibg=Red
highlight DiffChange cterm=NONE ctermfg=Black ctermbg=Yellow gui=NONE guifg=Black guibg=Yellow
highlight DiffText cterm=NONE ctermfg=Black ctermbg=Magenta gui=NONE guifg=Black guibg=Magenta

" }}}
" {{{ AutoCommands

" Set the colors for vim on "xterm"
if &term=="xterm"
set t_Co=8
set t_AB=[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm
set t_AF=[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm
endif

" Set the colors for vim on "ansi"
if &term=="ansi"
set t_Co=8
set t_AB=[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm
set t_AF=[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm
endif

" Set up XML indentation on xml, html, and tpl files
au FileType xml call XMLIndent()
au FileType tpl call XMLIndent()

" Linting
autocmd FileType php let b:dispatch = 'php -l %'
autocmd FileType python compiler pylint
autocmd FileType python let b:dispatch = 'pylint %'


" }}}

