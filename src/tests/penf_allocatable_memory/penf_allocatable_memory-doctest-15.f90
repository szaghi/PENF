program volatile_doctest
use penf_allocatable_memory
 use penf
 real(R4P), allocatable :: a(:)
 integer(I4P)           :: ulb(2)=[1,1]
 call allocate_variable(a, ulb)
 print*, allocated(a)
endprogram volatile_doctest