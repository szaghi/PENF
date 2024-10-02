program volatile_doctest
use penf_allocatable_memory
 use penf
 real(R4P), allocatable :: a(:), b(:)
 allocate(b(1:1))
 call assign_allocatable(a, b)
 print*, allocated(a)
endprogram volatile_doctest