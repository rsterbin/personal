
" Strings and q, qq, qw and qr expressions

" Brackets in qq()
syn region perlBrackets    start=+(+ end=+)+ contained transparent contains=perlBrackets,@perlStringSQ

syn region perlStringUnexpanded    matchgroup=perlStringStartEnd start="'" end="'" contains=@perlInterpSQ
syn region perlString        matchgroup=perlStringStartEnd start=+"+  end=+"+ contains=@perlInterpDQ
syn region perlQQ        matchgroup=perlStringStartEnd start=+\<q#+ end=+#+ contains=@perlInterpSQ
syn region perlQQ        matchgroup=perlStringStartEnd start=+\<q|+ end=+|+ contains=@perlInterpSQ
syn region perlQQ        matchgroup=perlStringStartEnd start=+\<q(+ end=+)+ contains=@perlInterpSQ,perlBrackets
syn region perlQQ        matchgroup=perlStringStartEnd start=+\<q{+ end=+}+ contains=@perlInterpSQ
syn region perlQQ        matchgroup=perlStringStartEnd start=+\<q/+ end=+/+ contains=@perlInterpSQ
syn region perlQQ        matchgroup=perlStringStartEnd start=+\<q[qx]#+ end=+#+ contains=@perlInterpDQ
syn region perlQQ        matchgroup=perlStringStartEnd start=+\<q[qx]|+ end=+|+ contains=@perlInterpDQ
syn region perlQQ        matchgroup=perlStringStartEnd start=+\<q[qx](+ end=+)+ contains=@perlInterpDQ,perlBrackets
syn region perlQQ        matchgroup=perlStringStartEnd start=+\<q[qx]{+ end=+}+ contains=@perlInterpDQ
syn region perlQQ        matchgroup=perlStringStartEnd start=+\<q[qx]/+ end=+/+ contains=@perlInterpDQ
syn region perlQQ        matchgroup=perlStringStartEnd start=+\<qw#+  end=+#+ contains=@perlInterpSQ
syn region perlQQ        matchgroup=perlStringStartEnd start=+\<qw|+  end=+|+ contains=@perlInterpSQ
syn region perlQQ        matchgroup=perlStringStartEnd start=+\<qw(+  end=+)+ contains=@perlInterpSQ,perlBrackets
syn region perlQQ        matchgroup=perlStringStartEnd start=+\<qw{+  end=+}+ contains=@perlInterpSQ
syn region perlQQ        matchgroup=perlStringStartEnd start=+\<qw/+  end=+/+ contains=@perlInterpSQ
syn region perlQQ        matchgroup=perlStringStartEnd start=+\<qr#+  end=+#[imosx]*+ contains=@perlInterpMatch
syn region perlQQ        matchgroup=perlStringStartEnd start=+\<qr|+  end=+|[imosx]*+ contains=@perlInterpMatch
syn region perlQQ        matchgroup=perlStringStartEnd start=+\<qr(+  end=+)[imosx]*+ contains=@perlInterpMatch
syn region perlQQ        matchgroup=perlStringStartEnd start=+\<qr{+  end=+}[imosx]*+ contains=@perlInterpMatch
syn region perlQQ        matchgroup=perlStringStartEnd start=+\<qr/+  end=+/[imosx]*+ contains=@perlInterpSlash

