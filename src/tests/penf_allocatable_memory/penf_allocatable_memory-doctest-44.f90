program volatile_doctest
use penf_allocatable_memory
 use penf
 integer(I1P), allocatable :: a(:,:)
 integer(I4P) :: ulb(2,2)=reshape([1,1, &
 1,2],&
 [2,2])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
endprogram volatile_doctest