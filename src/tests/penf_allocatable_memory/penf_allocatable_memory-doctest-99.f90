program volatile_doctest
use penf_allocatable_memory
 use penf
 real(R8P), allocatable :: a(:,:,:)
 integer(I8P) :: mem_free_1, mem_free_2, mem_total
 logical :: is_present
 integer(I4P) :: n, i, j, k
 call get_memory_info(mem_free_1, mem_total)
 inquire(file='/proc/meminfo', exist=is_present)
 if (is_present) then
 n = 800
 allocate(a(1:n,1:n,1:n))
 else
 print*, .true.
 stop
 endif
 a = 1._R8P
 do k=2, n
 do j=2, n
 do i=2, n
 a(i,j,k) = 1._R8P / 2._R8P * exp(a(i-1,j,k)) - a(i-1,j,k)
 enddo
 enddo
 enddo
 call get_memory_info(mem_free_2, mem_total)
 print*, mem_free_1 > mem_free_2
endprogram volatile_doctest