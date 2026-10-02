program volatile_doctest
use penf_stringify
 use penf
 real(R16P) :: x(1:5)
 integer :: i
 logical :: exact
 x = [huge(1._R16P), tiny(1._R16P), 0.1_R16P, -1._R16P/3._R16P, 0._R16P]
 exact = .true.
 do i=1, 5
 exact = exact.and.(cton(str=str(n=x(i)), knd=1._R16P)==x(i))
 exact = exact.and.(cton(str=str(n=x(i), compact=.true.), knd=1._R16P)==x(i))
 enddo
 print "(L1)", exact
endprogram volatile_doctest