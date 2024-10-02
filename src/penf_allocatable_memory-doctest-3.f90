program volatile_doctest
use penf_allocatable_memory
 use penf
 real(R16P), allocatable :: a(:,:,:)
 integer(I4P)            :: ulb(2,3)=reshape([1,1, &
                                              1,2, &
                                              1,3],&
                                             [2,3])
 call allocate_variable(a, ulb)
 print*, allocated(a)
endprogram volatile_doctest