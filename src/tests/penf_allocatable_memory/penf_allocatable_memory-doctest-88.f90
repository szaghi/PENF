program volatile_doctest
use penf_allocatable_memory
 use penf
 integer(I2P), allocatable :: a(:,:,:,:), b(:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4))
 call assign_allocatable(a, b)
 print*, allocated(a)
endprogram volatile_doctest