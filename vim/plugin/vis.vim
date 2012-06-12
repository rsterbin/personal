" vis.vim:
" Function:	Perform an Ex command on a visual highlighted block (CTRL-V).
" Version:	15
" Date:		Feb 01, 2005
" GetLatestVimScripts: 1066 1 cecutil.vim
" GetLatestVimScripts: 1195 1 :AutoInstall: vis.vim

" ---------------------------------------------------------------------
"  Details: {{{1
" Requires: Requires 6.0 or later  (this script is a plugin)
"           Requires <cecutil.vim> (see :he vis-required)
"
" Usage:    Mark visual block (CTRL-V) or visual character (v),
"           press ':B ' and enter an Ex command [cmd].
"
"           ex. Use ctrl-v to visually mark the block then use
"                 :B cmd     (will appear as   :'<,'>B cmd )
"
"           ex. Use v to visually mark the block then use
"                 :B cmd     (will appear as   :'<,'>B cmd )
"
"           Command-line completion is supported for Ex commands.
"
" Note:     There must be a space before the '!' when invoking external shell
"           commands, eg. ':B !sort'. Otherwise an error is reported.
"
" Author:   Charles E. Campbell <NdrchipO@ScampbellPfamily.AbizM> - NOSPAM
"           Based on idea of Stefan Roemer <roemer@informatik.tu-muenchen.de>
"
" ------------------------------------------------------------------------------
" Initialization: {{{1

" Exit quickly when <Vis.vim> has already been loaded or
" when 'compatible' is set
if &cp || exists("g:loaded_vis")
  finish
endif
let g:loaded_vis= "v15"

" ------------------------------------------------------------------------------
" Public Interface: {{{1
"  -range       : VisBlockCmd operates on the range itself
"  -com=command : Ex command and arguments
"  -nargs=+     : arguments may be supplied, up to any quantity
com! -range -nargs=+ -com=command    B  silent <line1>,<line2>call s:VisBlockCmd('<args>')
"com! -range -nargs=+ -com=expression R  silent <line1>,<line2>call s:VisBlockSearch('<args>','b')
com! -range -nargs=* -com=expression S  silent <line1>,<line2>call s:VisBlockSearch('<args>')

" Suggested by Hari
" Visual-mode restricted searches
vn / <esc>/<c-r>=<SID>VisBlockSearch()<cr>
vn ? <esc>?<c-r>=<SID>VisBlockSearch()<cr>

" ------------------------------------------------------------------------------
" VisBlockCmd: {{{1
fun! <SID>VisBlockCmd(cmd) range
"  call Dfunc("VisBlockCmd(cmd<".a:cmd.">")

  " retain and re-use same visual mode
  norm `<
  let curposn = SaveWinPosn()
  let vmode   = visualmode()
"  call Decho("vmode<".vmode.">")

  " save options which otherwise may interfere
  let keep_lz    = &lz
  let keep_fen   = &fen
  let keep_ic    = &ic
  let keep_magic = &magic
  let keep_sol   = &sol
  let keep_ve    = &ve
  let keep_ww    = &ww
  set lz
  set magic
  set nofen
  set noic
  set nosol
  set ve=
  set ww=

  " Save any contents in register a
  let rega= @a

  if vmode == 'V'
"   call Decho("cmd<".a:cmd.">")
   exe "'<,'>".a:cmd
  else

   " Initialize so begcol<endcol for non-v modes
   let begcol   = s:VirtcolM1("<")
   let endcol   = s:VirtcolM1(">")
   if vmode != 'v'
    if begcol > endcol
     let begcol  = s:VirtcolM1(">")
     let endcol  = s:VirtcolM1("<")
    endif
   endif

   " Initialize so that begline<endline
   let begline  = a:firstline
   let endline  = a:lastline
   if begline > endline
    let begline = a:lastline
    let endline = a:firstline
   endif
"   call Decho('beg['.begline.','.begcol.'] end['.endline.','.endcol.']')

   " =======================
   " Modify Selected Region:
   " =======================
   " 1. delete selected region into register "a
"   call Decho("delete selected region into register a")
   norm! gv"ad

   " 2. put cut-out text at end-of-file
"   call Decho("put cut-out text at end-of-file")
   $
   pu_
   let lastline= line("$")
   silent norm! "ap
"   call Decho("reg-A<".@a.">")

   " 3. apply command to those lines
"   call Decho("apply command to those lines")
   exe '.,$'.a:cmd

   " 4. visual-block select the modified text in those lines
"   call Decho("visual-block select modified text at end-of-file")
   exe lastline
   exe "norm! 0".vmode."G$\"ad"

   " 5. delete excess lines
"   call Decho("delete excess lines")
   silent exe lastline.',$d'

   " 6. put modified text back into file
"   call Decho("put modifed text back into file (beginning=".begline.".".begcol.")")
   exe begline
   if begcol > 1
    exe 'norm! '.begcol."\<bar>\"ap"
   elseif begcol == 1
    norm! 0"ap
   else
    norm! 0"aP
   endif

   " 7. attempt to restore gv -- this is limited, it will
   " select the same size region in the same place as before,
   " not necessarily the changed region
   let begcol= begcol+1
   let endcol= endcol+1
   silent exe begline
   silent exe 'norm! '.begcol."\<bar>".vmode
   silent exe endline
   silent exe 'norm! '.endcol."\<bar>\<esc>"
   silent exe begline
   silent exe 'norm! '.begcol."\<bar>"
  endif

  " restore register a and options
"  call Decho("restore register a, options, and window pos'n")
  let @a  = rega
  let &lz = keep_lz
  let &fen= keep_fen
  let &ic = keep_ic
  let &sol= keep_sol
  let &ve = keep_ve
  let &ww = keep_ww
  call RestoreWinPosn(curposn)

"  call Dret("VisBlockCmd")
endfun

" ------------------------------------------------------------------------------
" VisBlockSearch: {{{1
fun! <SID>VisBlockSearch(...) range
"  call Dfunc("VisBlockSearch() a:0=".a:0." lines[".a:firstline.",".a:lastline."]")
  if a:0 >= 1
   let pattern   = a:1
   let s:pattern = pattern
  elseif exists("s:pattern")
   let pattern= s:pattern
  else
   let pattern   = @/
   let s:pattern = pattern
  endif
  let vmode= visualmode()

  " collect search restrictions
  let firstline  = line("'<")
  let lastline   = line("'>")
  let firstcolm1 = s:VirtcolM1("<")
  let lastcolm1  = s:VirtcolM1(">")
"  call Decho("1: firstline=".firstline." lastline=".lastline." firstcolm1=".firstcolm1." lastcolm1=".lastcolm1)

  if(firstline > lastline)
   let firstline = line("'>")
   let lastline  = line("'<")
   if a:0 >= 1
    norm! `>
   endif
  else
   if a:0 >= 1
    norm! `<
   endif
  endif
"  call Decho("2: firstline=".firstline." lastline=".lastline." firstcolm1=".firstcolm1." lastcolm1=".lastcolm1)

  if vmode != 'v'
   if firstcolm1 > lastcolm1
   	let tmp        = firstcolm1
   	let firstcolm1 = lastcolm1
   	let lastcolm1  = tmp
   endif
  endif
"  call Decho("3: firstline=".firstline." lastline=".lastline." firstcolm1=".firstcolm1." lastcolm1=".lastcolm1)

  let firstlinem1 = firstline  - 1
  let lastlinep1  = lastline   + 1
  let firstcol    = firstcolm1 + 1
  let lastcol     = lastcolm1  + 1
  let lastcolp1   = lastcol    + 1
"  call Decho("4: firstline=".firstline." lastline=".lastline." firstcolm1=".firstcolm1." lastcolp1=".lastcolp1)

  " construct search string
  if vmode == 'V'
   let srch= '\%(\%>'.firstlinem1.'l\%<'.lastlinep1.'l\)\&'
"   call Decho("V  srch: ".srch)
  elseif vmode == 'v'
   let srch= '\%(\%(\%'.firstline.'l\%>'.firstcolm1.'v\)\|\%(\%'.lastline.'l\%<'.lastcolp1.'v\)\|\%(\%>'.firstline.'l\%<'.lastline.'l\)\)\&'
"   call Decho("v  srch: ".srch)
  else
   let srch= '\%(\%>'.firstline.'l\%>'.firstcolm1.'v\%<'.lastlinep1.'l\%<'.lastcolp1.'v\)\&'
"   call Decho("^v srch: ".srch)
  endif

  " perform search
  if a:0 <= 1
"   call Decho("Search forward: <".srch.pattern.">")
   call search(srch.pattern)
   let @/= srch.pattern
"   call Dret("VisBlockSearch")

  elseif a:0 == 2
"   call Decho("Search backward: <".srch.pattern.">")
   call search(srch.pattern,a:2)
   let @/= srch.pattern
  else
"   call Dret("VisBlockSearch <".srch.">")
   return srch
  endif

endfun

" ------------------------------------------------------------------------------
" VirtcolM1: usually a virtcol(mark)-1, but due to tabs this can be different {{{1
fun! s:VirtcolM1(mark)
"  call Dfunc("VirtcolM1(mark ".a:mark.")")
  let mark="'".a:mark

  if virtcol(mark) <= 1
"   call Dret("VirtcolM1 0")
   return 0
  endif
"  call Decho("exe norm! `".a:mark."h")
  exe "norm! `".a:mark."h"

"  call Dret("VirtcolM1 ".virtcol("."))
  return virtcol(".")
endfun

" ------------------------------------------------------------------------------
