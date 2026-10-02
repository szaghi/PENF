program volatile_doctest
use penf_stringify
 use penf
 real(R4P) :: x(1:5)
 integer :: i
 logical :: exact
 x = [huge(1._R4P), tiny(1._R4P), 0.1_R4P, -1._R4P/3._R4P, 0._R4P]
 exact = .true.
 do i=1, 5
 exact = exact.and.(cton(str=str(n=x(i)), knd=1._R4P)==x(i))
 exact = exact.and.(cton(str=str(n=x(i), compact=.true.), knd=1._R4P)==x(i))
 enddo
 print "(L1)", exact
endprogram volatile_doctest