program volatile_doctest
use penf_allocatable_memory
 use penf
 real(R16P), allocatable :: a(:,:,:,:,:), b(:,:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4,1:5))
 call assign_allocatable(a, b)
 print*, allocated(a)
endprogram volatile_doctest