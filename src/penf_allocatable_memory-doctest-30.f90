program volatile_doctest
use penf_allocatable_memory
 use penf
 integer(I4P), allocatable :: a(:,:)
 integer(I4P)              :: ulb(2,2)=reshape([1,1, &
                                                1,2],&
                                               [2,2])
 call allocate_variable(a, ulb)
 print*, allocated(a)
endprogram volatile_doctest