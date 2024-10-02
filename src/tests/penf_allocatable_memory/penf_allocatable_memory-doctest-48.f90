program volatile_doctest
use penf_allocatable_memory
 use penf
 integer(I1P), allocatable :: a(:,:,:,:,:,:)
 integer(I4P)              :: ulb(2,6)=reshape([1,1, &
                                                1,2, &
                                                1,3, &
                                                1,4, &
                                                1,5, &
                                                1,6],&
                                               [2,6])
 call allocate_variable(a, ulb)
 print*, allocated(a)
endprogram volatile_doctest