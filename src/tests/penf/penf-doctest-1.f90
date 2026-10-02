program volatile_doctest
use penf
 use penf
 integer(I1P) :: bytes(1:4)
 call check_endian
 bytes = transfer(1_I4P, bytes)
 print "(L1)", (endian==endianL).eqv.(bytes(1)==1_I1P)
endprogram volatile_doctest