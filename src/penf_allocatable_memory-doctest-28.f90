program volatile_doctest
use penf_allocatable_memory
 use penf
 integer(I8P), allocatable :: a(:,:,:,:,:,:,:)
 integer(I4P)              :: ulb(2,7)=reshape([1,1, &
                                                1,2, &
                                                1,3, &
                                                1,4, &
                                                1,5, &
                                                1,6, &
                                                1,7],&
                                               [2,7])
 call allocate_variable(a, ulb)
 print*, allocated(a)
endprogram volatile_doctest