program volatile_doctest
use penf_allocatable_memory
 use penf
 integer(I4P), allocatable :: a(:,:,:,:,:)
 integer(I4P) :: ulb(2,5)=reshape([1,1, &
 1,2, &
 1,3, &
 1,4, &
 1,5],&
 [2,5])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
endprogram volatile_doctest