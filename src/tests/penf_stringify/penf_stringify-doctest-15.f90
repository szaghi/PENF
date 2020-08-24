#if defined _R16P
program volatile_doctest
use penf_stringify
 use penf
 print "(A)", str(n=-1._R16P, no_sign=.true.)
endprogram volatile_doctest
#endif
